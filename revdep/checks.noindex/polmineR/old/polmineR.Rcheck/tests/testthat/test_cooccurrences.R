library(polmineR)
use("polmineR")
testthat::context("cooccurrences")

test_that(
  "cooccurrences-method for corpus",
  {
    expect_equal(
      cooccurrences("REUTERS", query = "oil", pAttribute = "word")@stat[["word"]][1:5],
      c("prices", "crude", "world", "markets", "industry")
    )
    
    expect_equal(
      cooccurrences("REUTERS", query = '"barrel.*"', pAttribute = "word")@stat[["word"]][1:5],
      c("dlrs", "mln", "a", "18", "per")
    )
    
    expect_equal(
      cooccurrences("REUTERS", query = "asdfasdf", pAttribute = "word"),
      NULL
    )
    
    expect_equal(
      cooccurrences("REUTERS", query = '"asdfasdfasdfasd.*"', cqp = TRUE),
      NULL
    )
  }
)

test_that(
  "kwic-method for partition",
  {
    P <- partition("REUTERS", places = "saudi-arabia", regex = TRUE)
    
    expect_equal(
      cooccurrences(P, query = "oil", pAttribute = "word")@stat[["word"]][1:5],
      c("prices", "each", "other", "market", "crude")
    )
    
    expect_equal(
      cooccurrences(P, query = '"barrel.*"', cqp = TRUE, pAttribute = "word")@stat[["word"]][1:5],
      c("a", "dlrs", "18", "day","per")
    )
    
    expect_equal(
      cooccurrences(P, query = "asdfasdf", pAttribute = "word"),
      NULL
    )
    
    expect_equal(
      cooccurrences(P, query = '"asdfasdfasdfasd.*"', cqp = TRUE, pAttribute = "word"),
      NULL
    )
  }
)

