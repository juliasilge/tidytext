# tests for pair_count function

context("Counting pairs")

suppressPackageStartupMessages(library(dplyr))

test_that("pairing and counting works", {
  original <- data_frame(txt = c("I felt a funeral in my brain,",
                                 "And mourners, to and fro,",
                                 "Kept treading, treading, till it seemed",
                                 "That sense was breaking through.")) %>%
    mutate(line = row_number()) %>%
    unnest_tokens(char, txt, token = "characters")

  d <- original %>%
    pair_count(line, char, sort = TRUE)

  expect_equal(nrow(d), 164)
  expect_equal(ncol(d), 3)
  expect_equal(d$value1[1], "e")
  expect_equal(d$value2[10], "r")
  expect_equal(d$n[20], 3)

  expect_false(any(d$value1 == d$value2))
  expect_false(is.unsorted(rev(d$n)))

  # test additional arguments

  # for self-pairs, the number of occurences should be the number of distinct
  # lines
  d2 <- original %>%
    pair_count(line, char, sort = TRUE, self = TRUE)

  self_pairs <- d2 %>%
    filter(value1 == value2) %>%
    arrange(value1)

  char_counts <- original %>%
    distinct(line, char) %>%
    count(char) %>%
    arrange(char)

  expect_true(all(self_pairs$value1 == char_counts$char))
  expect_true(all(self_pairs$n == char_counts$n))

  # when unique_pair is FALSE, should include twice as many items as original
  d3 <- original %>%
    pair_count(line, char, sort = TRUE, unique_pair = FALSE)

  expect_equal(nrow(d) * 2, nrow(d3))
  expect_true(all(sort(d3$value1) == sort(d3$value2)))
})

test_that("Counts co-occurences of words in Pride & Prejudice", {
  if (require("janeaustenr", quietly = TRUE)) {
    words <- data_frame(text = prideprejudice) %>%
      mutate(line = row_number()) %>%
      unnest_tokens(word, text)

    pairs <- words %>%
      pair_count(line, word, unique_pair = FALSE, self = TRUE, sort = TRUE)

    # check it is sorted in descending order
    expect_false(is.unsorted(rev(pairs$n)))

    # check occurences of words that appear with "elizabeth"
    words_with_elizabeth <- words %>%
      filter(word == "elizabeth") %>%
      select(line) %>%
      inner_join(words, by = "line") %>%
      distinct(word, line) %>%
      count(word) %>%
      arrange(n, word)

    pairs_with_elizabeth <- pairs %>%
      filter(value1 == "elizabeth") %>%
      arrange(n, value2)

    expect_true(all(words_with_elizabeth$word == pairs_with_elizabeth$value2))
    expect_true(all(words_with_elizabeth$n == pairs_with_elizabeth$n))
  }
})
