test_that("unnest_regex works", {
  r <- unnest_regex(skspr, out, txt)
  s <- unnest_tokens(skspr, out, txt, token = "regex")
  expect_equal(r, s)
  r <- unnest_regex(skspr, out, txt, pattern = "a")
  s <- unnest_tokens(skspr, out, txt, token = "regex", pattern = "a")
  expect_equal(r, s)
})
