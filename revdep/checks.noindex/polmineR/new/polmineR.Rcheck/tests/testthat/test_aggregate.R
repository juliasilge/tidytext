library(polmineR)
library(data.table)

testthat::context("aggregate")

test_that(
  "aggregate partition",
  {
    P <- new(
      "partition",
      cpos = matrix(data = c(1:10, 20:29), ncol = 2, byrow = TRUE),
      stat = data.table()
    )
    P2 <- aggregate(P)
    P2@cpos
    
    expect_equal(nrow(P2@cpos), 2)
    expect_equal(P2@cpos[,2] - P2@cpos[,1], c(9, 9))
  }
)

