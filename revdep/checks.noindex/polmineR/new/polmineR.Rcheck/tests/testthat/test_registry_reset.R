library(polmineR)
testthat::context("registry_reset")
use("polmineR")


test_that(
  "switching between registry directories and check that CQP works",
  {
    # use("polmineR")
    # expect_equal(CQI$list_corpora(), c("GERMAPARLMINI", "REUTERS"))
    # expect_equal(sum(corpus()[["size"]]), 226251)
    # expect_equal(count("REUTERS", '"barrel.*"', cqp = TRUE)[["count"]], 26)
    # 
    # use("RcppCWB")
    # expect_equal(CQI$list_corpora(), c("REUTERS"))
    # expect_equal(count("REUTERS", '"barrel.*"', cqp = TRUE)[["count"]], 26)
    # 
    # use("polmineR")
    # expect_equal(CQI$list_corpora(), c("GERMAPARLMINI", "REUTERS"))
    # expect_equal(sum(corpus()[["size"]]), 226251)
    # expect_equal(count("REUTERS", '"barrel.*";', cqp = TRUE)[["count"]], 26)
  }
)
