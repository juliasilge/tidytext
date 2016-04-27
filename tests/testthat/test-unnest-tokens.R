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



