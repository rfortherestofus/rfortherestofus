test_that("get_acs_race_ethnicity works", {
  expect_snapshot(
    error = TRUE,
    x = get_acs_race_ethnicity()
  )
})

test_that("get_acs_race_ethnicity names are what we expect", {
  acs_race_ethnicity <- get_acs_race_ethnicity("state")
  expect_equal(
    names(acs_race_ethnicity),
    c("geoid", "geography", "population_group", "estimate", "moe")
  )
  expect_snapshot(
    names(acs_race_ethnicity)
  )
  expect_equal(
    dim(acs_race_ethnicity),
    c(416, 5)
  )
  expect_snapshot(
    as.character(lapply(acs_race_ethnicity, class))
  )
})
