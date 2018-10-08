context('test stopwords.R')

test_that("old stopwords are the same as the new", {

    load("../data/data_char_stopwords.rda")
    stopwords_old <- function(kind = "english", swdata) {
        if (!(kind %in% names(swdata)))
            stop(paste0("\"", kind, "\" is not a recognized stopword list name."))
        swdata[[kind]]
    }

    expect_equal(
        stopwords_old("english", data_char_stopwords),
        stopwords::stopwords("english", source = "snowball")
    )
    expect_equal(
        stopwords_old("SMART", data_char_stopwords),
        stopwords::stopwords("english", source = "smart")
    )
    expect_equal(
        stopwords_old("SMART", data_char_stopwords),
        suppressWarnings(stopwords::stopwords("smart"))
    )
    expect_equal(
        stopwords_old("chinese", data_char_stopwords),
        stopwords::stopwords("chinese", source = "misc")
    )
    expect_equal(
        stopwords_old("chinese", data_char_stopwords),
        suppressWarnings(stopwords::stopwords("chinese"))
    )
    expect_equal(
        stopwords_old("catalan", data_char_stopwords),
        stopwords::stopwords("catalan", source = "misc")
    )
    expect_equal(
        stopwords_old("arabic", data_char_stopwords),
        stopwords::stopwords("arabic", source = "misc")
    )
    expect_equal(
        stopwords_old("arabic", data_char_stopwords),
        suppressWarnings(stopwords::stopwords("arabic"))
    )
})
