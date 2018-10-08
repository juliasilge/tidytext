context("test phrase() function")

test_that("test phrase for character", {
    txt <- c("capital gains tax", "one two", "three")
    expect_equivalent(
        phrase(txt),
        list(c("capital", "gains", "tax"), c("one", "two"), "three")         
    )
    expect_equivalent(
        phrase(letters),
        as.list(letters)         
    )
})

test_that("test phrase for dictionaries", {
    dict <- dictionary(list(country = c("United States"), 
                            institution = c("Congress", "feder* gov*")))
    expect_equivalent(
        phrase(dict),
        list(c("united", "states"), c("congress"), c("feder*", "gov*"))
    )
})

test_that("test phrase for dictionaries", {
    dict <- dictionary(list(country = c("United States"), 
                            institution = c("Congress", "feder* gov*")))
    expect_equivalent(
        phrase(dict),
        list(c("united", "states"), c("congress"), c("feder*", "gov*"))
    )
})

test_that("test phrase for collocations", {
    toks <- tokens(c("United States", "Congress", "federal government"))

    colls <- textstat_collocations(toks, min_count = 1, tolower = FALSE)
    expect_equivalent(
        phrase(colls),
        list(c("United", "States"), c("federal", "government"))
    )
    
    # seqs <- sequences(toks, min_count = 1)
    # expect_equivalent(
    #     phrase(seqs),
    #     list(c("federal", "government"), c("United", "States"))
    # )
})

test_that("test phrase for tokens", {
    toks <- tokens(c("United States", "Congress", "federal government"))
    expect_equivalent(
        phrase(toks), 
        list(c("United", "States"), "Congress", c("federal", "government"))
    )
    
    toks2 <- tokens(c("United States", "Congress", "federal government"), 
                    ngrams = 2, concatenator = " ")
    expect_equivalent(
        phrase(toks2),
        list("United States", character(0), "federal government")
    )
})

test_that("helper functions for phrase() work", {
    p <- phrase(c("capital gains tax", "one two", "three"))
    expect_identical(
        quanteda:::as.list.phrases(p),
        list(c("capital", "gains", "tax"), c("one", "two"), "three")      
    )
    expect_output(
        print(p)
    )
    expect_identical(
        is.phrase(list(c("capital", "gains", "tax"), c("one", "two"), "three")),
        FALSE
    )
    expect_identical(
        is.phrase(p),
        TRUE
    )
})
