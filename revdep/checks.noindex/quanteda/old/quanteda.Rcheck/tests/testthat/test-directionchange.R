
context("test direction change functions")

txt <- readLines("../data/hebrew.txt", encoding = "utf-8")
txt <- stringi::stri_trim_both(txt)

test_that("char_tortl works.", {
    skip_on_os("windows")
    
    expect_equal(char_tortl(txt[1]), stringi::stri_replace_all_fixed(txt[2], "%", "\u200F"))
    expect_equal(char_tortl(txt[3]), stringi::stri_replace_all_fixed(txt[4], "%", "\u200F"))
    expect_identical(charToRaw(char_tortl(txt[3])),
                     charToRaw(stringi::stri_replace_all_fixed(txt[4], "%", "\u200F")))
})

test_that("tokens_tortl works.", {
    skip_on_os("windows")
    toks <- tokens(txt[1])
    expect_equal(types(tokens_tortl(toks)), types(tokens(char_tortl(txt[1]))))
})
