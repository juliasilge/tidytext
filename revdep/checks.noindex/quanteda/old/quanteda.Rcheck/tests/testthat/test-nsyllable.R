context("test nsyllable")

test_that("nsyllable works as expected", {
    txt <- c(one = "super freakily yes",
             two = "merrily all go aerodynamic")
    toks <- tokens(txt)
    expect_identical(
        nsyllable(toks), 
        list(one = c(2L, 3L, 1L), two = c(3L, 1L, 1L, 5L))
    )
})

test_that("nsyllable works as expected with padding = TRUE", {
    txt <- c(one = "super freakily yes",
             two = "merrily, all go aerodynamic")
    toks <- tokens_remove(tokens(txt), c("yes", "merrily"), padding = TRUE)
    expect_identical(
        nsyllable(toks),
        list(one = c(2L, 3L, NA), two = c(NA, NA, 1L, 1L, 5L))
    )
})

test_that("nsyllable works for unknown words", {
    expect_identical(
        nsyllable(c("notword", "NOTWORD")),
        c(2L, 2L)
    )
})

test_that("nsyllable works for different use.names arguments", {
    expect_identical(
        nsyllable(c("testing", "Reagan", "WHOA"), use.names = TRUE),
        c(testing = 2L, Reagan = 2L, WHOA = 1L)
    )
    expect_identical(
        nsyllable(c("testing", "Reagan", "WHOA"), use.names = FALSE),
        c(2L, 2L, 1L)
    )
})

test_that("nsyllable works for words that include punctuation", {
    expect_identical(
        nsyllable(c("#rstats", "@justinbieber")),
        c(1L, 4L)
    )
    expect_identical(
        nsyllable(c("#rstats", "@justinbieber"), use.names = TRUE),
        c("#rstats" = 1L, "@justinbieber" = 4L)
    )
    expect_identical(
        nsyllable(c("!!!", "\U0001F600", "Hooray!!\U0001F600")),
        c(NA, NA, 2L)
    )
})
