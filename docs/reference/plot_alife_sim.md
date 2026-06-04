# Plot artificial-life simulation outputs

A small ggplot2 wrapper for line, point, and raster/tile visualizations.

## Usage

``` r
plot_alife_sim(data, x, y, value = NULL, type = c("line", "point", "raster"))
```

## Arguments

- data:

  Data frame to plot.

- x:

  Name of x column.

- y:

  Name of y column.

- value:

  Optional value column for raster plots.

- type:

  Plot type: "line", "point", or "raster".

## Value

A ggplot object.
