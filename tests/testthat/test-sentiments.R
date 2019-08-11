context("sentiments")

suppressPackageStartupMessages(library(dplyr))

test_data <- tibble(
  line = 1:2,
  text = c(
    "I am happy and joyful",
    "I am sad and annoyed"
  )
)

test_tokens <- unnest_tokens(test_data, word, text)

test_that("get_sentiments works for bing data", {
  bing_joined <- test_tokens %>%
    inner_join(get_sentiments("bing"), by = "word")

  expect_equal(bing_joined$word, c("happy", "joyful", "sad", "annoyed"))
  expect_equal(
    bing_joined$sentiment,
    c("positive", "positive", "negative", "negative")
  )
})
