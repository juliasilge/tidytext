context("LNToutput methods")
library(LexisNexisTools)

lnt_sample(verbose = FALSE)

test_that("Rename Sample", {
  expect_equal({
    file <- lnt_rename(getwd(), simulate = TRUE,
                       verbose = FALSE)
    basename(file$name_new)
  }, "SampleFile_20091201-20100511_1-10.txt")
  expect_equal({
    file <- lnt_rename(getwd(), simulate = FALSE)
    file$name_new
    file.exists(file$name_new)
  }, TRUE)
  expect_message({
    files <- list.files()
    x <- lnt_rename(files, simulate = TRUE, verbose = FALSE)
  }, "Not all provided files were TXT files. Other formats are ignored.")
})

teardown(unlink(c("sample.TXT", 
                  "SampleFile_20091201-20100511_1-10.txt")))


