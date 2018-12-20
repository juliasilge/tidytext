## issue #1285

test_that("summary method works for corpus", {
    expect_output(
        summary(print(data_corpus_irishbudget2010)), 
        regexp = "^Corpus consisting of 14 documents"
    )
})

test_that("summary.corpus with verbose prints warning", {
    expect_warning(
        summary(data_corpus_irishbudget2010, verbose = FALSE),
        "verbose argument is defunct"
    )        
})

test_that("summary.corpus works with longer corpora n > default (#1242)", {
    longcorp <- corpus(
        rep(LETTERS, 4), 
        docvars = data.frame(label = rep(paste("document", 1:26), 4),
                             stringsAsFactors = FALSE)
    )
    expect_equal(ndoc(longcorp), 104)
    expect_is(summary(longcorp, n = 101), "data.frame")
    expect_equal(nrow(summary(longcorp, n = 101)), 101)
})

test_that("print.summary.corpus work", {
    summ1 <- summary(data_corpus_inaugural + data_corpus_inaugural)
    expect_output(
        print(summ1),
        "Corpus consisting of 116 documents, showing 100 documents:"
    )
    expect_output(
        print(summ1[1:5, ]),
        "\\s+Text Types Tokens"
    )
    expect_output(
        print(summ1[, c("Types", "Tokens")]),
        "^\\s+Types Tokens\\n1\\s+625\\s+1538"
    )
})

test_that("summary_character works as expected",  {
    txt <- c("Testing this text. Second sentence.", "And this one.")
    expect_identical(
        quanteda:::summary_character(txt),
        data.frame(Text = c("text1", "text2"),
                   Types = c(6L, 4L),
                   Tokens = c(7L, 4L),
                   Sentences = c(2L, 1L))
    )
})

test_that("summary.character works with character objects (#1285)",  {
    txt <- c("Testing this text. Second sentence.", "And this one.")
    expect_equal(
        as.character(summary(txt)),
        c("2", "character", "character")
    )
})

test_that("summary.character works with data.frames containing character (#1285)",  {
    skip_on_appveyor()
    skip_on_travis()
    skip_on_cran()
    skip_on_os("linux")
    txt <- c("Testing this text. Second sentence.", "And this one.")
    df <- data.frame(txt, other = 1:2, stringsAsFactors = FALSE)
    expect_equal(
        stringi::stri_trim_right(as.character(summary(df))[1:3]),
        c("Length:2", "Class :character", "Mode  :character")
    )
})
