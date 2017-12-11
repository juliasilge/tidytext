context("stopwords")

test_that("english stopwords works", {
  en <- get_stopwords("en")
  expect_equal(nrow(en), 1149)
  expect_equal(unique(en$lexicon), c("SMART", "snowball", "onix"))
})

test_that("french stopwords works", {
  fr <- get_stopwords("fr")
  expect_equal(nrow(fr), 783)
})
