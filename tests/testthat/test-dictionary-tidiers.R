
if (requireNamespace("quanteda", quietly = TRUE)) {
  test_that("can tidy a quanteda dictionary", {
    lst <- list(
      terror = c("terrorism", "terrorists", "threat"),
      economy = c("jobs", "business", "grow", "work")
    )
    d <- quanteda::dictionary(lst)

    td <- tidy(d)
    expect_s3_class(td, "tbl_df")
    expect_type(td$category, "character")
    expect_type(td$word, "character")

    expect_equal(nrow(td), 7)
    expect_equal(sort(unique(td$category)), c("economy", "terror"))
    expect_equal(
      sort(unique(td$word)),
      sort(unique(c(lst[[1]], lst[[2]])))
    )
  })
}
