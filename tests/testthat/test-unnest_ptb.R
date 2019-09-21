test_that("unnest_ptb works", {
  d <- tibble(txt = janeaustenr::prideprejudice)
  r <- unnest_ptb(d, out, txt)
  s <- unnest_tokens(d, out, txt, token = "ptb")
  expect_equal(r, s)
  r <- unnest_ptb(d, out, txt, simplify = TRUE)
  s <- unnest_tokens(d, out, txt, token = "ptb", simplify = TRUE)
  expect_equal(r, s)
})
