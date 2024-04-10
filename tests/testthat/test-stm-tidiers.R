skip_if_not_installed("stm")
suppressPackageStartupMessages(library(dplyr))
library(stm)

dat <- tibble(
  document = c("row1", "row1", "row2", "row2", "row2"),
  term = c("col1", "col2", "col1", "col3", "col4"),
  n = 1:5
)
m <- cast_sparse(dat, document, term)
stm_model <- stm(m, seed = 1234, K = 3, verbose = FALSE)

temp <- textProcessor(documents = gadarian[1:10,]$open.ended.response,
                      metadata = gadarian[1:10,], verbose = FALSE)
out <- prepDocuments(temp$documents, temp$vocab, temp$meta, verbose = F)
stm_model_cov <- stm(out$documents, out$vocab, K = 3,
                     content = out$meta$treatment,
                     seed = 123, max.em.its = 3, verbose = FALSE)

test_that("can tidy beta matrix", {
  td <- tidy(stm_model, matrix = "beta")
  td_cov <- tidy(stm_model_cov, matrix = "beta")
  expect_s3_class(td, "tbl_df")
  expect_s3_class(td_cov, "tbl_df")

  expect_equal(colnames(td), c("topic", "term", "beta"))
  expect_equal(colnames(td_cov), c("topic", "term", "beta", "y.level"))

  expect_type(td$term, "character")
  expect_type(td$beta, "double")
  expect_type(td_cov$y.level, "character")
  expect_equal(unique(td$topic), 1:3)
  expect_equal(unique(td_cov$y.level), c("0", "1"))

  expect_gt(nrow(td), 10)

  expect_true(all(c("col1", "col2", "col3") %in% td$term))

  # all betas sum to 1
  summ <- td %>%
    count(topic, wt = beta)
  expect_lt(max(abs(summ$n - 1)), .000001)
  summ_cov <- td_cov %>%
    count(topic, y.level, wt = beta)
  expect_lt(max(abs(summ_cov$n - 1)), .000001)

  td_log <- tidy(stm_model, matrix = "beta", log = TRUE)
  expect_true(all(td_log$beta <= 0))
  td_cov_log <- tidy(stm_model_cov, matrix = "beta", log = TRUE)
  expect_true(all(td_cov_log$beta <= 0))
})

test_that("can tidy gamma matrix", {
  td <- tidy(stm_model, matrix = "gamma")
  expect_s3_class(td, "tbl_df")

  expect_equal(colnames(td), c("document", "topic", "gamma"))

  expect_type(td$document, "integer")
  expect_type(td$gamma, "double")

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

test_that("can tidy frex + lift matrix", {
  td <- tidy(stm_model_cov, matrix = "frex")
  expect_s3_class(td, "tbl_df")
  expect_equal(colnames(td), c("topic", "term"))
  expect_type(td$term, "character")
  expect_equal(nrow(td), 60)
  expect_equal(unique(td$topic), 1:3)

  logbeta <- stm_model_cov$beta$logbeta[[1]]
  word_counts <- stm_model_cov$settings$dim$wcounts$x
  vocab <- stm_model_cov$vocab

  td2 <- tidy(stm_model_cov, matrix = "frex", w = 1)
  frex_stm <- stm::calcfrex(logbeta, w = 1, word_counts)
  expect_equal(td2, tidytext:::pivot_stm_longer(frex_stm, vocab))

  td3 <- tidy(stm_model_cov, matrix = "lift")
  expect_equal(colnames(td3), c("topic", "term"))
  lift_stm <- stm::calclift(logbeta, word_counts)
  expect_equal(td3, tidytext:::pivot_stm_longer(lift_stm, vocab))
})


test_that("can augment an stm output", {
  skip_if_not_installed("quanteda")
  au <- augment(stm_model, dat)
  expect_s3_class(au, "tbl_df")
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
  expect_type(au2$starts_c, "logical")
  expect_equal(stringr::str_detect(au2$term, "^c"), au2$starts_c)
})

test_that("can glance an stm output", {
  g <- glance(stm_model)
  expect_s3_class(g, "tbl_df")
  expect_equal(nrow(g), 1)
  expect_equal(g$terms, 4)
})

stm_estimate_one_topic <- estimateEffect(c(1) ~ treatment, gadarianFit, gadarian)

test_that("can tidy estimateEffect object with one topic", {
  td <- tidy(stm_estimate_one_topic)
  expect_s3_class(td, "tbl_df")

  expect_equal(colnames(td), c("topic", "term", "estimate", "std.error", "statistic", "p.value"))

  expect_type(td$topic, "integer")
  expect_type(td$term, "character")
  expect_type(td$estimate, "double")
  expect_type(td$std.error, "double")
  expect_type(td$statistic, "double")
  expect_type(td$p.value, "double")

  expect_equal(unique(td$topic), 1)

  expect_equal(nrow(td), 2)

  expect_true(all(c("(Intercept)", "treatment") %in% td$term))
})

test_that("can glance estimateEffect object with one topic", {
  gla <- glance(stm_estimate_one_topic)
  expect_s3_class(gla, "tbl_df")
  expect_equal(colnames(gla), c("k", "docs", "uncertainty"))
  expect_type(gla$k, "integer")
  expect_type(gla$docs, "integer")
  expect_type(gla$uncertainty, "character")
  expect_equal(nrow(gla), 1)
})


stm_estimate_three_topic_interaction <- estimateEffect(c(1:3) ~ treatment*s(pid_rep), gadarianFit, gadarian)
test_that("can tidy estimateEffect object with three topics and an interaction term", {
  td <- tidy(stm_estimate_three_topic_interaction)
  expect_s3_class(td, "tbl_df")

  expect_equal(colnames(td), c("topic", "term", "estimate", "std.error", "statistic", "p.value"))

  expect_type(td$topic, "integer")
  expect_type(td$term, "character")
  expect_type(td$estimate, "double")
  expect_type(td$std.error, "double")
  expect_type(td$statistic, "double")
  expect_type(td$p.value, "double")

  expect_equal(unique(td$topic), c(1:3))

  expect_equal(nrow(td), 42)  # 14 term combinations for 3 topics

  expect_true(all(c("(Intercept)", "treatment", "s(pid_rep)1", "s(pid_rep)2", "s(pid_rep)3", "s(pid_rep)4",
                    "s(pid_rep)5", "s(pid_rep)6", "treatment:s(pid_rep)1", "treatment:s(pid_rep)2",
                    "treatment:s(pid_rep)3", "treatment:s(pid_rep)4", "treatment:s(pid_rep)5", "treatment:s(pid_rep)6")
                  %in% td$term))
})

