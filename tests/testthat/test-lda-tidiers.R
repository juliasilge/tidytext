context("LDA tidiers")

suppressPackageStartupMessages(library(dplyr))

if (require("topicmodels", quietly = TRUE)) {
  data(AssociatedPress)
  ap <- AssociatedPress[1:100, ]
  lda <- LDA(ap, control = list(alpha = 0.1), k = 4)
  ctm <- LDA(ap, k = 4)

  test_that("can tidy beta matrix", {
    td <- tidy.LDA(lda, matrix = "beta")
    td2 <- tidy.CTM(ctm, matrix = "beta")
    expect_is(td, "tbl_df")
    expect_is(td2, "tbl_df")

    expect_equal(colnames(td), c("topic", "term", "beta"))
    expect_equal(colnames(td2), c("topic", "term", "beta"))

    expect_is(td$term, "character")
    expect_is(td$beta, "numeric")
    expect_equal(unique(td$topic), 1:4)
    expect_is(td2$term, "character")
    expect_is(td2$beta, "numeric")
    expect_equal(unique(td2$topic), 1:4)

    expect_gt(nrow(td), 10000)
    expect_gt(nrow(td2), 10000)

    expect_true(all(c("united", "states", "president") %in% td$term))

    # all betas sum to 1
    summ <- td %>%
      count(topic, wt = beta)
    expect_lt(max(abs(summ$n - 1)), .000001)

    td_log <- tidy(lda, matrix = "beta", log = TRUE)
    expect_true(all(td_log$beta < 0))
    td_log2 <- tidy(ctm, matrix = "beta", log = TRUE)
    expect_true(all(td_log2$beta < 0))
  })

  test_that("can tidy gamma matrix", {
    td <- tidy.LDA(lda, matrix = "gamma")
    expect_is(td, "tbl_df")
    td2 <- tidy.CTM(ctm, matrix = "gamma")
    expect_is(td2, "tbl_df")

    expect_equal(colnames(td), c("document", "topic", "gamma"))
    expect_equal(colnames(td2), c("document", "topic", "gamma"))

    expect_is(td$document, "integer")
    expect_is(td$gamma, "numeric")
    expect_is(td2$document, "integer")
    expect_is(td2$gamma, "numeric")

    expect_equal(nrow(td), 400)
    expect_equal(unique(td$topic), 1:4)
    expect_equal(unique(td$document), 1:100)
    expect_equal(nrow(td2), 400)
    expect_equal(unique(td2$topic), 1:4)
    expect_equal(unique(td2$document), 1:100)

    # all gammas sum to 1
    summ <- td %>%
      count(document, wt = gamma)
    expect_lt(max(abs(summ$n - 1)), 1e-6)

    td_log <- tidy(lda, matrix = "gamma", log = TRUE)
    expect_true(all(td_log$gamma < 0))
  })

  test_that("can augment an LDA output", {
    au <- augment.LDA(lda)
    expect_is(au, "tbl_df")
    au2 <- augment.CTM(ctm)
    expect_is(au2, "tbl_df")
    expect_equal(colnames(au), c("document", "term", ".topic"))
    expect_equal(sort(unique(au$.topic)), 1:4)

    # augment output should have same document-term combinations
    ap_tidied <- tidy(ap)

    s <- arrange(au, document, term)
    s2 <- ap_tidied %>%
      arrange(document, term)
    expect_equal(s$term, s2$term)
    expect_equal(s$document, s2$document)

    # can include extra columns
    ap_tidied2 <- ap_tidied %>%
      mutate(starts_a = stringr::str_detect(term, "^a"))
    au2 <- augment.LDA(lda, data = ap_tidied2)
    expect_equal(au$document, au2$document)
    expect_equal(au$term, au2$term)
    expect_is(au2$starts_a, "logical")
    expect_equal(stringr::str_detect(au2$term, "^a"), au2$starts_a)

    # can give document term matrix
    au3 <- augment.LDA(lda, data = ap)
    expect_equal(au$document, au3$document)
    expect_equal(au$term, au3$term)
    expect_equal(au$.topic, au3$.topic)
  })

  test_that("can glance an LDA output", {
    g <- glance.LDA(lda)
    expect_is(g, "tbl_df")
    expect_equal(nrow(g), 1)
    expect_equal(g$terms, 19253)
    g2 <- glance.CTM(lda)
    expect_is(g2, "tbl_df")
  })
}
