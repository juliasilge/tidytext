test_that("unnest_tweet works", {
  tweets <- dplyr::tibble(
    id = 1,
    txt = "@rOpenSci and #rstats see: https://cran.r-project.org"
  )
  r <- unnest_tweets(tweets, out, txt)
  s <- tweets %>% unnest_tokens(out, txt, token = "tweets")
  expect_equal(r, s)
  r <- unnest_tweets(tweets, out, txt, strip_url = TRUE)
  s <- unnest_tokens(tweets, out, txt, token = "tweets", strip_url = TRUE)
  expect_equal(r, s)
  r <- unnest_tweets(tweets, out, txt, strip_punct = TRUE)
  s <- unnest_tokens(tweets, out, txt, token = "tweets", strip_punct = TRUE)
  expect_equal(r, s)
})
