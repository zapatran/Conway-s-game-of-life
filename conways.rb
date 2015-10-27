require 'yaml/store'

class Cell
  attr_accessor :state

  def initialize(state)
    @state = state # either 1 or 0 for alive or dead
  end

  def update(neighbours)
    alive_neighbours = 0
    neighbours.each { |cell| alive_neighbours += cell.state }
    if @state == 1 && (alive_neighbours < 2 || alive_neighbours > 3)
      @state = 0
    elsif @state == 0 && alive_neighbours == 3
      @state = 1
    end
  end

  def to_s
    @state == 1 ? "\u2593" : "\u2591"
  end
end

class Game
  def initialize(file)

    numbers = YAML::load_file(file)

    @current_grid = Array.new(numbers.length) { Array.new(numbers[0].length) { Cell.new(0) }}
    @previous_grid = Array.new(numbers.length) { Array.new(numbers[0].length) { Cell.new(0) }}

    numbers.each_with_index do |line, y|
      line.each_with_index do |number, x|
        @current_grid[y][x].state = number
      end
    end
  end

  def neighbours_of(grid, y, x)
    grid_height = grid.length
    grid_width = grid[0].length

    previousY = (y - 1 + grid_height) % grid_height
    nextY = (y + 1) % grid_height

    previousX = (x - 1 + grid_width) % grid_width
    nextX = (x + 1) % grid_width

    [ grid[ previousY ][ previousX ],
      grid[ previousY ][ x         ],
      grid[ previousY ][ nextX     ],
      grid[ y         ][ previousX ],
      grid[ y         ][ nextX     ],
      grid[ nextY     ][ previousX ],
      grid[ nextY     ][ x         ],
      grid[ nextY     ][ nextX     ]]
  end

  def update
    @current_grid, @previous_grid = @previous_grid, @current_grid
    @current_grid.each_with_index do |line, y|
      line.each_with_index do |cell, x|
        cell.state = @previous_grid[y][x].state
        cell.update(neighbours_of(@previous_grid, y, x))
      end
    end
  end

  def display
    @current_grid.each do |line|
      line.each do |cell|
        print cell
      end
      print "\n"
    end
    print "\n"
  end
end

if ARGV[0] == nil
  puts "Usage: ruby conways.rb <file>"
else
  game = Game.new(ARGV[0])
  while true
    system "clear"
    game.display
    sleep(0.5)
    game.update
  end
end
