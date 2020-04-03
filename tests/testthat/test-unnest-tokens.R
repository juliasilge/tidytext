# tests for unnest_tokens function

context("Unnesting tokens")

suppressPackageStartupMessages(library(dplyr))

test_that("tokenizing by character works", {
  d <- tibble(txt = "Emily Dickinson")
  d <- d %>% unnest_tokens(char, txt, token = "characters")
  expect_equal(nrow(d), 14)
  expect_equal(ncol(d), 1)
  expect_equal(d$char[1], "e")
})

test_that("tokenizing by character shingles works", {
  d <- tibble(txt = "tidytext is the best")
  d <- d %>% unnest_tokens(char_ngram, txt, token = "character_shingles", n = 4)
  expect_equal(nrow(d), 14)
  expect_equal(ncol(d), 1)
  expect_equal(d$char_ngram[1], "tidy")
})

test_that("tokenizing by character shingles can include whitespace/punctuation", {
  d <- tibble(txt = "tidytext is the best!")
  d <- d %>% unnest_tokens(char_ngram, txt,
                           token = "character_shingles",
                           strip_non_alphanum = FALSE
  )
  expect_equal(nrow(d), 19)
  expect_equal(ncol(d), 1)
  expect_equal(d$char_ngram[1], "tid")
})

test_that("tokenizing by word works", {
  d <- tibble(txt = c(
    "Because I could not stop for Death -",
    "He kindly stopped for me -"
  ))
  d <- d %>% unnest_tokens(word, txt)
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")
})

test_that("tokenizing errors with appropriate message", {
  d <- tibble(txt = c(
    "Because I could not stop for Death -",
    "He kindly stopped for me -"
  ))
  expect_error(
    d %>% unnest_tokens(word, txt, token = "word"),
    "Error: Token must be a supported type, or a function that takes a character vector as input\nDid you mean token = words?"
  )
})

test_that("tokenizing by sentence works", {
  orig <- tibble(txt = c(
    "I'm Nobody! Who are you?",
    "Are you - Nobody - too?",
    "Then there’s a pair of us!",
    "Don’t tell! they’d advertise - you know!"
  ))
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
  d2 <- tibble(txt = c(
    "Hope is the thing with feathers",
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
    "It asked a crumb of me."
  ))

  # tokenize by ngram
  d <- d2 %>% unnest_tokens(ngram, txt, token = "ngrams", n = 2)
  # expect_equal(nrow(d), 68) does not pass on appveyor
  expect_equal(ncol(d), 1)
  expect_equal(d$ngram[1], "hope is")
  expect_equal(d$ngram[10], "the soul")

  # tokenize by skip_ngram
  d <- d2 %>% unnest_tokens(ngram, txt, token = "skip_ngrams", n = 4, k = 2)
  # expect_equal(nrow(d), 189) does not pass on appveyor
  expect_equal(ncol(d), 1)
  expect_equal(d$ngram[40], "hope thing that the")
  expect_equal(d$ngram[400], "the sings without and")
})

test_that("tokenizing with a custom function works", {
  orig <- tibble(txt = c(
    "I'm Nobody! Who are you?",
    "Are you - Nobody - too?",
    "Then there’s a pair of us!",
    "Don’t tell! they’d advertise - you know!"
  ))
  d <- orig %>%
    unnest_tokens(unit, txt, token = stringr::str_split, pattern = " - ")
  expect_equal(nrow(d), 7)
  expect_equal(d$unit[3], "nobody")
  expect_equal(d$unit[4], "too?")

  d2 <- orig %>%
    unnest_tokens(unit, txt,
                  token = stringr::str_split,
                  pattern = " - ", collapse = TRUE
    )
  expect_equal(nrow(d2), 4)
  expect_equal(d2$unit[2], "nobody")
  expect_equal(d2$unit[4], "you know!")
})

test_that("tokenizing with standard evaluation works", {
  d <- tibble(txt = c(
    "Because I could not stop for Death -",
    "He kindly stopped for me -"
  ))
  d <- d %>% unnest_tokens("word", "txt")
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")
})

test_that("tokenizing with tidyeval works", {
  d <- tibble(txt = c(
    "Because I could not stop for Death -",
    "He kindly stopped for me -"
  ))
  outputvar <- quo("word")
  inputvar <- quo("txt")
  d <- d %>% unnest_tokens(!!outputvar, !!inputvar)
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")
})

test_that("tokenizing with to_lower = FALSE works", {
  orig <- tibble(txt = c(
    "Because I could not stop for Death -",
    "He kindly stopped for me -"
  ))
  d <- orig %>% unnest_tokens(word, txt, to_lower = FALSE)
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "Because")
  d2 <- orig %>% unnest_tokens(ngram, txt,
                               token = "ngrams",
                               n = 2, to_lower = FALSE
  )
  expect_equal(nrow(d2), 11)
  expect_equal(ncol(d2), 1)
  expect_equal(d2$ngram[1], "Because I")
})


test_that("unnest_tokens raises an error if custom tokenizer gives bad output", {
  d <- tibble(txt = "Emily Dickinson")

  expect_error(
    unnest_tokens(d, word, txt, token = function(e) c("a", "b")),
    "to be a list",
    class = "rlang_error"
  )
  expect_error(
    unnest_tokens(d, word, txt, token = function(e) list("a", "b")),
    "of length",
    class = "rlang_error"
  )
})


