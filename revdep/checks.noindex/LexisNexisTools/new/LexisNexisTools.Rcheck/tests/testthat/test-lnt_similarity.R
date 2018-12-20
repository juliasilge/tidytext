context("Lookup keyword")
library(LexisNexisTools)


LNToutput <- lnt_read(lnt_sample(verbose = FALSE), verbose = FALSE)

test_that("Test similarity", {
  expect_equal(lnt_similarity(LNToutput = LNToutput),
               readRDS("../files/duplicates.df.RDS"))
  expect_equal({
    duplicates.df <- lnt_similarity(texts = LNToutput@articles$Article,
                                    dates = LNToutput@meta$Date,
                                    IDs = LNToutput@articles$ID)
    attributes(duplicates.df)$call <-
      attributes(readRDS("../files/duplicates.df.RDS"))$call
    duplicates.df
  },
  readRDS("../files/duplicates.df.RDS"))
  expect_equal(lnt_similarity(texts = LNToutput@articles$Article,
                              dates = LNToutput@meta$Date)$ID_original,
               c(1, 2, 2, 2, 2, 3, 4, 4, 5))
})


test_that("Test similarity warnings and errors", {
  expect_warning(lnt_similarity(texts = c(LNToutput@articles$Article[1:9], ""),
                                dates = LNToutput@meta$Date),
                 "At least one of the supplied texts had length 0. These articles with the following IDs will be ignored: 10")
  expect_warning(lnt_similarity(texts = LNToutput@articles$Article,
                                dates = c(LNToutput@meta$Date[1:9], NA)),
                 "You supplied NA values to 'dates'. Those will be ignored.")
  expect_error(lnt_similarity(),
               "Supply either 'LNToutput' or 'texts' and 'dates'.")
  expect_error(lnt_similarity(texts = LNToutput@articles$Article,
                              dates = LNToutput@meta$Date[1:8]),
               "'texts', 'dates' and 'IDs' need to have the same length.")
})


teardown(unlink(lnt_sample(verbose = FALSE)))
