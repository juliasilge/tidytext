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
    unnest_tokens(unit, txt, token = stringr::str_split,
                  pattern = " - ", collapse = TRUE)
  expect_equal(nrow(d2), 4)
  expect_equal(d2$unit[2], "nobody")
  expect_equal(d2$unit[4], "you know!")
})

test_that("tokenizing with standard evaluation works", {
  d <- data_frame(txt = c("Because I could not stop for Death -",
                          "He kindly stopped for me -"))
  d <- d %>% unnest_tokens_("word", "txt")
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")

})

test_that("tokenizing with tidyeval works", {
  d <- data_frame(txt = c("Because I could not stop for Death -",
                          "He kindly stopped for me -"))
  outputvar <- quo("word")
  inputvar <- quo("txt")
  d <- d %>% unnest_tokens(!!outputvar, !!inputvar)
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")

})

test_that("unnest_tokens raises an error if there is a list column present", {
  d <- data_frame(a = c("hello world", "goodbye world"), b = list(1:2, 3:4))
  expect_error(unnest_tokens(d, word, a), "atomic vectors")
})

test_that("tokenizing with to_lower = FALSE works", {
  orig <- data_frame(txt = c("Because I could not stop for Death -",
                          "He kindly stopped for me -"))
  d <- orig %>% unnest_tokens(word, txt, to_lower = FALSE)
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "Because")
  d2 <- orig %>% unnest_tokens(ngram, txt, token = "ngrams",
                           n = 2, to_lower = FALSE)
  expect_equal(nrow(d2), 11)
  expect_equal(ncol(d2), 1)
  expect_equal(d2$ngram[1], "Because I")
})


test_that("unnest_tokens raises an error if custom tokenizer gives bad output", {
  d <- data_frame(txt = "Emily Dickinson")

  expect_error(unnest_tokens(d, word, txt, token = function(e) c("a", "b")),
               "to be a list")
  expect_error(unnest_tokens(d, word, txt, token = function(e) list("a", "b")),
               "of length")
})


test_that("tokenizing HTML works", {
  h <- data_frame(row = 1:2,
                  text = c("<h1>Text <b>is<b>", "<a href='example.com'>here</a>"))

  res1 <- unnest_tokens(h, word, text)
  expect_gt(nrow(res1), 3)
  expect_equal(res1$word[1], "h1")

  res2 <- unnest_tokens(h, word, text, format = "html")
  expect_equal(nrow(res2), 3)
  expect_equal(res2$word, c("text", "is", "here"))
  expect_equal(res2$row, c(1, 1, 2))
})


test_that("tokenizing LaTeX works", {
  h <- data_frame(row = 1:4,
                  text = c("\\textbf{text} \\emph{is}", "\\begin{itemize}",
                           "\\item here", "\\end{itemize}"))

  res1 <- unnest_tokens(h, word, text)
  expect_gt(nrow(res1), 3)
  expect_equal(res1$word[1], "textbf")

  res2 <- unnest_tokens(h, word, text, format = "latex")
  expect_equal(nrow(res2), 3)
  expect_equal(res2$word, c("text", "is", "here"))
  expect_equal(res2$row, c(1, 1, 3))
})

test_that("Tokenizing a one-column data.frame works", {
  text <- data.frame(txt = c("Because I could not stop for Death -",
                             "He kindly stopped for me -"),
                     stringsAsFactors = FALSE)
  d <- unnest_tokens(text, word, txt)

  expect_is(d, "data.frame")
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")
})

test_that("Tokenizing a two-column data.frame with one non-text column works", {
  text <- data.frame(line = 1:2,
                  txt = c("Because I could not stop for Death -",
                          "He kindly stopped for me -"),
                  stringsAsFactors = FALSE)
  d <- unnest_tokens(text, word, txt)

  expect_is(d, "data.frame")
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 2)
  expect_equal(d$word[1], "because")
  expect_equal(d$line[1], 1)
})

test_that("Trying to tokenize a non-text format with words raises an error", {
  d <- data_frame(txt = "Emily Dickinson")
  expect_error(unnest_tokens(d, word, txt, token = "sentences",
                             format = "latex"),
               "except words")
})

test_that("unnest_tokens keeps top-level attributes", {
  # first check data.frame
  d <- data.frame(row = 1:2,
                         txt = c("Call me Ishmael.", "OK, I will."),
                         stringsAsFactors = FALSE)

  lst <- list(1, 2, 3, 4)
  attr(d, "custom") <- lst
  result <- unnest_tokens(d, word, txt)
  expect_equal(attr(result, "custom"), lst)

  # now tbl_df
  d2 <- dplyr::tbl_df(d)
  attr(d2, "custom") <- list(1, 2, 3, 4)
  result <- unnest_tokens(d2, word, txt)
  expect_equal(attr(result, "custom"), lst)
})


test_that("Trying to tokenize a data.table works", {
  skip_if_not_installed("data.table")
  text <- data.table::data.table(txt = "Write till my fingers look like a bouquet of roses",
                     author = "Watsky")
  output <- unnest_tokens(text, word, txt)
  expect_equal(ncol(output), 2)
  expect_equal(nrow(output), 10)
  expect_equal(output$word[1], "write")
  expect_equal(output$author[1], "Watsky")
})

test_that("Trying to tokenize a data.table work when the input has only one column", {
  skip_if_not_installed("data.table")
  text <- data.table::data.table(txt = "You gotta bring yourself your flowers now in showbiz")
  output <- unnest_tokens(text, word, txt)
  expect_equal(ncol(output), 1)
  expect_equal(nrow(output), 9)
  expect_equal(output$word[1], "you")
})

test_that("custom attributes are preserved for a data.table", {
  skip_if_not_installed("data.table")
  text <- data.table::data.table(txt = "You gotta bring yourself your flowers now in showbiz")
  attr(text, "testattr") <- list(1, 2, 3, 4)

  output <- unnest_tokens(text, word, txt)

  expect_equal(ncol(output), 1)
  expect_equal(nrow(output), 9)
  expect_equal(output$word[1], "you")
  expect_equal(attr(output, "testattr"), list(1, 2, 3, 4))
})


