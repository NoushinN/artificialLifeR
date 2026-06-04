# Reproduction and Mutation Tutorial

``` r
library(artificialLifeR)
```

## Purpose

This tutorial introduces
[`simulate_reproduction()`](https://noushinn.github.io/artificialLifeR/reference/simulate_reproduction.md)
and
[`simulate_mutation()`](https://noushinn.github.io/artificialLifeR/reference/simulate_mutation.md).
Reproduction and mutation are central to artificial life because they
allow traits to persist and vary across generations.

The goal is to show how offspring inherit traits and how mutation
introduces variation.

## Create agents

``` r
agents <- create_agents(
  n_agents = 30,
  energy_mean = 1.8,
  seed = 4
)

head(agents)
#>   agent           x         y   energy      speed efficiency
#> 1     1 0.585800305 0.5671122 1.823020 0.02862954  0.3722340
#> 2     2 0.008945796 0.2389489 1.957790 0.07128901  0.4201988
#> 3     3 0.293739612 0.8779959 1.686868 0.02374556  0.5159082
#> 4     4 0.277374958 0.6545220 1.577672 0.09127389  0.5614798
#> 5     5 0.813574215 0.4823709 1.929170 0.05262766  0.5687948
#> 6     6 0.260427771 0.9710298 1.739322 0.04536623  0.4952949
#>   reproduction_threshold age alive
#> 1               1.486676   0  TRUE
#> 2               1.400023   0  TRUE
#> 3               1.687376   0  TRUE
#> 4               1.466261   0  TRUE
#> 5               1.597327   0  TRUE
#> 6               1.598783   0  TRUE
```

## Simulate reproduction

``` r
offspring_pop <- simulate_reproduction(
  agents,
  mutation_rate = 0.10,
  mutation_sd = 0.03,
  seed = 4
)

nrow(agents)
#> [1] 30
nrow(offspring_pop)
#> [1] 58
head(offspring_pop)
#>   agent           x         y    energy      speed efficiency
#> 1     1 0.585800305 0.5671122 0.9115098 0.02862954  0.3722340
#> 2     2 0.008945796 0.2389489 0.9788949 0.07128901  0.4201988
#> 3     3 0.293739612 0.8779959 1.6868683 0.02374556  0.5159082
#> 4     4 0.277374958 0.6545220 0.7888358 0.09127389  0.5614798
#> 5     5 0.813574215 0.4823709 0.9645849 0.05262766  0.5687948
#> 6     6 0.260427771 0.9710298 0.8696610 0.04536623  0.4952949
#>   reproduction_threshold age alive
#> 1               1.486676   0  TRUE
#> 2               1.400023   0  TRUE
#> 3               1.687376   0  TRUE
#> 4               1.466261   0  TRUE
#> 5               1.597327   0  TRUE
#> 6               1.598783   0  TRUE
```

## Interpretation

Agents with enough energy can produce offspring. Offspring inherit
traits from parents, with optional mutation. This is a simplified
representation of inheritance, not a full biological reproduction model.

## Apply mutation to one trait

``` r
mutated <- simulate_mutation(
  agents,
  trait = "efficiency",
  mutation_rate = 0.50,
  mutation_sd = 0.08,
  lower = 0.01,
  upper = 1,
  seed = 5
)

head(mutated)
#>   agent           x         y   energy      speed efficiency
#> 1     1 0.585800305 0.5671122 1.823020 0.02862954  0.3611151
#> 2     2 0.008945796 0.2389489 1.957790 0.07128901  0.4201988
#> 3     3 0.293739612 0.8779959 1.686868 0.02374556  0.5159082
#> 4     4 0.277374958 0.6545220 1.577672 0.09127389  0.5136947
#> 5     5 0.813574215 0.4823709 1.929170 0.05262766  0.3940775
#> 6     6 0.260427771 0.9710298 1.739322 0.04536623  0.4952949
#>   reproduction_threshold age alive
#> 1               1.486676   0  TRUE
#> 2               1.400023   0  TRUE
#> 3               1.687376   0  TRUE
#> 4               1.466261   0  TRUE
#> 5               1.597327   0  TRUE
#> 6               1.598783   0  TRUE
```

## Compare trait summaries

``` r
rbind(
  original = measure_life_like_complexity(agents, trait_col = "efficiency"),
  mutated = measure_life_like_complexity(mutated, trait_col = "efficiency")
)
#>           n unique_values  entropy      mean         sd temporal_variability
#> original 30            30 2.990759 0.5065472 0.09620988                   NA
#> mutated  30            30 3.057426 0.5154198 0.10882956                   NA
#>          mean_abs_change
#> original              NA
#> mutated               NA
```

## Compare low and high mutation rates

``` r
low_mutation <- simulate_mutation(
  agents,
  trait = "efficiency",
  mutation_rate = 0.05,
  mutation_sd = 0.08,
  lower = 0.01,
  upper = 1,
  seed = 5
)

high_mutation <- simulate_mutation(
  agents,
  trait = "efficiency",
  mutation_rate = 0.80,
  mutation_sd = 0.08,
  lower = 0.01,
  upper = 1,
  seed = 5
)

rbind(
  low_mutation = measure_life_like_complexity(low_mutation, trait_col = "efficiency"),
  high_mutation = measure_life_like_complexity(high_mutation, trait_col = "efficiency")
)
#>                n unique_values  entropy      mean         sd
#> low_mutation  30            30 2.990759 0.5065472 0.09620988
#> high_mutation 30            30 2.919369 0.5313225 0.11819427
#>               temporal_variability mean_abs_change
#> low_mutation                    NA              NA
#> high_mutation                   NA              NA
```

## Interpretation of mutation

Mutation introduces trait variation. Without variation, selection has
little material to act on. With too much mutation, inherited structure
may become unstable.

A careful interpretation is:

> Mutation changes trait distributions in the artificial population.

not:

> Mutation alone creates biological evolution.

## Suggested exercises

- Change `mutation_sd` and observe trait variability.
- Mutate `speed` instead of `efficiency`.
- Increase initial energy and observe reproduction.
- Ask how inheritance and variation work together.

## Key takeaway

[`simulate_reproduction()`](https://noushinn.github.io/artificialLifeR/reference/simulate_reproduction.md)
and
[`simulate_mutation()`](https://noushinn.github.io/artificialLifeR/reference/simulate_mutation.md)
provide simplified tools for exploring inheritance and variation.
Together, they help illustrate how artificial populations can change
across generations.
