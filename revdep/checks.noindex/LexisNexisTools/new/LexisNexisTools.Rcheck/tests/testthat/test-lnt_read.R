context("Read sample file")
library(LexisNexisTools)

files <- lnt_sample(verbose = TRUE)
file.copy(files, paste0(files, "2.TXT"))
files <- c(files, paste0(files, "2.TXT"))

test_that("Read in sample file(2)", {
  expect_equal({
    test <- lnt_read(files[1], verbose = TRUE)
    test@meta$Source_File <- "sample.TXT"
    attributes(test)$created$time <- "2018-07-29 08:29:21 BST"
    attributes(test)$created$Version <- "0.1.56.9000"
    test
  }, readRDS("../files/LNToutput.RDS"))
  expect_equal({
    test <- lnt_read(files, verbose = TRUE)
    test@meta$Source_File <- "sample.TXT"
    attributes(test)$created$time <- "2018-07-29 08:29:21 BST"
    attributes(test)$created$Version <- "0.1.56.9000"
    test <- test[1:10]
    test
  }, readRDS("../files/LNToutput.RDS"))
  expect_equal({
    test <- lnt_read(files, verbose = TRUE, extract_paragraphs = FALSE)
    test@meta$Source_File <- "sample.TXT"
    attributes(test)$created$time <- "2018-07-29 08:29:21 BST"
    attributes(test)$created$Version <- "0.1.56.9000"
    test
  }, readRDS("../files/LNToutput2.RDS"))
})

teardown(unlink(files))
