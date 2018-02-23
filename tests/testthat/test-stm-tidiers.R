context("stm tidiers")

suppressPackageStartupMessages(library(dplyr))

if(require("stm", quietly = TRUE)) {

  dat <- data_frame(document = c("row1", "row1", "row2", "row2", "row2"),
                    term = c("col1", "col2", "col1", "col3", "col4"),
                    n = 1:5)
  m <- cast_sparse(dat, document, term)
  stm_model <- stm(m, seed = 1234, K = 3, verbose = FALSE)

  test_that("can tidy beta matrix", {
    td <- tidy(stm_model, matrix = "beta")
    expect_is(td, "tbl_df")

    expect_equal(colnames(td), c("topic", "term", "beta"))

    expect_is(td$term, "character")
    expect_is(td$beta, "numeric")
    expect_equal(unique(td$topic), 1:3)

    expect_gt(nrow(td), 10)

    expect_true(all(c("col1", "col2", "col3") %in% td$term))

    # all betas sum to 1
    summ <- td %>%
      count(topic, wt = beta)
    expect_lt(max(abs(summ$n - 1)), .000001)

    td_log <- tidy(stm_model, matrix = "beta", log = TRUE)
    expect_true(all(td_log$beta <= 0))
  })

  test_that("can tidy gamma matrix", {
    td <- tidy(stm_model, matrix = "gamma")
    expect_is(td, "tbl_df")

    expect_equal(colnames(td), c("document", "topic", "gamma"))

    expect_is(td$document, "integer")
    expect_is(td$gamma, "numeric")

    expect_equal(nrow(td), 6)
    expect_equal(unique(td$topic), 1:3)
    expect_equal(unique(td$document), 1:2)

    # all gammas sum to 1
    summ <- td %>%
      count(document, wt = gamma)
    expect_lt(max(abs(summ$n - 1)), 1e-6)

    td_log <- tidy(stm_model, matrix = "gamma", log = TRUE)
    expect_true(all(td_log$gamma <= 0))
  })

  test_that("can augment an stm output", {
    skip_if_not_installed("quanteda")
    au <- augment(stm_model, dat)
    expect_is(au, "tbl_df")
    expect_equal(colnames(au), c(colnames(dat), ".topic"))
    expect_equal(sort(unique(au$.topic)), 1:3)

    # augment output should have same document-term combinations
    s <- arrange(au, document, term)
    s2 <- dat %>%
      arrange(document, term)
    expect_equal(s$term, s2$term)
    expect_equal(s$document, s2$document)

    # can include extra columns
    inaug_tidied2 <- dat %>%
      mutate(starts_c = stringr::str_detect(term, "^c"))
    au2 <- augment(stm_model, data = inaug_tidied2)
    expect_equal(au$document, au2$document)
    expect_equal(au$term, au2$term)
    expect_is(au2$starts_c, "logical")
    expect_equal(stringr::str_detect(au2$term, "^c"), au2$starts_c)
  })

  test_that("can glance an stm output", {
    g <- glance(stm_model)
    expect_is(g, "tbl_df")
    expect_equal(nrow(g), 1)
    expect_equal(g$terms, 4)
  })
}