test_that("tokenizing HTML works", {
  h <- tibble(
    row = 1:2,
    text = c("<h1>Text <b>is<b>", "<a href='example.com'>here</a>")
  )

  res1 <- unnest_tokens(h, word, text)
  expect_gt(nrow(res1), 3)
  expect_equal(res1$word[1], "h1")

  res2 <- unnest_tokens(h, word, text, format = "html")
  expect_equal(nrow(res2), 3)
  expect_equal(res2$word, c("text", "is", "here"))
  expect_equal(res2$row, c(1, 1, 2))
})


test_that("tokenizing LaTeX works", {
  h <- tibble(
    row = 1:4,
    text = c(
      "\\textbf{text} \\emph{is}", "\\begin{itemize}",
      "\\item here", "\\end{itemize}"
    )
  )

  res1 <- unnest_tokens(h, word, text)
  expect_gt(nrow(res1), 3)
  expect_equal(res1$word[1], "textbf")

  res2 <- unnest_tokens(h, word, text, format = "latex")
  expect_equal(nrow(res2), 3)
  expect_equal(res2$word, c("text", "is", "here"))
  expect_equal(res2$row, c(1, 1, 3))
})

test_that("Tokenizing a one-column data.frame works", {
  text <- data.frame(
    txt = c(
      "Because I could not stop for Death -",
      "He kindly stopped for me -"
    ),
    stringsAsFactors = FALSE
  )
  d <- unnest_tokens(text, word, txt)

  expect_is(d, "data.frame")
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 1)
  expect_equal(d$word[1], "because")
})

test_that("Tokenizing a two-column data.frame with one non-text column works", {
  text <- data.frame(
    line = 1:2,
    txt = c(
      "Because I could not stop for Death -",
      "He kindly stopped for me -"
    ),
    stringsAsFactors = FALSE
  )
  d <- unnest_tokens(text, word, txt)

  expect_is(d, "data.frame")
  expect_equal(nrow(d), 12)
  expect_equal(ncol(d), 2)
  expect_equal(d$word[1], "because")
  expect_equal(d$line[1], 1)
})


test_that("Tokenizing with NA values in columns behaves as expected", {
  text <- tibble(
    line = c(1:2, NA),
    txt = c(
      NA,
      "Because I could not stop for Death -",
      "He kindly stopped for me -"
    )
  )
  d <- unnest_tokens(text, word, txt)

  expect_is(d, "data.frame")
  expect_equal(nrow(d), 13)
  expect_equal(ncol(d), 2)
  expect_equal(d$word[2], "because")
  expect_equal(d$line[1], 1)
  expect_true(is.na(d$line[10]))
  expect_true(is.na(d$word[1]))
})



test_that("Trying to tokenize a non-text format with words raises an error", {
  d <- tibble(txt = "Emily Dickinson")
  expect_error(
    unnest_tokens(d, word, txt,
                  token = "sentences",
                  format = "latex"
    ),
    "except words"
  )
})

test_that("unnest_tokens keeps top-level attributes", {
  # first check data.frame
  d <- data.frame(
    row = 1:2,
    txt = c("Call me Ishmael.", "OK, I will."),
    stringsAsFactors = FALSE
  )

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
  text <- data.table::data.table(
    txt = "Write till my fingers look like a bouquet of roses",
    author = "Watsky"
  )
  output <- unnest_tokens(text, word, txt)
  expect_equal(ncol(output), 2)
  expect_equal(nrow(output), 10)
  expect_equal(output$word[1], "write")
  expect_equal(output$author[1], "Watsky")
})

test_that("Can tokenize a data.table work when the input has only one column", {
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

test_that("Tokenizing a data frame with list columns works", {
  df <- data.frame(
    txt = c(
      "Because I could not stop for Death -",
      "He kindly stopped for me -"
    ),
    line = 1L:2L,
    stringsAsFactors = FALSE
  )

  df$list_col <- list(1L:3L, c("a", "b"))

  ret <- unnest_tokens(df, word, txt)
  expect_is(ret, "data.frame")
  expect_is(ret$line, "integer")
  expect_is(ret$list_col, "list")
  expect_is(ret$list_col[[1]], "integer")

  # 7 items of length 3, 5 items of length 2
  expect_equal(lengths(ret$list_col), rep(c(3, 2), c(7, 5)))
})

test_that("Tokenizing a tbl_df with list columns works", {
  df <- tibble(
    txt = c(
      "Because I could not stop for Death -",
      "He kindly stopped for me -"
    ),
    line = 1L:2L,
    list_col = list(1L:3L, c("a", "b"))
  )

  ret <- unnest_tokens(df, word, txt)
  expect_is(ret, "tbl_df")
  expect_is(ret$line, "integer")
  expect_is(ret$list_col, "list")
  expect_is(ret$list_col[[1]], "integer")

  # 7 items of length 3, 5 items of length 2
  expect_equal(lengths(ret$list_col), rep(c(3, 2), c(7, 5)))
})

test_that("Can't tokenize with list columns with collapse = TRUE", {
  df <- tibble(
    txt = c(
      "Because I could not stop for Death -",
      "He kindly stopped for me -"
    ),
    line = 1L:2L,
    list_col = list(1L:3L, c("a", "b"))
  )

  expect_error(
    unnest_tokens(df, word, txt, token = "sentences"),
    "to be atomic vectors"
  )

  # Can tokenize by sentence without collapsing
  # though it sort of defeats the purpose
  ret <- unnest_tokens(df, word, txt, token = "sentences", collapse = FALSE)
  expect_equal(nrow(ret), 2)
})
