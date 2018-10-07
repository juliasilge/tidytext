context("Create sample")
library(LexisNexisTools)

test_that("sample exists", {
  expect_equal(basename(lnt_sample(verbose = FALSE)), "sample.TXT")
  expect_equal(file.exists(lnt_sample(verbose = FALSE)), TRUE)
  expect_warning(lnt_sample(verbose = TRUE),
  "Sample file exists in wd. Use overwrite = TRUE to create fresh sample file.")
})

teardown(unlink(lnt_sample(verbose = FALSE)))
