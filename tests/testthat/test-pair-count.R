# tests for pair_count function

context("Counting pairs")

suppressPackageStartupMessages(library(dplyr))

test_that("pairing and counting raises an error", {
  original <- data_frame(txt = c("I felt a funeral in my brain,",
                                 "And mourners, to and fro,",
                                 "Kept treading, treading, till it seemed",
                                 "That sense was breaking through.")) %>%
    mutate(line = row_number()) %>%
    unnest_tokens(char, txt, token = "characters")

  expect_error(original %>%
                 pair_count(line, char, sort = TRUE))

})

