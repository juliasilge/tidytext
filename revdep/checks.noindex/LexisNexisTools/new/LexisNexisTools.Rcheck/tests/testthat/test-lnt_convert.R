context("LNToutput Conversion")
library(LexisNexisTools)


# LNToutput <- lnt_read(lnt_sample(verbose = FALSE), verbose = FALSE)


test_that("Convert LNToutput to rDNA", {
  expect_equal({
    lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                to = "rDNA", what = "Articles", collapse = TRUE)
  }, readRDS("../files/rDNA.RDS"))
})

# saveRDS(lnt_convert(x = readRDS("../files/LNToutput.RDS"),
#                     to = "rDNA", what = "Articles", collapse = TRUE), "../files/rDNA.RDS")

test_that("Convert LNToutput to quanteda", {
  expect_equal({
    corpus <- lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                          to = "quanteda", what = "Articles", collapse = FALSE)
    corpus$metadata$created <- "Wed Jul 25 19:33:20 2018"
    corpus$metadata$source <-
      "/home/johannes/Documents/Github/LexisNexisTools/tests/testthat/* on x86_64 by johannes"
    corpus
  }, readRDS("../files/quanteda.RDS"))
})

# corpus <- lnt_convert(x = readRDS("../files/LNToutput.RDS"),
#                       to = "quanteda", what = "Articles")
# corpus$metadata$created <- "Wed Jul 25 19:33:20 2018"
# corpus
# saveRDS(corpus, "../files/quanteda.RDS")

test_that("Convert LNToutput to corpustools", {
  expect_equal({
    cptools <- lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                           to = "corpustools", what = "Articles")
    out <- list()
    out[[1]] <- class(cptools)
    out[[2]] <- cptools$get()
    out[[3]] <- cptools$get_meta()
  }, readRDS("../files/corpustools.RDS"))
})

# saveRDS({
#   cptools <- lnt_convert(x = readRDS("../files/LNToutput.RDS"),
#                          to = "corpustools", what = "Articles")
#   out <- list()
#   out[[1]] <- class(cptools)
#   out[[2]] <- cptools$get()
#   out[[3]] <- cptools$get_meta()
# }, "../files/corpustools.RDS")

test_that("Convert LNToutput to tidytext", {
  expect_equal({
    lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                           to = "tidytext", what = "Articles")
  }, readRDS("../files/tidytext.RDS"))
})

# saveRDS(lnt_convert(x = readRDS("../files/LNToutput.RDS"),
#                     to = "tidytext", what = "Articles"), "../files/tidytext.RDS")

test_that("Convert LNToutput to tm", {
  expect_equal({
    lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                to = "tm", what = "Articles")
  }, readRDS("../files/tm.RDS"))
})

# saveRDS(lnt_convert(x = readRDS("../files/LNToutput.RDS"),
#                     to = "tm", what = "Articles"), "../files/tm.RDS")

test_that("Convert LNToutput to SQLite", {
  expect_equal({
    unlink("../files/LNT.sqlite")
    conn <- lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                        to = "SQLite", what = "Articles",
                        file = "../files/LNT.sqlite")
    conn@dbname <- basename(conn@dbname)
    conn
  }, readRDS("../files/SQLite.RDS"))
})

test_that("Test error messages", {
  expect_error ({
    lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                to = "rDNA", what = "Article")
  },"Choose either \"Articles\" or \"Paragraphs\" as what argument.", fixed = TRUE)
  expect_error ({
    lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                to = "quanteda", what = "Paragraph")
  },"Choose either \"Articles\" or \"Paragraphs\" as what argument.", fixed = TRUE)
})

# saveRDS(conn, "../files/SQLite.RDS")

teardown(unlink("../files/LNT.sqlite"))
