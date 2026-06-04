#' Simulate fitness-based selection
#'
#' Selects agents based on a fitness column or computed fitness proxy.
#'
#' @param agents Data frame of agents.
#' @param fitness_col Optional name of an existing fitness column.
#' @param survival_fraction Fraction of agents to keep.
#' @param stochastic If `TRUE`, selection is probabilistic. If `FALSE`, top agents are kept.
#' @param seed Optional random seed.
#'
#' @return A data frame of selected agents with a `fitness` column.
#' @export
simulate_selection <- function(agents,
                               fitness_col = NULL,
                               survival_fraction = 0.50,
                               stochastic = TRUE,
                               seed = NULL) {
  if (!is.data.frame(agents)) stop("agents must be a data frame.", call. = FALSE)
  validate_probability(survival_fraction, "survival_fraction")
  if (survival_fraction <= 0) stop("survival_fraction must be greater than 0.", call. = FALSE)
  if (!is.null(seed)) set.seed(seed)

  out <- agents
  if (!is.null(fitness_col)) {
    if (!fitness_col %in% names(out)) stop("fitness_col not found.", call. = FALSE)
    fitness <- out[[fitness_col]]
  } else {
    energy <- if ("energy" %in% names(out)) out$energy else rep(1, nrow(out))
    efficiency <- if ("efficiency" %in% names(out)) out$efficiency else rep(1, nrow(out))
    age_penalty <- if ("age" %in% names(out)) 1 / (1 + out$age / 100) else rep(1, nrow(out))
    fitness <- pmax(0, energy * efficiency * age_penalty)
  }
  out$fitness <- fitness
  n_keep <- max(1, ceiling(nrow(out) * survival_fraction))
  if (stochastic) {
    probs <- out$fitness + 1e-8
    probs <- probs / sum(probs)
    keep <- sample(seq_len(nrow(out)), size = n_keep, replace = FALSE, prob = probs)
  } else {
    keep <- order(out$fitness, decreasing = TRUE)[seq_len(n_keep)]
  }
  out[keep, , drop = FALSE]
}
