library(polmineR)
use("polmineR")

testthat::context("terms-method")

test_that("terms-method for partition, without/with regex",{
  P <- partition("REUTERS", places = "kuwait")
  
  y <- terms(P, pAttribute = "word")
  expect_equal(nchar(paste(y, collapse = "")), 377)
  
  y <- terms(P, pAttribute = "word", regex = "^o.*$")
  expect_equal(y, c("oil", "of", "one", "over"))
  
  y <- terms(P, pAttribute = "word", regex = c("^o.*$", "^p.*"))
  expect_equal(y, c("oil", "of", "one", "over", "plans", "prices", "pumping"))
})

test_that("terms-method for character/corpus, with regex", {
  y <- terms("REUTERS", pAttribute = "word")
  expect_equal(nchar(paste(y, collapse = "")), 7451)
  
  y <- terms("REUTERS", pAttribute = "word", regex = "^y.*$")
  expect_equal(y, c("you", "year", "yesterday's", "yesterday", "year's", "years"))
  
  y <- terms("REUTERS", pAttribute = "word", regex = c("^oi.*$", "^barrel.*"))
  expect_equal(y, c("oil", "barrel", "barrels"))
})
