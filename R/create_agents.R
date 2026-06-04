#' Create a simple population of artificial agents
#'
#' Creates a data frame of agents with positions, energy, speed, efficiency,
#' and reproduction threshold.
#'
#' @param n_agents Number of agents.
#' @param world_size Size of the square world. Positions range from 0 to `world_size`.
#' @param energy_mean Mean initial energy.
#' @param energy_sd Standard deviation of initial energy.
#' @param trait_sd Standard deviation used for speed and efficiency traits.
#' @param seed Optional random seed.
#'
#' @return A data frame with one row per agent.
#' @export
create_agents <- function(n_agents = 50,
                          world_size = 1,
                          energy_mean = 1,
                          energy_sd = 0.15,
                          trait_sd = 0.10,
                          seed = NULL) {
  validate_positive_integer(n_agents, "n_agents")
  validate_positive_number(world_size, "world_size")
  validate_positive_number(energy_mean, "energy_mean")
  validate_nonnegative_number(energy_sd, "energy_sd")
  validate_nonnegative_number(trait_sd, "trait_sd")
  if (!is.null(seed)) set.seed(seed)

  data.frame(
    agent = seq_len(n_agents),
    x = stats::runif(n_agents, 0, world_size),
    y = stats::runif(n_agents, 0, world_size),
    energy = pmax(0.01, stats::rnorm(n_agents, energy_mean, energy_sd)),
    speed = pmax(0.01, stats::rnorm(n_agents, 0.05, trait_sd / 5)),
    efficiency = pmin(1, pmax(0.01, stats::rnorm(n_agents, 0.50, trait_sd))),
    reproduction_threshold = pmax(0.10, stats::rnorm(n_agents, 1.50, trait_sd)),
    age = 0,
    alive = TRUE
  )
}
