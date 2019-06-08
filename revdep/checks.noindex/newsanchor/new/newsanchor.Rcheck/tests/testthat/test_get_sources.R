context("Get sources")

# INVALID INPUTS ----------------------------------------------------------------------------
testthat::test_that("that that function returns error if non-existing category is specified.", {
  testthat::expect_error(newsanchor::get_sources(api_key = "thisisnotanapikey", 
                                                 category = "DOESNOTEXIST"),
                         regexp = "not a valid category")
})

testthat::test_that("that that function returns error if non-existing language is specified.", {
  testthat::expect_error(newsanchor::get_sources(api_key = "thisisnotanapikey",
                                                 language = "DOESNOTEXIST"),
                         regexp = "not a valid language")
})

testthat::test_that("that that function returns error if non-existing country is specified.", {
  testthat::expect_error(newsanchor::get_sources(api_key = "thisisnotanapikey",
                                                 country = "DOESNOTEXIST"),
                         regexp = "not a valid country")
})

# INVALID API KEY ----------------------------------------------------------------------------
testthat::test_that("that that function raises warning if invalid API key is specified.", {
  testthat::expect_warning(newsanchor::get_sources(api_key = "thisisnotanapikey"),
                           regexp = "The search resulted in the following error message:")
})

# FORMAT OF RETURNED DATA FRAME --------------------------------------------------------------
testthat::test_that("test that the function returns a data frame", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_sources(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                 category = "general",
                                 language = "de")
  testthat::expect_true(is.data.frame(res$results_df), 
                        info = paste0(str(res, max.level = 1)))
})

testthat::test_that("test that all columns are atomic vectors", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_sources(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                 category = "general",
                                 language = "de")
  testthat::expect_true(all(sapply(res$results_df, is.atomic)),
                        info = paste0(str(res$results_df, max.level = 1)))
})

testthat::test_that("test that the number of rows is greater than zero", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_sources(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                    category = "general",
                                    language = "de")
  testthat::expect_gt(nrow(res$results_df), 0)
})

