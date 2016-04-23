# tests for pair_count function

context("function to pair and count")

test_that("pairing and counting works", {
  d <- data_frame(txt = c("I felt a funeral in my brain,",
                          "And mourners, to and fro,",
                          "Kept treading, treading, till it seemed",
                          "That sense was breaking through."))
  d <- d %>% mutate(line = row_number()) %>%
    unnest_tokens(char, txt, token = "characters")
  d <- d %>% pair_count(line, char, sort = TRUE)
  expect_equal(d$value1[1:4], c("e","e","t","e"))
  expect_equal(d$value2[1:4], c("t","a","a","n"))
  expect_equal(d$n[1:4], rep(4,4))
})
