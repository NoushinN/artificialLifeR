# Create a simple population of artificial agents

Creates a data frame of agents with positions, energy, speed,
efficiency, and reproduction threshold.

## Usage

``` r
create_agents(
  n_agents = 50,
  world_size = 1,
  energy_mean = 1,
  energy_sd = 0.15,
  trait_sd = 0.1,
  seed = NULL
)
```

## Arguments

- n_agents:

  Number of agents.

- world_size:

  Size of the square world. Positions range from 0 to `world_size`.

- energy_mean:

  Mean initial energy.

- energy_sd:

  Standard deviation of initial energy.

- trait_sd:

  Standard deviation used for speed and efficiency traits.

- seed:

  Optional random seed.

## Value

A data frame with one row per agent.
