# Conway's game of life

The rules of the game are:

- Any live cell with fewer than two live neighbours dies, as if caused by under-population.
- Any live cell with two or three live neighbours lives on to the next generation.
- Any live cell with more than three live neighbours dies, as if by overcrowding.
- Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

More information here: http://en.wikipedia.org/wiki/Conway's_Game_of_Life

## How to use

```bash
$ ruby conways.rb <file>
```
__Files__

The files can be `glider.yml` or `oscillator.yml`


