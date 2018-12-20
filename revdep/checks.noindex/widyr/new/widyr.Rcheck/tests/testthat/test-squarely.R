context("squarely")

suppressPackageStartupMessages(library(dplyr))

test_that("Can perform 'squarely' operations on pairs of items", {
  if (require("gapminder", quietly = TRUE)) {
    ncountries <- length(unique(gapminder$country))

    closest <- gapminder %>%
      squarely(dist)(country, year, lifeExp)

    expect_equal(colnames(closest), c("item1", "item2", "value"))

    expect_equal(nrow(closest), ncountries * (ncountries - 1) / 2)
  }
})

test_that("Can perform 'squarely' within groups", {
  if (require("gapminder", quietly = TRUE)) {
    closest_continent <- gapminder %>%
      group_by(continent) %>%
      squarely(dist)(country, year, lifeExp)

    expect_equal(colnames(closest_continent), c("continent", "item1", "item2", "value"))
    expect_equal(nrow(closest_continent), 2590)
    expect_equal(unique(closest_continent$continent),
                 unique(gapminder$continent))
  }
})
