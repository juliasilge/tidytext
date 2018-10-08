library(polmineR)
use("polmineR")

testthat::context("s_attributes-method")

test_that(
  "s_attributes for corpus, without specification of s_attribute",
  {
    s_attrs <- s_attributes("GERMAPARLMINI")
    expect_equal(length(s_attrs), 4L)
    expect_equal(is.character(s_attrs), TRUE)
    expect_equal(all(s_attrs %in% c("interjection", "date", "party", "speaker")), TRUE)
  }
)

