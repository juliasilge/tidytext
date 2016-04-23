# tests for pair_count function

context("function to pair and count")

suppressPackageStartupMessages(library(dplyr))

test_that("pairing and counting works", {
  d <- data_frame(txt = c("I felt a funeral in my brain,",
                          "And mourners, to and fro,",
                          "Kept treading, treading, till it seemed",
                          "That sense was breaking through."))
  d <- d %>% mutate(line = row_number()) %>%
    unnest_tokens(char, txt, token = "characters")
  d <- d %>% pair_count(line, char, sort = TRUE)
  expect_equal(nrow(d), 164)
  expect_equal(ncol(d), 3)
  expect_equal(d$value1[1], "e")
  expect_equal(d$value2[10], "r")
  expect_equal(d$n[20], 3)
})
