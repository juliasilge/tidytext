library(polmineR)
use("polmineR")
testthat::context("get_type")

test_that(
  "get_type_specialized",
  {
    expect_equal(get_type("GERMAPARLMINI"), "plpr")
    expect_equal(get_type(partition("GERMAPARLMINI", date = "2009-10-28")), "plpr")
    expect_equal(get_type(partition_bundle("GERMAPARLMINI", s_attribute = "date")), "plpr")
    expect_equal(get_type(Corpus$new("GERMAPARLMINI")), "plpr")
  }
)

test_that(
  "get_type_default",
  {
    expect_equal(is.null(get_type("REUTERS")), TRUE)
    expect_equal(is.null(get_type(partition("REUTERS", places = "kuwait"))), TRUE)
    expect_equal(is.null(get_type(partition_bundle("REUTERS", s_attribute = "places"))), TRUE)
    expect_equal(is.null(get_type(Corpus$new("REUTERS"))), TRUE)
  }
)
