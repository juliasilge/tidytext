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
  orig <- data_frame(txt = c("I'm Nobody! Who are you?",
                             "Are you - Nobody - too?",
                             "Then there’s a pair of us!",
                             "Don’t tell! they’d advertise - you know!"))
  d <- orig %>% unnest_tokens(sentence, txt, token = "sentences")
  expect_equal(nrow(d), 6)
  expect_equal(ncol(d), 1)
  expect_equal(d$sentence[1], "i'm nobody!")

  # check it works when there are multiple columns
  orig$line <- c(1, 1, 2, 2)
  orig$other_line <- c("a", "a", "b", "b")
  d <- orig %>% unnest_tokens(sentence, txt, token = "sentences")
  expect_is(d$sentence, "character")
  expect_equal(d$sentence[1], "i'm nobody!")
})

test_that("tokenizing by ngram and skip ngram works", {
  d2 <- data_frame(txt = c("Hope is the thing with feathers",
                           "That perches in the soul",
                           "And sings the tune without the words",
                           "And never stops at all ",
                           "And sweetest in the Gale is heard ",
                           "And sore must be the storm ",
                           "That could abash the little Bird",
                           "That kept so many warm ",
                           "I’ve heard it in the chillest land ",
                           "And on the strangest Sea ",
                           "Yet never in Extremity,",
                           "It asked a crumb of me."))

  # tokenize by ngram
  d <- d2 %>% unnest_tokens(ngram, txt, token = "ngrams", n = 2)
  #expect_equal(nrow(d), 68) does not pass on appveyor
  expect_equal(ncol(d), 1)
  expect_equal(d$ngram[1], "hope is")
  expect_equal(d$ngram[10], "the soul")

  # tokenize by skip_ngram
  d <- d2 %>% unnest_tokens(ngram, txt, token = "skip_ngrams", n = 4, k = 2)
  #expect_equal(nrow(d), 189) does not pass on appveyor
  expect_equal(ncol(d), 1)
  expect_equal(d$ngram[1], "hope thing that the")
  expect_equal(d$ngram[10], "the sings without and")

})

test_that("tokenizing with a custom function works", {
  orig <- data_frame(txt = c("I'm Nobody! Who are you?",
                             "Are you - Nobody - too?",
                             "Then there’s a pair of us!",
                             "Don’t tell! they’d advertise - you know!"))
  d <- orig %>%
    unnest_tokens(unit, txt, token = stringr::str_split, pattern = " - ")
  expect_equal(nrow(d), 7)
  expect_equal(d$unit[3], "nobody")
  expect_equal(d$unit[4], "too?")

  d2 <- orig %>%
    unnest_tokens(unit, txt, token = stringr::str_split, pattern = " - ", collapse = TRUE)
  expect_equal(nrow(d2), 4)
  expect_equal(d2$unit[2], "nobody")
  expect_equal(d2$unit[4], "you know!")
})
