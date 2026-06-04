# Simulate resource competition among artificial agents

Simulates agents moving in a square world and gaining energy from
spatially distributed resources. Resources regenerate at each time step.

## Usage

``` r
simulate_resource_competition(
  n_agents = 50,
  steps = 50,
  world_size = 1,
  n_resources = 30,
  resource_regen = 0.2,
  consumption_rate = 0.1,
  movement_cost = 0.02,
  seed = NULL
)
```

## Arguments

- n_agents:

  Number of agents.

- steps:

  Number of time steps.

- world_size:

  Size of the square world.

- n_resources:

  Number of resource patches.

- resource_regen:

  Resource regeneration amount per step.

- consumption_rate:

  Maximum resource amount consumed by an agent per step.

- movement_cost:

  Energy cost per step.

- seed:

  Optional random seed.

## Value

A list with `agents`, `resources`, and `summary` data frames.
