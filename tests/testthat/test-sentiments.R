context("sentiments")

suppressPackageStartupMessages(library(dplyr))

test_data <- data_frame(line = 1:2,
                        text = c("I am happy and joyful",
                                 "I am sad and annoyed"))

test_tokens <- unnest_tokens(test_data, word, text)

test_that("get_sentiments works for nrc data", {
  nrc_joined <- test_tokens %>%
    inner_join(get_sentiments("nrc"), by = "word")

  # only positive included in NRC for some reason
  expect_equal(unique(nrc_joined$word), c("happy", "joyful"))
  expect_equal(sort(unique(nrc_joined$sentiment)),
               c("anticipation", "joy", "positive", "trust"))
})

test_that("get_sentiments works for bing data", {
  bing_joined <- test_tokens %>%
    inner_join(get_sentiments("bing"), by = "word")

  expect_equal(bing_joined$word, c("happy", "joyful", "sad", "annoyed"))
  expect_equal(bing_joined$sentiment,
               c("positive", "positive", "negative", "negative"))
})

test_that("get_sentiments works for afinn data", {
  afinn_joined <- test_tokens %>%
    inner_join(get_sentiments("afinn"), by = "word")

  expect_equal(afinn_joined$word,
               c("happy", "joyful", "sad", "annoyed"))
  expect_equal(sign(afinn_joined$score), c(1, 1, -1, -1))
})

test_that("get_sentiments works for labMT", {
  labmt_joined <- test_tokens %>%
    inner_join(get_sentiments("labMTenglish"), by = "word")

  expect_equal(labmt_joined$word,
               c("i", "am", "happy", "and", "i", "am", "sad", "and", "annoyed"))
  expect_equal(labmt_joined$score,
               c(5.92, 5.38, 8.3, 5.22, 5.92, 5.38, 2.38, 5.22, 2.58))
})
