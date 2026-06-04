# Simulate fitness-based selection

Selects agents based on a fitness column or computed fitness proxy.

## Usage

``` r
simulate_selection(
  agents,
  fitness_col = NULL,
  survival_fraction = 0.5,
  stochastic = TRUE,
  seed = NULL
)
```

## Arguments

- agents:

  Data frame of agents.

- fitness_col:

  Optional name of an existing fitness column.

- survival_fraction:

  Fraction of agents to keep.

- stochastic:

  If `TRUE`, selection is probabilistic. If `FALSE`, top agents are
  kept.

- seed:

  Optional random seed.

## Value

A data frame of selected agents with a `fitness` column.
