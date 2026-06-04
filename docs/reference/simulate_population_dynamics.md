# Simulate simple artificial-life population dynamics

Simulates a population with energy gain, mortality, reproduction,
inheritance, mutation, and density constraints.

## Usage

``` r
simulate_population_dynamics(
  initial_population = 40,
  steps = 80,
  carrying_capacity = 120,
  resource_level = 1,
  death_threshold = 0,
  reproduction_threshold = 1.5,
  mutation_rate = 0.1,
  mutation_sd = 0.03,
  seed = NULL
)
```

## Arguments

- initial_population:

  Initial number of agents.

- steps:

  Number of time steps.

- carrying_capacity:

  Soft population capacity.

- resource_level:

  Baseline resource input per step.

- death_threshold:

  Agents at or below this energy die.

- reproduction_threshold:

  Energy threshold for reproduction.

- mutation_rate:

  Probability of mutation in offspring traits.

- mutation_sd:

  Standard deviation of mutation noise.

- seed:

  Optional random seed.

## Value

A list with `agents` history and `summary` data frames.
