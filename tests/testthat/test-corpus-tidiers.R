context("Corpus tidiers")

test_that("Can tidy corpus from tm package", {
  skip_if_not_installed("tm")
  # tm package examples
  txt <- system.file("texts", "txt", package = "tm")
  ovid <- tm::VCorpus(
    tm::DirSource(txt, encoding = "UTF-8"),
    readerControl = list(language = "lat")
  )

  td <- tidy(ovid, collapse = " ")

  expect_equal(length(ovid), nrow(td))
  expect_equal(paste(as.character(ovid[[1]]), collapse = " "),
               unname(td$text[1]))

})


test_that("Can tidy corpus from quanteda package", {
  skip_if_not_installed("quanteda")
  data("data_corpus_inaugural", package = "quanteda")

  texts <- quanteda::texts(data_corpus_inaugural)

  td <- tidy(data_corpus_inaugural)

  expect_equal(length(texts), nrow(td))
  expect_true(all(td$text == texts))
})

test_that("Can tidy corpus from quanteda using accessor functions", {
  skip_if_not_installed("quanteda")
  x <- quanteda::data_corpus_inaugural

  ## similar to old method
  ret_old <- as_tibble(quanteda::docvars(x)) %>%
    mutate(text = unname(quanteda::texts(x))) %>%
    select(text, everything())

  ## new method
  ret_new <- tidy(x)

  expect_identical(ret_old, ret_new)
})

test_that("Can glance a corpus from quanteda using accessor functions", {
  skip_if_not_installed("quanteda")
  x <- quanteda::data_corpus_inaugural

  ## old method
  glance_old <- function(x, ...) {
    md <- purrr::compact(quanteda::metacorpus(x))
    # turn vectors into list columns
    md <- purrr::map_if(md, ~ length(.) > 1, list)
    as_tibble(md)
  }
  ret_old <- glance_old(x)

  ## new method
  ret_new <- glance(x)

  expect_identical(ret_old, ret_new)
})
