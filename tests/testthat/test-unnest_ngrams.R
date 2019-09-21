test_that("unnest_ngrams works", {
  r <- unnest_ngrams(skspr, out, txt)
  expect_nrow(r, 24)
  expect_first_row(r, out, "now is the")
  r <- unnest_ngrams(skspr, out, txt, n = 4)
  expect_nrow(r, 20)
  expect_first_row(r, out, "now is the winter")
  r <- unnest_ngrams(skspr, out, txt, n = 4, stopwords = c("the"))
  expect_nrow( r, 16 )
  expect_first_row(r, out, "now is winter")
})

test_that("unnest_skip_ngrams works", {
  song <-  paste0("How many roads must a man walk down\n",
                  "Before you call him a man?\n",
                  "How many seas must a white dove sail\n",
                  "Before she sleeps in the sand?\n",
                  "\n",
                  "How many times must the cannonballs fly\n",
                  "Before they're forever banned?\n",
                  "The answer, my friend, is blowin' in the wind.\n",
                  "The answer is blowin' in the wind.\n")
  r <- unnest_skip_ngrams(song_df, out, txt, n = 4)
  s <- unnest_tokens(song_df, out, txt, n = 4, token = "skip_ngrams")
  expect_equal(r, s)
  r <- unnest_skip_ngrams(song_df, out, txt, n = 4, stopwords = c("how"))
  s <- unnest_tokens(song_df, out, txt, n = 4, stopwords = c("how"), token = "skip_ngrams")
  expect_equal(r, s)
})
