library(polmineR)
use("polmineR")

testthat::context("count-method")

test_that("count",{
  dt <- count("REUTERS")
  expect_true(all(colnames(dt) %in% c("word", "word_id", "count")))
  expect_true(is.integer(dt[["count"]]))
  expect_true(is.integer(dt[["word_id"]]))
  expect_true(is.character(dt[["word"]]))
  expect_equal(sum(dt[["count"]]), 4050)
  expect_equal(dt@stat[word == "barrel"][["count"]], 15)
})



reuters <- partition("REUTERS", list(id = ".*"), regex = TRUE)

test_that("count (one query)", {
  expect_equal(count(reuters, query = "is")[["count"]], 25)
})

test_that("count (multiple queries)", {
  expect_equal(
    count(reuters, c("is", "this", "real"))[["count"]],
    c(25, 7, 3)
  )
})


test_that("count - breakdown", {
  y <- count("REUTERS", query = '"remain.*"', breakdown = TRUE)
  expect_equal(sum(y[["count"]]), 5)
})