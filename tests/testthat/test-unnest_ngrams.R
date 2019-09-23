test_that("unnest_ngrams works", {
  r <- unnest_ngrams(skspr, out, txt)
  expect_nrow(r, 24)
  expect_first_row(r, out, "now is the")
  r <- unnest_ngrams(skspr, out, txt, n = 4)
  expect_nrow(r, 20)
  expect_first_row(r, out, "now is the winter")
})

test_that("unnest_skip_ngrams works", {
  r <- unnest_skip_ngrams(song_df, out, txt, n = 4)
  s <- unnest_tokens(song_df, out, txt, n = 4, token = "skip_ngrams")
  expect_equal(r, s)
  r <- unnest_skip_ngrams(skspr, out, txt, n = 3, k = 2)
  s <- unnest_tokens(skspr, out, txt, token = "skip_ngrams", n = 3, k = 2)
  expect_equal(r, s)
})
