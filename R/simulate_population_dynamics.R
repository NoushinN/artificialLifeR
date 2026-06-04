#' Simulate simple artificial-life population dynamics
#'
#' Simulates a population with energy gain, mortality, reproduction, inheritance,
#' mutation, and density constraints.
#'
#' @param initial_population Initial number of agents.
#' @param steps Number of time steps.
#' @param carrying_capacity Soft population capacity.
#' @param resource_level Baseline resource input per step.
#' @param death_threshold Agents at or below this energy die.
#' @param reproduction_threshold Energy threshold for reproduction.
#' @param mutation_rate Probability of mutation in offspring traits.
#' @param mutation_sd Standard deviation of mutation noise.
#' @param seed Optional random seed.
#'
#' @return A list with `agents` history and `summary` data frames.
#' @export
simulate_population_dynamics <- function(initial_population = 40,
                                         steps = 80,
                                         carrying_capacity = 120,
                                         resource_level = 1.0,
                                         death_threshold = 0,
                                         reproduction_threshold = 1.5,
                                         mutation_rate = 0.10,
                                         mutation_sd = 0.03,
                                         seed = NULL) {
  validate_positive_integer(initial_population, "initial_population")
  validate_positive_integer(steps, "steps")
  validate_positive_number(carrying_capacity, "carrying_capacity")
  validate_nonnegative_number(resource_level, "resource_level")
  validate_probability(mutation_rate, "mutation_rate")
  validate_nonnegative_number(mutation_sd, "mutation_sd")
  if (!is.null(seed)) set.seed(seed)

  pop <- create_agents(n_agents = initial_population)
  pop$reproduction_threshold <- reproduction_threshold
  agent_history <- list()
  summary_history <- list()

  for (step in seq_len(steps)) {
    density_factor <- max(0, 1 - nrow(pop) / carrying_capacity)
    gain <- resource_level * density_factor * pop$efficiency * stats::runif(nrow(pop), 0.7, 1.3)
    cost <- 0.08 + pop$speed * 0.5
    pop$energy <- pop$energy + gain - cost
    pop$age <- pop$age + 1
    pop$alive <- pop$energy > death_threshold
    pop <- pop[pop$alive, , drop = FALSE]
    if (nrow(pop) == 0) {
      summary_history[[step]] <- data.frame(step = step, population = 0, mean_energy = NA_real_, mean_efficiency = NA_real_, trait_sd = NA_real_)
      next
    }
    pop <- simulate_reproduction(
      pop,
      energy_col = "energy",
      threshold_col = "reproduction_threshold",
      mutation_rate = mutation_rate,
      mutation_sd = mutation_sd,
      max_offspring = 1
    )
    if (nrow(pop) > carrying_capacity) {
      pop <- simulate_selection(pop, survival_fraction = carrying_capacity / nrow(pop), stochastic = TRUE)
    }
    ah <- pop
    ah$step <- step
    agent_history[[step]] <- ah
    summary_history[[step]] <- data.frame(
      step = step,
      population = nrow(pop),
      mean_energy = mean(pop$energy),
      mean_efficiency = mean(pop$efficiency),
      trait_sd = stats::sd(pop$efficiency)
    )
  }
  list(
    agents = if (length(agent_history)) do.call(rbind, agent_history) else data.frame(),
    summary = do.call(rbind, summary_history)
  )
}
