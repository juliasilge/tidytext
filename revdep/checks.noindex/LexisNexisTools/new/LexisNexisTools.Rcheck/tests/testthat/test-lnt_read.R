context("Read sample file")

files <- system.file("extdata", "sample.TXT", package = "LexisNexisTools")
file.copy(files, paste0(basename(files), "2.TXT"))
files <- c(files, paste0(basename(files), "2.TXT"))

test_that("Read in sample file(2)", {
  expect_equal({
    test <- lnt_read(files[1], verbose = TRUE)
    test@meta$Source_File <- basename(test@meta$Source_File)
    attributes(test)$created$time <- "2018-12-15 01:00:38 GMT"
    attributes(test)$created$Version <- "0.2.1.9000"
    test
  }, readRDS("../files/LNToutput.RDS"))
  expect_equal({
    test <- lnt_read(files, verbose = TRUE)
    test@meta$Source_File <- basename(test@meta$Source_File)
    attributes(test)$created$time <- "2018-12-15 01:00:38 GMT"
    attributes(test)$created$Version <- "0.2.1.9000"
    test <- test[1:10]
    test
  }, readRDS("../files/LNToutput.RDS"))
  expect_equal({
    test <- lnt_read(files, verbose = TRUE, extract_paragraphs = FALSE)
    test@meta$Source_File <- basename(test@meta$Source_File)
    attributes(test)$created$time <- "2018-12-15 01:00:38 GMT"
    attributes(test)$created$Version <- "0.2.1.9000"
    test
  }, readRDS("../files/LNToutput2.RDS"))
})

teardown(unlink(files[2]))
