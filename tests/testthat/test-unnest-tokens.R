# tests for unnest_tokens function

context("Unnesting tokens")

suppressPackageStartupMessages(library(dplyr))

test_that("tokenizing by character works", {
  d <- data_frame(txt = "Emily Dickinson")
  d <- d %>% unnest_tokens(char, txt, token = "characters")
  expect_equal(nrow(d), 14)
  expect_equal(ncol(d), 1)
  expect_equal(d$char[1], "e")
})

test_that("tokenizing by word works", {
  d <- data_frame(txt = c("Because I could not stop for Death -",
                          "He kindly stopped for me -"))
  d <- d %>% unnest_tokens(word, txt)
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")
})

test_that("tokenizing by sentence works", {
  d <- data_frame(txt = c("I'm Nobody! Who are you?",
                          "Are you - Nobody - too?",
                          "Then there’s a pair of us!",
                          "Don’t tell! they’d advertise - you know!"))
  d <- d %>% unnest_tokens(sentence, txt, token = "sentences")
  expect_equal(nrow(d), 6)
  expect_equal(ncol(d), 1)
  expect_equal(d$sentence[1], "i'm nobody!")
})

test_that("tokenizing by ngram and skip ngram works", {
  d2 <- data_frame(txt = c("Hope is the thing with feathers -",
                           "That perches in the soul -",
                           "And sings the tune without the words -",
                           "And never stops - at all -",
                           "And sweetest - in the Gale - is heard -",
                           "And sore must be the storm -",
                           "That could abash the little Bird",
                           "That kept so many warm -",
                           "I’ve heard it in the chillest land -",
                           "And on the strangest Sea -",
                           "Yet - never - in Extremity,",
                           "It asked a crumb - of me."))

  # tokenize by ngram
  d <- d2 %>% unnest_tokens(ngram, txt, token = "ngrams", n = 2)
  expect_equal(nrow(d), 57)
  expect_equal(ncol(d), 1)
  expect_equal(d$ngram[1], "hope is")
  expect_equal(d$ngram[10], "and sings")

  # tokenize by skip_ngram
  d <- d2 %>% unnest_tokens(ngram, txt, token = "skip_ngrams", n = 4, k = 2)
  expect_equal(nrow(d), 36)
  expect_equal(ncol(d), 1)
  expect_equal(d$ngram[1], "hope is the thing")
  expect_equal(d$ngram[10], "tune without the words")

})

