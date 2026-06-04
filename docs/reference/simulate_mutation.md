# Apply mutation to a numeric trait

Adds random variation to a selected numeric trait and optionally bounds
the result.

## Usage

``` r
simulate_mutation(
  agents,
  trait = "efficiency",
  mutation_rate = 0.1,
  mutation_sd = 0.05,
  lower = NULL,
  upper = NULL,
  seed = NULL
)
```

## Arguments

- agents:

  Data frame of agents.

- trait:

  Name of the numeric trait to mutate.

- mutation_rate:

  Probability that each row mutates.

- mutation_sd:

  Standard deviation of mutation noise.

- lower:

  Optional lower bound.

- upper:

  Optional upper bound.

- seed:

  Optional random seed.

## Value

A modified data frame with the selected trait mutated.
