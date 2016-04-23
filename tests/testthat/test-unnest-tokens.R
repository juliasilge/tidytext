# tests for unnest_tokens function

context("function to unnest and tokenize")

suppressPackageStartupMessages(library(dplyr))

test_that("tokenizing by character works", {
  d <- data_frame(txt = "Emily Dickinson")
  d <- d %>% unnest_tokens(char, txt, token = "characters")
  expect_equal(d,
               data_frame(char =
                            c("e","m","i","l","y","d","i","c","k","i","n","s","o","n")))
})

test_that("tokenizing by word works", {
  d <- data_frame(txt = c("Because I could not stop for Death –",
                          "He kindly stopped for me –"))
  d <- d %>% unnest_tokens(word, txt)
  expect_equal(d,
               data_frame(word =
                            c("because","i","could","not","stop","for",
                              "death","he","kindly","stopped","for","me")))
})

test_that("tokenizing by sentence works", {
  d <- data_frame(txt = c("I’m Nobody! Who are you?",
                          "Are you – Nobody – too?",
                          "Then there’s a pair of us!",
                          "Don’t tell! they’d advertise – you know!"))
  d <- d %>% unnest_tokens(sentence, txt, token = "sentences")
  expect_equal(d,
               data_frame(sentence =
                            c("i’m nobody!",
                              "who are you?",
                              "are you – nobody – too?",
                              "then there’s a pair of us!",
                              "don’t tell!",
                              "they’d advertise – you know!")))
})



