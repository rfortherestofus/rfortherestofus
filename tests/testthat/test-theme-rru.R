head(mtcars)

library(ggplot2)
gg_theme_rru <- ggplot(mtcars, aes(x = mpg, y = hp, colour = factor(cyl))) +
  geom_point() +
  theme_rru()

test_that("theme rru is consistent", {
  vdiffr::expect_doppelganger(
    title = "theme_rru",
    fig = gg_theme_rru
  )
})
