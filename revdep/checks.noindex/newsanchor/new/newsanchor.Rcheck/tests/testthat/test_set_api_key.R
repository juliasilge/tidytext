context("test set_api_key")

tmp <- tempfile()
api_key <- "foobar"

testthat::setup({
  newsanchor::set_api_key(api_key, path = tmp)
})

testthat::test_that("test that the set api key function creates a file with the api key", {
  testthat::expect_true(file.exists(tmp))
})

testthat::test_that("test that the file contains the api key", {
  content <- readLines(tmp)
  testthat::expect_true(content == paste0("NEWS_API_KEY=", api_key))
})

testthat::teardown({
  file.remove(tmp)
})