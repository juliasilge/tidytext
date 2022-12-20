test_that("unnest_tweet works", {
  tweets <- dplyr::tibble(
    id = 1,
    txt = "@rOpenSci and #rstats see: https://cran.r-project.org"
  )
  expect_snapshot_error(r <- unnest_tweets(tweets, out, txt))
})
