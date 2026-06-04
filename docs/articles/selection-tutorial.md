# Selection Tutorial

``` r
library(artificialLifeR)
```

## Purpose

This tutorial introduces
[`simulate_selection()`](https://noushinn.github.io/artificialLifeR/reference/simulate_selection.md).
Selection is a process in which some agents persist or reproduce more
than others because of differences in traits or fitness.

In this package, selection is simplified. It helps learners explore how
population composition can change when survival depends on energy,
efficiency, or a fitness proxy.

## Create agents

``` r
agents <- create_agents(
  n_agents = 80,
  seed = 6
)

summary(agents$efficiency)
#>    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
#>  0.1969  0.4230  0.4767  0.4825  0.5496  0.7068
```

## Apply selection

``` r
selected <- simulate_selection(
  agents,
  survival_fraction = 0.40,
  stochastic = FALSE,
  seed = 6
)

nrow(agents)
#> [1] 80
nrow(selected)
#> [1] 32
head(selected)
#>    agent          x         y   energy      speed efficiency
#> 17    17 0.51789573 0.5056782 1.148549 0.01593736  0.6723470
#> 64    64 0.61779527 0.7483514 1.198532 0.07897580  0.5720911
#> 37    37 0.38618286 0.4545822 1.006295 0.06575135  0.6694586
#> 15    15 0.76993170 0.9659677 1.014320 0.05411230  0.6633885
#> 13    13 0.09523258 0.3920638 1.177253 0.06594654  0.5512273
#> 3      3 0.26435207 0.3327492 1.334079 0.05862615  0.4783738
#>    reproduction_threshold age alive   fitness
#> 17               1.635668   0  TRUE 0.7722238
#> 64               1.506365   0  TRUE 0.6856696
#> 37               1.358510   0  TRUE 0.6736726
#> 15               1.604649   0  TRUE 0.6728883
#> 13               1.346680   0  TRUE 0.6489338
#> 3                1.433508   0  TRUE 0.6381886
```

## Compare before and after selection

``` r
rbind(
  before = measure_life_like_complexity(agents, trait_col = "efficiency"),
  after = measure_life_like_complexity(selected, trait_col = "efficiency")
)
#>         n unique_values  entropy      mean         sd temporal_variability
#> before 80            80 2.944390 0.4825008 0.09878952                   NA
#> after  32            32 3.031446 0.5632640 0.06906184                   NA
#>        mean_abs_change
#> before              NA
#> after               NA
```

## Plot energy before and after

``` r
comparison <- data.frame(
  group = c(rep("before", nrow(agents)), rep("after", nrow(selected))),
  energy = c(agents$energy, selected$energy),
  index = seq_len(nrow(agents) + nrow(selected))
)

head(comparison)
#>    group    energy index
#> 1 before 1.3912147     1
#> 2 before 0.9923440     2
#> 3 before 1.3340791     3
#> 4 before 0.9979192     4
#> 5 before 0.7678900     5
#> 6 before 0.7930166     6
```

## Stochastic selection

Selection is not always deterministic. In stochastic selection,
higher-fitness agents have a better chance of being selected, but chance
still matters.

``` r
stochastic_selected <- simulate_selection(
  agents,
  survival_fraction = 0.40,
  stochastic = TRUE,
  seed = 7
)

rbind(
  deterministic = measure_life_like_complexity(selected, trait_col = "fitness"),
  stochastic = measure_life_like_complexity(stochastic_selected, trait_col = "fitness")
)
#>                n unique_values  entropy      mean         sd
#> deterministic 32            32 2.742537 0.5901508 0.06185067
#> stochastic    32            32 3.123778 0.4900943 0.13647232
#>               temporal_variability mean_abs_change
#> deterministic                   NA              NA
#> stochastic                      NA              NA
```

## Interpretation

Selection changes the composition of the population. In deterministic
selection, the highest-fitness agents are kept. In stochastic selection,
fitter agents are more likely to persist, but lower-fitness agents may
sometimes remain.

This illustrates a key artificial-life idea:

> Population-level change can arise when individual differences affect
> survival or reproduction.

## Suggested exercises

- Change `survival_fraction` and compare results.
- Use deterministic and stochastic selection.
- Create a custom fitness column and select using `fitness_col`.
- Ask which traits become more common after selection.

## Responsible interpretation

This function illustrates selection in a simplified artificial system.
It does not model full natural selection, genetics, development, or
ecology.
