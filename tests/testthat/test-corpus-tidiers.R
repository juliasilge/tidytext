context("Corpus tidiers")

test_that("Can tidy corpus from tm package", {
  if (require("tm", quietly = TRUE)) {
    #' # tm package examples
    txt <- system.file("texts", "txt", package = "tm")
    ovid <- VCorpus(DirSource(txt, encoding = "UTF-8"),
                    readerControl = list(language = "lat")
    )

    td <- tidy(ovid, collapse = " ")

    expect_equal(length(ovid), nrow(td))
    expect_equal(paste(as.character(ovid[[1]]), collapse = " "), td$text[1])
  }
})


test_that("Can tidy corpus from quanteda package", {
  if (requireNamespace("quanteda", quietly = TRUE)) {
    #' # tm package examples
    data("data_corpus_inaugural", package = "quanteda")

    texts <- quanteda::texts(data_corpus_inaugural)

    td <- tidy(data_corpus_inaugural)

    expect_equal(length(texts), nrow(td))
    expect_true(all(td$text == texts))
  }
})

test_that("Can tidy corpus from quanteda using accessor functions", {
  if (requireNamespace("quanteda", quietly = TRUE)) {
    x <- quanteda::data_corpus_inaugural

    ## old method
    ret_old <- tbl_df(x$documents) %>%
      rename(text = texts)

    ## new method
    ret_new <- tidy(x)

    expect_identical(ret_old, ret_new)
  }
})

test_that("Can glance a corpus from quanteda using accessor functions", {
  if (requireNamespace("quanteda", quietly = TRUE)) {
    x <- quanteda::data_corpus_inaugural

    ## old method
    glance_old <- function(x, ...) {
      md <- purrr::compact(x$metadata)
      # turn vectors into list columns
      md <- purrr::map_if(md, ~ length(.) > 1, list)
      as_tibble(md)
    }
    ret_old <- glance_old(x)

    ## new method
    ret_new <- glance(x)

    expect_identical(ret_old, ret_new)
  }
})
