context("Get headlines")
EXPECTED_METADATA_COLUMNS <- sort(c("total_results", "status_code", "request_date", "request_url", 
                               "page_size", "page", "code", "message"))


# TEST INVALID INPUTS -----------------------------------------------------------------------------
testthat::test_that("test that function returns error if no argument provided", {
  testthat::expect_error(newsanchor::get_headlines(),
                         regexp = "Please provide at least either sources, country, category, or query.")
})

testthat::test_that("test that function returns error if no argument except API key is provided", {
  testthat::expect_error(newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY")),
                         regexp = "Please provide at least either sources, country, category, or query.")
})

testthat::test_that("test that function returns error if invalid country is provided.", {
  testthat::expect_error(newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"),
                                                   query = c("sports"),
                                                   country = "HHH"),
                         regexp = ".*not a valid country.*")
})

testthat::test_that("test that function returns error if more than one country is provided.", {
  testthat::expect_error(newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"),
                                                   query = c("sports"),
                                                   country = c("de", "fr")),
                         regexp = ".*cannot specify more than one country.*")
})

testthat::test_that("test that function returns error if vector is provided to query.", {
  testthat::expect_error(newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"),
                                                   query = c("trump", "macron")),
                         regexp = ".*You can only specify one query string.*")
})


testthat::test_that("test that function returns error if list is provided to query.", {
  testthat::expect_error(newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"),
                                                   query = list("trump", "macron")),
                         regexp = ".*You can only specify one query string.*")
})


# INVALID API KEY  ------------------------------------------------------------------
testthat::test_that("test that function raises warning if API key invalid.", {
  testthat::expect_warning(newsanchor::get_headlines(api_key = "thisisnotanapikey",
                                                   query = "sports"),
                           regexp = "The search resulted in the following error message:")
})

# FORMAT OF RESULT DATAFRAME ------------------------------------------------------------------
testthat::test_that("test that the query returns results at all.", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                   query = "sports")
  testthat::expect_gt(nrow(res$results_df), 0)
})

testthat::test_that("test that the function returns a data frame with expected column names.", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  
  res <- newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                 query = "sports")
  testthat::expect_true(is.data.frame(res$results_df))
  testthat::expect_equal(sort(names(res$metadata)), EXPECTED_METADATA_COLUMNS, info = names(res$metadata))
})

testthat::test_that("test that all columns are atomic vectors", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  
  res <- newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                 query = "sports")
  testthat::expect_true(all(sapply(res$results_df, is.atomic)),
                        info = paste0(
                          colnames(res$results_df), " ", 
                          sapply(res$results_df, class)[!sapply(res$results_df, is.atomic)]
                          )
                        )
})

testthat::test_that("test that the it returns empty dataframe with right columns", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_headlines(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                   query = "sports")
  testthat::expect_gt(nrow(res$results_df), 0)
})