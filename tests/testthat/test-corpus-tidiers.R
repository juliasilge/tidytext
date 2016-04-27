context("Corpus tidiers")

test_that("Can tidy corpus from tm package", {
  if (require("tm", quietly = TRUE)) {
    #' # tm package examples
    txt <- system.file("texts", "txt", package = "tm")
    ovid <- VCorpus(DirSource(txt, encoding = "UTF-8"),
                    readerControl = list(language = "lat"))

    td <- tidy(ovid, collapse = " ")

    expect_equal(length(ovid), nrow(td))
    expect_equal(paste(as.character(ovid[[1]]), collapse = " "), td$text[1])
  }
})


test_that("Can tidy corpus from quanteda package", {
  if (requireNamespace("quanteda", quietly = TRUE)) {
    #' # tm package examples
    data("inaugCorpus", package = "quanteda")

    texts <- quanteda::texts(inaugCorpus)

    td <- tidy(inaugCorpus)

    expect_equal(length(texts), nrow(td))
    expect_true(all(td$text == texts))
  }
})
