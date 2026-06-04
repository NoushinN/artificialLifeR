validate_positive_integer <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || x < 1 || x != as.integer(x)) {
    stop(name, " must be a positive integer.", call. = FALSE)
  }
}

validate_positive_number <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || x <= 0) {
    stop(name, " must be a positive number.", call. = FALSE)
  }
}

validate_nonnegative_number <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || x < 0) {
    stop(name, " must be a non-negative number.", call. = FALSE)
  }
}

validate_probability <- function(x, name) {
  if (!is.numeric(x) || length(x) != 1 || is.na(x) || x < 0 || x > 1) {
    stop(name, " must be between 0 and 1.", call. = FALSE)
  }
}

jitter_bound <- function(x, amount, lower, upper) {
  pmin(upper, pmax(lower, x + stats::rnorm(length(x), 0, amount)))
}

shannon_entropy_internal <- function(probs) {
  probs <- probs[probs > 0]
  -sum(probs * log2(probs))
}
