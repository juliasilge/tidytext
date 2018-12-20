context("Lookup keyword")
library(LexisNexisTools)


LNToutput <- lnt_read(lnt_sample(verbose = FALSE), verbose = FALSE)

test_that("Lookup stat. computing in sample", {
  expect_equal(lnt_lookup(LNToutput, "statistical computing", verbose = FALSE),
               list(`1` = NULL,
                    `2` = NULL,
                    `3` = NULL,
                    `4` = NULL,
                    `5` = NULL,
                    `6` = NULL,
                    `7` = NULL,
                    `8` = NULL,
                    `9` = c("statistical computing", "statistical computing"),
                    `10` = NULL))
  expect_equal(lnt_lookup(LNToutput, "statis",
                          verbose = TRUE,
                          word_boundaries = FALSE),
               list(`1` = NULL,
                    `2` = NULL,
                    `3` = NULL,
                    `4` = NULL,
                    `5` = NULL,
                    `6` = NULL,
                    `7` = NULL,
                    `8` = NULL,
                    `9` = c("statis", "statis", "statis", "statis", "statis", "statis"),
                    `10` = NULL))
})

teardown(unlink(lnt_sample(verbose = FALSE)))
