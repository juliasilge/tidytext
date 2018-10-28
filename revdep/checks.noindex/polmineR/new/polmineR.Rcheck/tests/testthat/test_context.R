library(polmineR)
use("polmineR")
testthat::context("context")


test_that(
  "context-method for corpus",
  {
    y <- polmineR::context("REUTERS", query = "oil", pAttribute = "word")@stat
    expect_equal(colnames(y), c("word_id", "count_window", "word"))
    expect_equal(sum(y[["count_window"]]), 780L)
    
    y <- polmineR::context("REUTERS", query = '"barrel.*"', pAttribute = "word")@stat
    expect_equal(colnames(y), c("word_id", "count_window", "word"))
    expect_equal(sum(y[["count_window"]]), 260L)
    
    y <- polmineR::context("REUTERS", query = "asdfasdf", pAttribute = "word")
    expect_equal(y, NULL)
    
    y <- polmineR::context("REUTERS", query = '"asdfasdfasdfasd.*"', cqp = TRUE, pAttribute = "word")
    expect_equal(y, NULL)
  }
)

test_that(
  "context-method for partition",
  {
    P <- partition("REUTERS", places = "saudi-arabia", regex = TRUE)
    
    y <- polmineR::context(P, query = "oil", pAttribute = "word")@stat
    expect_equal(colnames(y), c("word_id", "count_window", "word"))
    expect_equal(sum(y[["count_window"]]), 210L)
    
    y <- polmineR::context(P, query = '"barrel.*"', pAttribute = "word")@stat
    expect_equal(colnames(y), c("word_id", "count_window", "word"))
    expect_equal(sum(y[["count_window"]]), 70L)
    
    y <- polmineR::context(P, query = "asdfasdf", pAttribute = "word")
    expect_equal(y, NULL)
    
    y <- polmineR::context(P, query = '"asdfasdfasdfasd.*"', cqp = TRUE, pAttribute = "word")
    expect_equal(y, NULL)
  }
)

