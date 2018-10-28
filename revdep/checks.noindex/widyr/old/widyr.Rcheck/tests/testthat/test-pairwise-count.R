# tests for pairwise_count function

context("pairwise_count")

suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(tidytext))

original <- data_frame(txt = c("I felt a funeral in my brain,",
                               "And mourners, to and fro,",
                               "Kept treading, treading, till it seemed",
                               "That sense was breaking through.")) %>%
  mutate(line = row_number()) %>%
  unnest_tokens(char, txt, token = "characters")

test_that("pairing and counting works", {
  d <- original %>%
    pairwise_count(char, line, sort = TRUE, upper = FALSE, diag = FALSE)

  expect_equal(nrow(d), 164)
  expect_equal(ncol(d), 3)
  expect_equal(d$item1[1], "e")
  expect_equal(d$item2[10], "r")
  expect_equal(d$n[20], 3)

  expect_false(any(d$item1 == d$item2))
  expect_false(is.unsorted(rev(d$n)))

  # test additional arguments

  # for self-pairs, the number of occurences should be the number of distinct
  # lines
  d2 <- original %>%
    pairwise_count(char, line, sort = TRUE, upper = FALSE, diag = TRUE)

  expect_equal(nrow(d2), nrow(d) + 20)

  self_pairs <- d2 %>%
    filter(item1 == item2) %>%
    arrange(item1)

  char_counts <- original %>%
    distinct(line, char) %>%
    count(char) %>%
    arrange(char)

  expect_true(all(self_pairs$item1 == char_counts$char))
  expect_true(all(self_pairs$n == char_counts$n))

  # when upper is TRUE, should include twice as many items as original
  d3 <- original %>%
    pairwise_count(char, line, sort = TRUE, upper = TRUE)

  expect_equal(nrow(d) * 2, nrow(d3))
  expect_true(all(sort(d3$item1) == sort(d3$item2)))
})


test_that("We can count with a weight column", {
  d <- data_frame(col1 = c("a", "a", "a", "b", "b", "b"),
                  col2 = c("x", "y", "z", "x", "x", "z"),
                  weight = c(1, 1, 1, 5, 5, 5))

  ret1 <- pairwise_count(d, col2, col1)
  expect_equal(ret1$n[ret1$item1 == "z" & ret1$item2 == "y"], 1)
  expect_equal(ret1$n[ret1$item1 == "z" & ret1$item2 == "x"], 2)

  ret2 <- pairwise_count(d, col2, col1, wt = weight)
  expect_equal(ret2$n[ret1$item1 == "z" & ret1$item2 == "y"], 1)
  expect_equal(ret2$n[ret1$item1 == "z" & ret1$item2 == "x"], 6)
})


test_that("Counts co-occurences of words in Pride & Prejudice", {
  if (require("janeaustenr", quietly = TRUE)) {
    words <- data_frame(text = prideprejudice) %>%
      mutate(line = row_number()) %>%
      unnest_tokens(word, text)

    pairs <- words %>%
      pairwise_count(word, line, upper = TRUE, diag = TRUE, sort = TRUE)

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
      filter(item1 == "elizabeth") %>%
      arrange(n, item2)

    expect_true(all(words_with_elizabeth$word == pairs_with_elizabeth$item2))
    expect_true(all(words_with_elizabeth$n == pairs_with_elizabeth$n))
  }
})

test_that("Can count within groups", {
  grouped_result <- mtcars %>%
    group_by(cyl) %>%
    pairwise_count(vs, am)

  expect_equal(as.character(groups(grouped_result)), c("cyl"))
  expect_equal(nrow(grouped_result), 2)
  expect_equal(colnames(grouped_result), c("cyl", "item1", "item2", "n"))
})
