# Measuring Life-like Complexity Tutorial

``` r
library(artificialLifeR)
```

## Purpose

This tutorial introduces
[`measure_life_like_complexity()`](https://noushinn.github.io/artificialLifeR/reference/measure_life_like_complexity.md).
Measuring life-like organization is difficult because life is not a
single variable. Artificial-life models may involve energy, traits,
reproduction, variation, selection, population change, and environmental
interaction.

The function provides educational summaries, not a universal life score.

## Measure agent traits

``` r
agents <- create_agents(
  n_agents = 60,
  seed = 1
)

measure_life_like_complexity(
  agents,
  trait_col = "efficiency"
)
#>    n unique_values  entropy      mean        sd temporal_variability
#> 1 60            60 2.894519 0.4914415 0.1052228                   NA
#>   mean_abs_change
#> 1              NA
```

## Measure resource competition

``` r
competition <- simulate_resource_competition(
  n_agents = 50,
  steps = 40,
  seed = 2
)

measure_life_like_complexity(
  competition$agents,
  trait_col = "energy",
  time_col = "step"
)
#>      n unique_values entropy     mean        sd temporal_variability
#> 1 2000          1999 2.90035 1.130187 0.5258798           0.06078271
#>   mean_abs_change
#> 1     0.005784354
```

## Measure population dynamics

``` r
pop <- simulate_population_dynamics(
  initial_population = 40,
  steps = 60,
  seed = 3
)

measure_life_like_complexity(
  pop$agents,
  trait_col = "efficiency",
  time_col = "step"
)
#>      n unique_values  entropy      mean        sd temporal_variability
#> 1 5731            46 2.881358 0.5864819 0.1215391           0.04399075
#>   mean_abs_change
#> 1     0.002700233
```

## Compare two scenarios

``` r
low_resource <- simulate_population_dynamics(
  initial_population = 40,
  steps = 60,
  resource_level = 0.5,
  seed = 3
)

high_resource <- simulate_population_dynamics(
  initial_population = 40,
  steps = 60,
  resource_level = 1.5,
  seed = 3
)

rbind(
  low_resource = measure_life_like_complexity(low_resource$agents, trait_col = "efficiency", time_col = "step"),
  high_resource = measure_life_like_complexity(high_resource$agents, trait_col = "efficiency", time_col = "step")
)
#>                  n unique_values  entropy      mean        sd
#> low_resource  4351            52 3.028995 0.5806586 0.1227309
#> high_resource 6246            47 2.976256 0.5880627 0.1205562
#>               temporal_variability mean_abs_change
#> low_resource            0.04272831     0.002630686
#> high_resource           0.04585395     0.002396770
```

## Interpretation

The metrics summarize selected features of a trait or variable. Entropy
can summarize diversity. Standard deviation can summarize variation.
Temporal metrics summarize change over time.

These summaries are useful, but they do not prove that a system is
alive.

## Good uses

Use the function to:

- compare trait variation;
- summarize energy changes;
- compare population scenarios;
- support visual interpretation;
- ask better questions about artificial-life dynamics.

## Poor uses

Do not use the function to claim:

- that life has been fully measured;
- that one toy model is truly alive;
- that entropy alone captures life-like organization;
- that the model replaces biological theory.

## Suggested exercises

- Measure `energy`, `efficiency`, and `speed` in the same simulation.
- Compare low and high mutation rates.
- Compare low and high resource levels.
- Ask which metric best matches the visual output.

## Key takeaway

[`measure_life_like_complexity()`](https://noushinn.github.io/artificialLifeR/reference/measure_life_like_complexity.md)
summarizes selected features of artificial-life outputs. It is an
interpretive aid, not a final definition of life or complexity.
