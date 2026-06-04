# Measure simple life-like complexity summaries

Computes educational summaries such as unique values, Shannon entropy,
mean, standard deviation, temporal variability, and mean absolute
change.

## Usage

``` r
measure_life_like_complexity(data, trait_col, time_col = NULL, bins = 10)
```

## Arguments

- data:

  Data frame containing simulation output.

- trait_col:

  Name of the numeric or categorical trait column to summarize.

- time_col:

  Optional name of a time-step column.

- bins:

  Number of bins used for entropy when the trait is numeric.

## Value

A one-row data frame of summary metrics.
