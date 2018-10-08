library(polmineR)
use("polmineR")
testthat::context("cpos")

test_that(
  "cpos-method for corpus",
  {
    expect_equal(nrow(cpos("REUTERS", query = "oil")), 78L)
    expect_equal(nrow(cpos("REUTERS", query = '"barrel.*"', cqp = TRUE)), 26L)
    expect_equal(cpos("REUTERS", query = "asdfasdfasdfasdf"), NULL)
    expect_equal(cpos("REUTERS", query = '"adfadfsaasdf.*"', cqp = TRUE), NULL)
  }
)

test_that(
  "cpos-method for partition",
  {
    P <- partition("REUTERS", places = "saudi-arabia", regex = TRUE)
    expect_equal(nrow(cpos(P, query = "oil", pAttribute = "word")), 21L)
    expect_equal(nrow(cpos(P, query = '"barrel.*"', cqp = TRUE)), 7L)
    expect_equal(cpos(P, query = "asdfasdfasdfasdf", pAttribute = "word"), NULL)
    expect_equal(cpos(P, query = '"adfadfsaasdf.*"', cqp = TRUE), NULL)
    
  }
)
