context("widely")

test_that("widely can widen, operate, and re-tidy", {
  if (require("gapminder", quietly = TRUE)) {
    ret <- gapminder %>%
      widely(cor)(year, country, lifeExp)

    expect_is(ret$item1, "character")
    expect_is(ret$item2, "character")

    expect_true(all(c("Afghanistan", "United States") %in% ret$item1))
    expect_true(all(c("Afghanistan", "United States") %in% ret$item2))
    expect_true(all(ret$value <= 1))
    expect_true(all(ret$value >= -1))

    expect_equal(nrow(ret), length(unique(gapminder$country)) ^ 2)

    ret2 <- gapminder %>%
      widely(cor, sort = TRUE)(year, country, lifeExp)

    expect_equal(sort(ret$value, decreasing = TRUE), ret2$value)
  }
})

test_that("widely works within groups", {
  if (require("gapminder", quietly = TRUE)) {
    ret <- gapminder %>%
      group_by(continent) %>%
      widely(cor)(year, country, lifeExp)

    expect_equal(colnames(ret), c("continent", "item1", "item2", "value"))
    expect_is(ret$item1, "character")
    expect_is(ret$item2, "character")

    expect_true(all(c("Afghanistan", "United States") %in% ret$item1))
    expect_true(all(c("Afghanistan", "United States") %in% ret$item2))
    expect_true(any("Canada" == ret$item1 & "United States" == ret$item2))
    expect_false(any("Afghanistan" == ret$item1 & "United States" == ret$item2))

    expect_true(all(ret$value <= 1))
    expect_true(all(ret$value >= -1))
  }
})

test_that("widely's maximum size argument works", {
  f <- function() {
    widely(cor, maximum_size = 1000)(gapminder, year, country, lifeExp)
  }
  expect_error(f(), "1704.*large")
})
