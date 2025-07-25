test_that("Can tidy DocumentTermMatrices and TermDocumentMatrices", {
  if (require("tm", quietly = TRUE)) {
    txt <- system.file("texts", "txt", package = "tm")
    ovid <- VCorpus(
      DirSource(txt, encoding = "UTF-8"),
      readerControl = list(language = "lat")
    )

    ovid_dtm <- DocumentTermMatrix(ovid)
    ovid_dtm_td <- tidy(ovid_dtm)

    expect_s3_class(ovid_dtm_td, "tbl_df")
    expect_equal(sort(unique(ovid_dtm_td$document)), sort(rownames(ovid_dtm)))
    expect_equal(sort(unique(ovid_dtm_td$term)), sort(colnames(ovid_dtm)))

    ovid_tdm <- TermDocumentMatrix(ovid)
    ovid_tdm_td <- tidy(ovid_tdm)

    expect_s3_class(ovid_tdm_td, "tbl_df")
    expect_equal(sort(unique(ovid_tdm_td$document)), sort(colnames(ovid_tdm)))
    expect_equal(sort(unique(ovid_tdm_td$term)), sort(rownames(ovid_tdm)))
  }
})

test_that("Can tidy dfm from quanteda", {
  if (requireNamespace("quanteda", quietly = TRUE)) {
    dfm_obj <- quanteda::dfm(quanteda::tokens(quanteda::data_corpus_inaugural))
    dfm_obj_td <- tidy(dfm_obj)

    expect_s3_class(dfm_obj_td, "tbl_df")
    expect_equal(sort(unique(dfm_obj_td$document)), sort(rownames(dfm_obj)))
    expect_equal(sort(unique(dfm_obj_td$term)), sort(colnames(dfm_obj)))
  }
})
