#' Plot artificial-life simulation outputs
#'
#' A small ggplot2 wrapper for line, point, and raster/tile visualizations.
#'
#' @param data Data frame to plot.
#' @param x Name of x column.
#' @param y Name of y column.
#' @param value Optional value column for raster plots.
#' @param type Plot type: "line", "point", or "raster".
#'
#' @return A ggplot object.
#' @export
plot_alife_sim <- function(data,
                           x,
                           y,
                           value = NULL,
                           type = c("line", "point", "raster")) {
  if (!is.data.frame(data)) stop("data must be a data frame.", call. = FALSE)
  type <- match.arg(type)
  if (!x %in% names(data)) stop("x column not found.", call. = FALSE)
  if (!y %in% names(data)) stop("y column not found.", call. = FALSE)

  if (type == "line") {
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
      ggplot2::geom_line() +
      ggplot2::theme_minimal() +
      ggplot2::labs(x = x, y = y)
  } else if (type == "point") {
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]])) +
      ggplot2::geom_point() +
      ggplot2::theme_minimal() +
      ggplot2::labs(x = x, y = y)
  } else {
    if (is.null(value) || !value %in% names(data)) stop("value column is required for raster plots.", call. = FALSE)
    ggplot2::ggplot(data, ggplot2::aes(x = .data[[x]], y = .data[[y]], fill = .data[[value]])) +
      ggplot2::geom_tile() +
      ggplot2::scale_fill_gradient() +
      ggplot2::theme_minimal() +
      ggplot2::labs(x = x, y = y, fill = value)
  }
}
