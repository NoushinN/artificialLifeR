#' Simulate resource competition among artificial agents
#'
#' Simulates agents moving in a square world and gaining energy from spatially
#' distributed resources. Resources regenerate at each time step.
#'
#' @param n_agents Number of agents.
#' @param steps Number of time steps.
#' @param world_size Size of the square world.
#' @param n_resources Number of resource patches.
#' @param resource_regen Resource regeneration amount per step.
#' @param consumption_rate Maximum resource amount consumed by an agent per step.
#' @param movement_cost Energy cost per step.
#' @param seed Optional random seed.
#'
#' @return A list with `agents`, `resources`, and `summary` data frames.
#' @export
simulate_resource_competition <- function(n_agents = 50,
                                          steps = 50,
                                          world_size = 1,
                                          n_resources = 30,
                                          resource_regen = 0.20,
                                          consumption_rate = 0.10,
                                          movement_cost = 0.02,
                                          seed = NULL) {
  validate_positive_integer(n_agents, "n_agents")
  validate_positive_integer(steps, "steps")
  validate_positive_number(world_size, "world_size")
  validate_positive_integer(n_resources, "n_resources")
  validate_nonnegative_number(resource_regen, "resource_regen")
  validate_nonnegative_number(consumption_rate, "consumption_rate")
  validate_nonnegative_number(movement_cost, "movement_cost")
  if (!is.null(seed)) set.seed(seed)

  agents <- create_agents(n_agents = n_agents, world_size = world_size)
  resources <- data.frame(
    resource = seq_len(n_resources),
    x = stats::runif(n_resources, 0, world_size),
    y = stats::runif(n_resources, 0, world_size),
    amount = stats::runif(n_resources, 0.40, 1.00)
  )

  agent_history <- list()
  resource_history <- list()
  summary_history <- list()

  for (step in seq_len(steps)) {
    resources$amount <- pmin(1, resources$amount + resource_regen * stats::runif(n_resources, 0.5, 1.0))

    for (i in seq_len(nrow(agents))) {
      if (!agents$alive[i]) next
      dx <- resources$x - agents$x[i]
      dy <- resources$y - agents$y[i]
      d2 <- dx^2 + dy^2
      nearest <- which.min(d2)
      dist <- sqrt(d2[nearest])
      if (dist > 0) {
        step_size <- min(agents$speed[i], dist)
        agents$x[i] <- agents$x[i] + step_size * dx[nearest] / dist
        agents$y[i] <- agents$y[i] + step_size * dy[nearest] / dist
      }
      if (sqrt((resources$x[nearest] - agents$x[i])^2 + (resources$y[nearest] - agents$y[i])^2) <= agents$speed[i] * 1.5) {
        eaten <- min(resources$amount[nearest], consumption_rate)
        resources$amount[nearest] <- resources$amount[nearest] - eaten
        agents$energy[i] <- agents$energy[i] + eaten * agents$efficiency[i]
      }
      agents$energy[i] <- agents$energy[i] - movement_cost * (1 + agents$speed[i])
      agents$age[i] <- agents$age[i] + 1
      agents$alive[i] <- agents$energy[i] > 0
    }

    ah <- agents
    ah$step <- step
    rh <- resources
    rh$step <- step
    sh <- data.frame(
      step = step,
      n_alive = sum(agents$alive),
      mean_energy = mean(agents$energy),
      mean_resource = mean(resources$amount),
      total_resource = sum(resources$amount)
    )
    agent_history[[step]] <- ah
    resource_history[[step]] <- rh
    summary_history[[step]] <- sh
  }

  list(
    agents = do.call(rbind, agent_history),
    resources = do.call(rbind, resource_history),
    summary = do.call(rbind, summary_history)
  )
}
