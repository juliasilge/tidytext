context("stm tidiers")

suppressPackageStartupMessages(library(dplyr))

if(require("stm", quietly = TRUE) || TRUE) {

  suppressPackageStartupMessages(library(quanteda))
  inaug <- dfm(data_corpus_inaugural[1:20,])
  stm_model <- stm(inaug, seed = 1234, K = 3, verbose = FALSE)

  test_that("can tidy beta matrix", {
    td <- tidy(stm_model, matrix = "beta")
    expect_is(td, "tbl_df")

    expect_equal(colnames(td), c("topic", "term", "beta"))

    expect_is(td$term, "character")
    expect_is(td$beta, "numeric")
    expect_equal(unique(td$topic), 1:3)

    expect_gt(nrow(td), 10000)

    expect_true(all(c("united", "states", "president") %in% td$term))

    # all betas sum to 1
    summ <- td %>%
      count(topic, wt = beta)
    expect_lt(max(abs(summ$n - 1)), .000001)

    td_log <- tidy(stm_model, matrix = "beta", log = TRUE)
    expect_true(all(td_log$beta < 0))
  })

  test_that("can tidy gamma matrix", {
    td <- tidy(stm_model, matrix = "gamma")
    expect_is(td, "tbl_df")

    expect_equal(colnames(td), c("document", "topic", "gamma"))

    expect_is(td$document, "integer")
    expect_is(td$gamma, "numeric")

    expect_equal(nrow(td), 60)
    expect_equal(unique(td$topic), 1:3)
    expect_equal(unique(td$document), 1:20)

    # all gammas sum to 1
    summ <- td %>%
      count(document, wt = gamma)
    expect_lt(max(abs(summ$n - 1)), 1e-6)

    td_log <- tidy(stm_model, matrix = "gamma", log = TRUE)
    expect_true(all(td_log$gamma < 0))
  })

  test_that("can augment an stm output", {
    au <- augment(stm_model, inaug)
    expect_is(au, "tbl_df")
    expect_equal(colnames(au), c("document", "term", "count", ".topic"))
    expect_equal(sort(unique(au$.topic)), 1:3)

    # augment output should have same document-term combinations
    inaug_tidied <- tidy(inaug)

    s <- arrange(au, document, term)
    s2 <- inaug_tidied %>%
      arrange(document, term)
    expect_equal(s$term, s2$term)
    expect_equal(s$document, s2$document)

    # can include extra columns
    inaug_tidied2 <- inaug_tidied %>%
      mutate(starts_a = stringr::str_detect(term, "^a"))
    au2 <- augment(stm_model, data = inaug_tidied2)
    expect_equal(au$document, au2$document)
    expect_equal(au$term, au2$term)
    expect_is(au2$starts_a, "logical")
    expect_equal(stringr::str_detect(au2$term, "^a"), au2$starts_a)
  })

  test_that("can glance an stm output", {
    g <- glance(stm_model)
    expect_is(g, "tbl_df")
    expect_equal(nrow(g), 1)
    expect_equal(g$terms, 5372)
  })
}
