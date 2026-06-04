#' Measure simple life-like complexity summaries
#'
#' Computes educational summaries such as unique values, Shannon entropy, mean,
#' standard deviation, temporal variability, and mean absolute change.
#'
#' @param data Data frame containing simulation output.
#' @param trait_col Name of the numeric or categorical trait column to summarize.
#' @param time_col Optional name of a time-step column.
#' @param bins Number of bins used for entropy when the trait is numeric.
#'
#' @return A one-row data frame of summary metrics.
#' @export
measure_life_like_complexity <- function(data,
                                         trait_col,
                                         time_col = NULL,
                                         bins = 10) {
  if (!is.data.frame(data)) stop("data must be a data frame.", call. = FALSE)
  if (missing(trait_col) || !trait_col %in% names(data)) stop("trait_col is missing or not found.", call. = FALSE)
  if (!is.null(time_col) && !time_col %in% names(data)) stop("time_col not found.", call. = FALSE)
  validate_positive_integer(bins, "bins")

  x <- data[[trait_col]]
  x <- x[!is.na(x)]
  if (length(x) == 0) {
    return(data.frame(n = 0, unique_values = 0, entropy = NA_real_, mean = NA_real_, sd = NA_real_, temporal_variability = NA_real_, mean_abs_change = NA_real_))
  }

  if (is.numeric(x)) {
    mean_x <- mean(x)
    sd_x <- stats::sd(x)
    if (length(unique(x)) > 1) {
      cuts <- cut(x, breaks = min(bins, length(unique(x))), include.lowest = TRUE)
      probs <- prop.table(table(cuts))
    } else {
      probs <- 1
    }
  } else {
    mean_x <- NA_real_
    sd_x <- NA_real_
    probs <- prop.table(table(x))
  }
  entropy <- shannon_entropy_internal(as.numeric(probs))

  temporal_variability <- NA_real_
  mean_abs_change <- NA_real_
  if (!is.null(time_col) && is.numeric(data[[trait_col]])) {
    tmp <- stats::aggregate(data[[trait_col]], list(step = data[[time_col]]), mean, na.rm = TRUE)
    names(tmp)[2] <- "value"
    if (nrow(tmp) > 1) {
      temporal_variability <- stats::sd(tmp$value, na.rm = TRUE)
      mean_abs_change <- mean(abs(diff(tmp$value)), na.rm = TRUE)
    }
  }

  data.frame(
    n = length(x),
    unique_values = length(unique(x)),
    entropy = entropy,
    mean = mean_x,
    sd = sd_x,
    temporal_variability = temporal_variability,
    mean_abs_change = mean_abs_change
  )
}
