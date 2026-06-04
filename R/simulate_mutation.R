#' Apply mutation to a numeric trait
#'
#' Adds random variation to a selected numeric trait and optionally bounds the result.
#'
#' @param agents Data frame of agents.
#' @param trait Name of the numeric trait to mutate.
#' @param mutation_rate Probability that each row mutates.
#' @param mutation_sd Standard deviation of mutation noise.
#' @param lower Optional lower bound.
#' @param upper Optional upper bound.
#' @param seed Optional random seed.
#'
#' @return A modified data frame with the selected trait mutated.
#' @export
simulate_mutation <- function(agents,
                              trait = "efficiency",
                              mutation_rate = 0.10,
                              mutation_sd = 0.05,
                              lower = NULL,
                              upper = NULL,
                              seed = NULL) {
  if (!is.data.frame(agents)) stop("agents must be a data frame.", call. = FALSE)
  if (!trait %in% names(agents)) stop("trait column not found.", call. = FALSE)
  if (!is.numeric(agents[[trait]])) stop("trait must be numeric.", call. = FALSE)
  validate_probability(mutation_rate, "mutation_rate")
  validate_nonnegative_number(mutation_sd, "mutation_sd")
  if (!is.null(seed)) set.seed(seed)

  out <- agents
  mutate <- stats::runif(nrow(out)) < mutation_rate
  out[[trait]][mutate] <- out[[trait]][mutate] + stats::rnorm(sum(mutate), 0, mutation_sd)
  if (!is.null(lower)) out[[trait]] <- pmax(lower, out[[trait]])
  if (!is.null(upper)) out[[trait]] <- pmin(upper, out[[trait]])
  out
}
