library(polmineR)
use("polmineR")
testthat::context("kwic")

test_that(
  "kwic-method for corpus",
  {
    expect_equal(
      nrow(kwic("REUTERS", query = "oil", pAttribute = "word")@table),
      78L
      )
    
    expect_equal(
      nrow(kwic("REUTERS", query = '"barrel.*"', pAttribute = "word")@table),
      26L
      )

    expect_equal(
      kwic("REUTERS", query = "asdfasdf", pAttribute = "word"),
      NULL
      )
    
    expect_equal(
      kwic("REUTERS", query = '"asdfasdfasdfasd.*"', cqp = TRUE),
      NULL
    )
  }
)

test_that(
  "kwic-method for partition",
  {
    P <- partition("REUTERS", places = "saudi-arabia", regex = TRUE)
    
    expect_equal(
      nrow(kwic(P, query = "oil", pAttribute = "word")@table),
      21L
    )
    
    expect_equal(
      nrow(kwic(P, query = '"barrel.*"', cqp = TRUE, pAttribute = "word")@table),
      7L
      )

    expect_equal(
      kwic(P, query = "asdfasdf", pAttribute = "word"),
      NULL
      )
    
    expect_equal(
      kwic(P, query = '"asdfasdfasdfasd.*"', cqp = TRUE, pAttribute = "word"),
      NULL
    )
  }
)

