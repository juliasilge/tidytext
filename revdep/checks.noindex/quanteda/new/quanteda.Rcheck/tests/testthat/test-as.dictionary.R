context("test as.dictionary function")

test_that("as.dictionary works for data.frame", {
    df <- data.frame(
        word = letters[1:6],
        sentiment = c("neg", "neg", "neutral", "neutral", "pos", "pos"),
        lexicon = rep("madeup", 6),
        stringsAsFactors = FALSE
    )
    expect_equal(
        dictionary(list(neg = c("a", "b"), 
                        neutral = c("c", "d"), 
                        pos = c("e", "f"))),
        as.dictionary(df)
    )
    df <- data.frame(
        word = letters[1:6],
        sentiment = c("neg", "neg", "neutral", "neutral", "pos", "pos"),
        lexicon = rep("madeup", 6),
        stringsAsFactors = TRUE
    )
    expect_equal(
        dictionary(list(neg = c("a", "b"), 
                        neutral = c("c", "d"), pos = c("e", "f"))),
        as.dictionary(df)
    )
})

test_that("as.dictionary warnings and errors", {
    df <- data.frame(
        word = letters[1:6],
        sentiment2 = c("neg", "neg", "neutral", "neutral", "pos", "pos"),
        lexicon = rep("madeup", 6)
    )
    expect_error(
        as.dictionary(df),
        "data\\.frame must contain word and sentiment columns"
    )

    df <- data.frame(
        word = letters[1:6],
        sentiment = c("neg", "neg", "neutral", "neutral", "pos", "pos"),
        lexicon = c(rep("madeup", 3), rep("other", 3))
    )
    expect_warning(
        as.dictionary(df),
        "you may be mixing different dictionaries"
    )
    
    df <- data.frame(
        word = letters[1:6],
        sentiment = NA,
        lexicon = "madeup"
    )
    expect_error(
        as.dictionary(df),
        "sentiment values are missing"
    )
})


test_that("as.dictionary function works for tidytext sentiment", {
    skip_if_not_installed("tidytext")
    data(sentiments, package = "tidytext")
    expect_true(
        is.dictionary(as.dictionary(subset(sentiments, lexicon == "nrc")))
    )
    expect_true(
        is.dictionary(as.dictionary(subset(sentiments, lexicon == "bing")))
    )
    expect_warning(
        as.dictionary(sentiments),
        "you may be mixing different dictionaries"
    )
})

