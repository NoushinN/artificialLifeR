test_that("create_agents returns expected rows", {
  agents <- create_agents(n_agents = 10, seed = 1)
  expect_equal(nrow(agents), 10)
  expect_true(all(c("agent", "x", "y", "energy") %in% names(agents)))
})

test_that("resource competition returns list outputs", {
  sim <- simulate_resource_competition(n_agents = 10, steps = 5, seed = 1)
  expect_true(all(c("agents", "resources", "summary") %in% names(sim)))
  expect_equal(nrow(sim$summary), 5)
})

test_that("population dynamics returns summary", {
  pop <- simulate_population_dynamics(initial_population = 10, steps = 5, seed = 1)
  expect_true(all(c("agents", "summary") %in% names(pop)))
  expect_equal(nrow(pop$summary), 5)
})

test_that("measurement works", {
  agents <- create_agents(n_agents = 10, seed = 1)
  m <- measure_life_like_complexity(agents, trait_col = "energy")
  expect_equal(nrow(m), 1)
  expect_true("entropy" %in% names(m))
})
