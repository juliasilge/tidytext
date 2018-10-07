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
#                     to = "rDNA", what = "Articles"), "../files/rDNA.RDS")

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
    cptools
  }, readRDS("../files/corpustools.RDS"))
})

# saveRDS(lnt_convert(x = readRDS("../files/LNToutput.RDS"),
#                     to = "corpustools", what = "Articles"), "../files/corpustools.RDS")

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
    conn <- lnt_convert(x = readRDS("../files/LNToutput.RDS"),
                        to = "SQLite", what = "Articles",
                        file = "../files/LNT.sqlite")
    conn@dbname <- basename(conn@dbname)
    RSQLite::dbDisconnect(conn)
    conn
  }, readRDS("../files/SQLite.RDS"))
})

# saveRDS(conn, "../files/SQLite.RDS")

teardown(unlink(c(
  lnt_sample(verbose = FALSE),
  "../files/LNT.sqlite"
)))
