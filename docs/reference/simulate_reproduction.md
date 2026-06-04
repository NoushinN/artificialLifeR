# Simulate reproduction with simple inheritance

Agents above an energy threshold create offspring. Offspring inherit
traits from parents with optional mutation.

## Usage

``` r
simulate_reproduction(
  agents,
  energy_col = "energy",
  threshold_col = "reproduction_threshold",
  mutation_rate = 0.1,
  mutation_sd = 0.03,
  max_offspring = 1,
  seed = NULL
)
```

## Arguments

- agents:

  Data frame of agents.

- energy_col:

  Name of the energy column.

- threshold_col:

  Name of the reproduction threshold column.

- mutation_rate:

  Probability of mutation for inherited traits.

- mutation_sd:

  Standard deviation of mutation noise.

- max_offspring:

  Maximum offspring per parent.

- seed:

  Optional random seed.

## Value

A data frame containing parents and offspring.
