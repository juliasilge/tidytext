test_that("unnest_characters works", {
  d <- tibble(txt = "Emily Dickinson")
  r <- unnest_characters(d, out, txt)
  s <- unnest_tokens(d, out, txt, token = "characters")
  expect_equal(r, s)
})

test_that("unnest_character_shingles works", {
  d <- tibble(txt = "tidytext is the best")
  r <- unnest_character_shingles(d, out, txt)
  s <- d %>% unnest_tokens(out, txt, token = "character_shingles")
  expect_equal(r, s)

  r <- unnest_character_shingles(d, out, txt, n = 3, n_min = 3)
  s <- d %>% unnest_tokens(out, txt, token = "character_shingles", n = 3, n_min = 3)
  expect_equal(r, s)

  d <- tibble(txt = "Emily Dickinson")
  r <- unnest_character_shingles(d, out, txt, to_lower = FALSE)
  s <- unnest_tokens(d, out, txt, token = "character_shingles", to_lower = FALSE)
  expect_equal(r, s)
})
