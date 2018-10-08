context("test trim functions")

txt <- c("PAGE 1. This is a single sentence.  Short sentence. Three word sentence.",
         "PAGE 2. Very short! Shorter.",
         "Very long sentence, with multiple parts, separated by commas.  PAGE 3.")

test_that("corpus_trim works", {
    mycorp <- corpus(txt, docvars = data.frame(serial = 1:3))
    expect_equal(
        texts(corpus_trim(mycorp, 'sentences', min_ntok = 3)),
        c(text1 = "This is a single sentence.  Three word sentence.",
          text3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    expect_equal(
        texts(corpus_trim(mycorp, 'sentences', exclude_pattern = "^PAGE \\d+")),
        c(text1 = "This is a single sentence.  Short sentence.  Three word sentence.",
          text2 = "Very short!  Shorter.",
          text3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    expect_equal(
        texts(corpus_trim(mycorp, 'documents', min_ntoken = 8)),
        c(text1 = txt[1], text3 = txt[3])
    )
})

test_that("corpus_trim returns empty corpus when appropriate", {
    mycorp <- corpus(txt, docvars = data.frame(serial = 1:3))
    tmp <- corpus_trim(mycorp, 'documents', min_ntoken = 50)
    expect_equal(ndoc(tmp), 0)
    expect_is(tmp, "corpus")
    expect_true(is.corpus(tmp))
})

test_that("char_trim works", {
    expect_equal(
        char_trim(txt, 'sentences', min_ntok = 3),
        c(text1 = "This is a single sentence.  Three word sentence.",
          text3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    expect_equal(
        char_trim(txt, 'sentences', exclude_pattern = "^PAGE \\d+"),
        c(text1 = "This is a single sentence.  Short sentence.  Three word sentence.",
          text2 = "Very short!  Shorter.",
          text3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    expect_equal(
        char_trim(txt, 'documents', min_ntoken = 8),
        c(text1 = txt[1], text3 = txt[3])
    )
})

test_that("char_trim returns empty character when appropriate", {
    tmp <- char_trim(txt, 'documents', min_ntoken = 50)
    expect_equal(length(tmp), 0)
    expect_is(tmp, "character")
    expect_true(is.character(tmp))
})



###### maintain tests for corpus_trimsentences
test_that("corpus_trimsentences works", {
    txt <- c("PAGE 1. This is a single sentence.  Short sentence. Three word sentence.",
             "PAGE 2. Very short! Shorter.",
             "Very long sentence, with multiple parts, separated by commas.  PAGE 3.")
    mycorp <- corpus(txt, docvars = data.frame(serial = 1:3))
    expect_equal(
        texts(corpus_trimsentences(mycorp, min_length = 3)),
        c(text1 = "This is a single sentence.  Three word sentence.",
          text3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    expect_equal(
        texts(corpus_trimsentences(mycorp, exclude_pattern = "^PAGE \\d+")),
        c(text1 = "This is a single sentence.  Short sentence.  Three word sentence.",
          text2 = "Very short!  Shorter.",
          text3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    
})

test_that("char_trimsentences works", {
    txt <- c(d1 = "PAGE 1. This is a single sentence.  Short sentence. Three word sentence.",
             d2 = "PAGE 2. Very short! Shorter.",
             d3 = "Very long sentence, with multiple parts, separated by commas.  PAGE 3.")
    expect_equal(
        char_trimsentences(txt, min_length = 3),
        c(d1 = "This is a single sentence.  Three word sentence.",
          d3 = "Very long sentence, with multiple parts, separated by commas.")
    )
    expect_equal(
        char_trimsentences(txt, exclude_pattern = "^PAGE \\d+"),
        c(d1 = "This is a single sentence.  Short sentence.  Three word sentence.",
          d2 = "Very short!  Shorter.",
          d3 = "Very long sentence, with multiple parts, separated by commas.")
    )
})

