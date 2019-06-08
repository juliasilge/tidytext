context("Get everything")

EXPECTED_METADATA_COLUMNS <- c("total_results", "status_code", "request_date", "request_url", 
                               "page_size", "page", "code", "message")
date_raw <- Sys.Date()
DATE_BEGIN <- as.character(date_raw - as.difftime(2, unit= "days"))
DATE_END <- as.character(date_raw)
LIMIT_SOURCES <- 20
PAGE_SIZE_LIMIT <- 100

# INVALID INPUTS --------------------------------------------------------------------
testthat::test_that("test that function returns error if no argument provided", {
  testthat::expect_error(newsanchor::get_everything(),
                         regexp = "You need to specify at least some content that you search for.")
})

testthat::test_that("test that function returns error if source limit is exceeded.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports",
                                                    sources = rep("testsource", LIMIT_SOURCES + 1)),
                         regexp = "You cannot specify more than 20 sources.")
  
  })

testthat::test_that("test that function returns error if page size limit is exceeded.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports", 
                                                    sources = "testsource",
                                                    page_size = 101 
                                                    ),
                         regexp = "Page size cannot not exceed 100 articles per page.")
})

testthat::test_that("test that function returns error if page size is not numeric.", {
  testthat::expect_error(newsanchor::get_everything(query = "sports", 
                                                    sources = "testsource",
                                                    page_size = "101"),
                          regexp = "You need to insert numeric values for the number of texts per page.")
})

testthat::test_that("test that function returns error if page is not numeric.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports", 
                                                    sources = "testsource",
                                                    page_size = 10,
                                                    page = "9"),
                         regexp = "Page should be a number.")
})

testthat::test_that("test that function returns error if non-existing language is specified.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports", 
                                                    sources = "testsource",
                                                    page_size = 10,
                                                    page = 9,
                                                    language = "DOESNOTEXIST"),
                         regexp = "not a valid language")
})

testthat::test_that("test that function returns error if attempting to sort by a non-existing sort key.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports", 
                                                    sources = "testsource",
                                                    page_size = 10,
                                                    page = 9,
                                                    language = "de",
                                                    sort_by = "DOESNOTEXIST"),
                         regexp = "Sortings can be only by 'publishedAt', 'relevancy', or 'popularity'.")
})

testthat::test_that("Test that function stops when invalid date format is provided to from argument.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports",
                                                    from = "2019;13;10"),
                         regexp = "From argument")
  
})

testthat::test_that("Test that function stops when invalid date format is provided to to argument.", {
  testthat::expect_error(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                    query = "sports",
                                                    to = "2019/31/02"),
                         regexp = "To argument")
})

# INVALID API KEY --------------------------------------------------------------------
testthat::test_that("test that function raises warning if API key invalid.", {
  testthat::expect_warning(newsanchor::get_everything(api_key = "thisisnotanapikey",
                                                      query = "sports"),
                           regexp = "The search resulted in the following error message:")
})

# FORMAT OF RESULT DATA FRAME --------------------------------------------------------
testthat::test_that("test that a data frame is returned in the result list.", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_everything(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                    from = DATE_BEGIN, to = DATE_END, 
                                    query = "Merkel")
  testthat::expect_true(is.data.frame(res$results_df), info = paste0(str(res)))
})

testthat::test_that("test that the correct number of rows is returned", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_everything(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                    from = DATE_BEGIN, to = DATE_END, 
                                    query = "sports")
  testthat::expect_equal(nrow(res$results_df), 100, 
                         info = paste0("100 rows expected, but only ", nrow(res$results_df), " there."))
})

testthat::test_that("test that all columns are atomic vectors", {
  testthat::skip_if(Sys.getenv("NEWS_API_TEST_KEY") == "", 
                    message = "NEWS_API_TEST_KEY not available in environment. Skipping test.")
  res <- newsanchor::get_everything(api_key = Sys.getenv("NEWS_API_TEST_KEY"), 
                                    from = DATE_BEGIN, to = DATE_END, query = "sports")
  testthat::expect_true(all(sapply(res$results_df, is.atomic)), 
                        info = paste0(colnames(res$results_df)[!sapply(res$results_df, is.atomic)]))
})
