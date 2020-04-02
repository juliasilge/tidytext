context("tf-idf calculation")

w <- tibble(
  document = rep(1:2, each = 5),
  word = c(
    "the", "quick", "brown", "fox", "jumped",
    "over", "the", "lazy", "brown", "dog"
  ),
  frequency = c(
    1, 1, 1, 1, 2,
    1, 1, 1, 1, 2
  )
)

test_that("Can calculate TF-IDF", {
  result <- w %>%
    bind_tf_idf(word, document, frequency)
  result2 <- w %>%
    bind_tf_idf("word", "document", "frequency")
  expect_equal(result, result2)

  expect_equal(
    select(w, document, word, frequency),
    select(result, document, word, frequency)
  )

  expect_is(result, "tbl_df")
  expect_is(result$tf, "numeric")
  expect_is(result$idf, "numeric")
  expect_is(result$tf_idf, "numeric")

  expect_equal(result$tf, rep(c(1 / 6, 1 / 6, 1 / 6, 1 / 6, 1 / 3), 2))
  expect_equal(result$idf[1:4], c(0, log(2), 0, log(2)))
  expect_equal(result$tf_idf, result$tf * result$idf)

  # preserves but ignores groups
  result2 <- w %>%
    group_by(document) %>%
    bind_tf_idf(word, document, frequency)

  expect_equal(length(groups(result2)), 1)
  expect_equal(as.character(groups(result2)[[1]]), "document")
})


test_that("TF-IDF works when the document ID is a number", {
  # example thanks to https://github.com/juliasilge/tidytext/issues/31
  my_corpus <- dplyr::tibble(
    id = rep(c(2, 3), each = 3),
    word = c("an", "interesting", "text", "a", "boring", "text"),
    n = c(1, 1, 3, 1, 2, 1)
  )

  tf_idf <- bind_tf_idf(my_corpus, word, id, n)
  expect_false(any(is.na(tf_idf)))
  expect_equal(tf_idf$tf_idf[c(3, 6)], c(0, 0))
})


test_that("tf-idf with tidyeval works", {
  d <- tibble(txt = c(
    "Because I could not stop for Death -",
    "He kindly stopped for me -"
  ))
  termvar <- quo("word")
  documentvar <- quo("document")
  countvar <- quo("frequency")

  result <- w %>%
    bind_tf_idf(!!termvar, !!documentvar, !!countvar)

  expect_equal(
    select(w, document, word, frequency),
    select(result, document, word, frequency)
  )

  expect_is(result, "tbl_df")
  expect_is(result$tf, "numeric")
  expect_is(result$idf, "numeric")
  expect_is(result$tf_idf, "numeric")

  expect_equal(result$tf, rep(c(1 / 6, 1 / 6, 1 / 6, 1 / 6, 1 / 3), 2))
  expect_equal(result$idf[1:4], c(0, log(2), 0, log(2)))
  expect_equal(result$tf_idf, result$tf * result$idf)

  result2 <- w %>%
    group_by(document) %>%
    bind_tf_idf(!!termvar, !!documentvar, !!countvar)

  expect_equal(length(groups(result2)), 1)
  expect_equal(as.character(groups(result2)[[1]]), "document")
})
