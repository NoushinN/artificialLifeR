#' Simulate reproduction with simple inheritance
#'
#' Agents above an energy threshold create offspring. Offspring inherit traits
#' from parents with optional mutation.
#'
#' @param agents Data frame of agents.
#' @param energy_col Name of the energy column.
#' @param threshold_col Name of the reproduction threshold column.
#' @param mutation_rate Probability of mutation for inherited traits.
#' @param mutation_sd Standard deviation of mutation noise.
#' @param max_offspring Maximum offspring per parent.
#' @param seed Optional random seed.
#'
#' @return A data frame containing parents and offspring.
#' @export
simulate_reproduction <- function(agents,
                                  energy_col = "energy",
                                  threshold_col = "reproduction_threshold",
                                  mutation_rate = 0.10,
                                  mutation_sd = 0.03,
                                  max_offspring = 1,
                                  seed = NULL) {
  if (!is.data.frame(agents)) stop("agents must be a data frame.", call. = FALSE)
  required <- c(energy_col, threshold_col, "agent")
  missing <- setdiff(required, names(agents))
  if (length(missing) > 0) stop("Missing columns: ", paste(missing, collapse = ", "), call. = FALSE)
  validate_probability(mutation_rate, "mutation_rate")
  validate_nonnegative_number(mutation_sd, "mutation_sd")
  validate_positive_integer(max_offspring, "max_offspring")
  if (!is.null(seed)) set.seed(seed)

  out <- agents
  eligible <- which(out[[energy_col]] >= out[[threshold_col]] & (!"alive" %in% names(out) | out$alive))
  if (length(eligible) == 0) return(out)

  offspring <- list()
  next_id <- max(out$agent, na.rm = TRUE) + 1
  k <- 1
  for (i in eligible) {
    n_birth <- sample(seq_len(max_offspring), 1)
    for (b in seq_len(n_birth)) {
      child <- out[i, , drop = FALSE]
      child$agent <- next_id
      next_id <- next_id + 1
      child[[energy_col]] <- out[[energy_col]][i] / 2
      out[[energy_col]][i] <- out[[energy_col]][i] / 2
      if ("age" %in% names(child)) child$age <- 0
      if ("x" %in% names(child)) child$x <- jitter_bound(child$x, 0.03, 0, 1)
      if ("y" %in% names(child)) child$y <- jitter_bound(child$y, 0.03, 0, 1)
      for (trait in intersect(c("speed", "efficiency", "reproduction_threshold"), names(child))) {
        if (stats::runif(1) < mutation_rate) {
          child[[trait]] <- child[[trait]] + stats::rnorm(1, 0, mutation_sd)
        }
      }
      if ("speed" %in% names(child)) child$speed <- pmax(0.005, child$speed)
      if ("efficiency" %in% names(child)) child$efficiency <- pmin(1, pmax(0.01, child$efficiency))
      if ("reproduction_threshold" %in% names(child)) child$reproduction_threshold <- pmax(0.10, child$reproduction_threshold)
      offspring[[k]] <- child
      k <- k + 1
    }
  }
  do.call(rbind, c(list(out), offspring))
}
