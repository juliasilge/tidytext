#' Tidiers for Structural Topic Models from the stm package
#'
#' Tidy topic models fit by the stm package. The arguments and return values
#' are similar to [lda_tidiers()].
#'
#' @param x An STM fitted model object from either [stm::stm()] or
#' [stm::estimateEffect()]
#' @param matrix Which matrix to tidy:
#'  - the beta matrix (per-term-per-topic, default)
#'  - the gamma/theta matrix (per-document-per-topic); the stm package calls
#'  this the theta matrix, but other topic modeling packages call this gamma
#'  - the FREX matrix, for words with high frequency and exclusivity
#'  - the lift matrix, for words with high lift
#' @param data For `augment`, the data given to the stm function, either
#' as a `dfm` from quanteda or as a tidied table with "document" and
#' "term" columns
#' @param log Whether beta/gamma/theta should be on a log scale, default FALSE
#' @param document_names Optional vector of document names for use with
#' per-document-per-topic tidying
#' @param ... Extra arguments for tidying, such as `w` as used in
#' [stm::calcfrex()]
#'
#' @seealso [lda_tidiers()], [stm::calcfrex()], [stm::calclift()]
#' @return `tidy` returns a tidied version of either the beta, gamma, FREX, or
#' lift matrix if called on an object from [stm::stm()], or a tidied version of
#' the estimated regressions if called on an object from [stm::estimateEffect()].
#'
#' @examplesIf interactive() || identical(Sys.getenv("IN_PKGDOWN"), "true")
#' library(dplyr)
#' library(ggplot2)
#' library(stm)
#' library(janeaustenr)
#'
#' austen_sparse <- austen_books() %>%
#'     unnest_tokens(word, text) %>%
#'     anti_join(stop_words) %>%
#'     count(book, word) %>%
#'     cast_sparse(book, word, n)
#' topic_model <- stm(austen_sparse, K = 12, verbose = FALSE)
#'
#' # tidy the word-topic combinations
#' td_beta <- tidy(topic_model)
#' td_beta
#'
#' # Examine the topics
#' td_beta %>%
#'     group_by(topic) %>%
#'     slice_max(beta, n = 10) %>%
#'     ungroup() %>%
#'     ggplot(aes(beta, term)) +
#'     geom_col() +
#'     facet_wrap(~ topic, scales = "free")
#'
#' # high FREX words per topic
#' tidy(topic_model, matrix = "frex")
#'
#' # high lift words per topic
#' tidy(topic_model, matrix = "lift")
#'
#' # tidy the document-topic combinations, with optional document names
#' td_gamma <- tidy(topic_model, matrix = "gamma",
#'                  document_names = rownames(austen_sparse))
#' td_gamma
#'
#' # using stm's gardarianFit, we can tidy the result of a model
#' # estimated with covariates
#' effects <- estimateEffect(1:3 ~ treatment, gadarianFit, gadarian)
#' glance(effects)
#' td_estimate <- tidy(effects)
#' td_estimate
#'
#' @name stm_tidiers
#'
#' @export
tidy.STM <- function(x,
                     matrix = c("beta", "gamma", "theta", "frex", "lift"),
                     log = FALSE,
                     document_names = NULL, ...) {
  matrix <- rlang::arg_match(matrix)
  switch(matrix,
         "beta" = tidy_stm_beta(x, log),
         "frex" = tidy_stm_frex(x, ...),
         "lift" = tidy_stm_lift(x),
         tidy_stm_gamma(x, log, document_names)
  )
}

tidy_stm_beta <- function(x, log) {
  logbeta <- x$beta$logbeta
  ret <- reshape2::melt(logbeta) %>%
    tibble::as_tibble()
  ret <- transmute(ret, topic = Var1, term = x$vocab[Var2], beta = value,
                   y.level = x$settings$covariates$yvarlevels[as.integer(L1)])
  if (!log) {
    ret$beta <- exp(ret$beta)
  }
  ret
}

tidy_stm_gamma <- function(x, log, document_names) {
  mat <- x$theta
  ret <- reshape2::melt(mat) %>%
    tibble::as_tibble()
  ret <- transmute(ret, document = Var1, topic = Var2, gamma = value)
  if (!is.null(document_names)) {
    ret$document <- document_names[ret$document]
  }
  if (log) {
    ret$gamma <- log(ret$gamma)
  }
  ret
}

tidy_stm_frex <- function(x, ...) {
  logbeta <- x$beta$logbeta[[1]]
  word_counts <- x$settings$dim$wcounts$x
  vocab <- x$vocab
  frex <- stm::calcfrex(logbeta, ..., word_counts)
  pivot_stm_longer(frex, vocab)
}

tidy_stm_lift <- function(x) {
  logbeta <- x$beta$logbeta[[1]]
  word_counts <- x$settings$dim$wcounts$x
  vocab <- x$vocab
  lift <- stm::calclift(logbeta, word_counts)
  pivot_stm_longer(lift, vocab)
}

pivot_stm_longer <- function(x, vocab) {
  rlang::check_installed("tidyr")
  seq_ncol <- seq_len(ncol(x))
  tibble::as_tibble(x, .name_repair = ~ paste0("___", seq_ncol)) %>%
    tidyr::pivot_longer(
      everything(),
      names_to = "topic",
      values_to = "term"
    ) %>%
    transmute(topic = as.integer(stringr::str_remove_all(topic, "___")),
              term = vocab[term]) %>%
    arrange(topic)

}

#' @rdname stm_tidiers
#'
#' @export
tidy.estimateEffect <- function(x, ...) {
  s <- summary(x)
  topics <- s$topics
  names(s$tables) <- s$topics
  ret <- purrr::map_dfr(s$tables, dplyr::as_tibble,
                        rownames = "term", .id = "topic")
  ret$topic <- as.integer(ret$topic)
  colnames(ret) <- c("topic", "term", "estimate", "std.error",
                     "statistic", "p.value")
  ret
}

#' @rdname stm_tidiers
#' @return `glance` returns a tibble with exactly one row of model summaries.
#' @export
glance.estimateEffect <- function(x, ...) {
  ret <- tibble(k = length(x[['topics']]),
                docs = nrow(x[['modelframe']]),
                uncertainty = x[['uncertainty']])
  ret
}

#' @rdname stm_tidiers
#'
#' @return `augment` must be provided a data argument, either a
#' `dfm` from quanteda or a table containing one row per original
#' document-term pair, such as is returned by [tdm_tidiers], containing
#' columns `document` and `term`. It returns that same data with an additional
#' column `.topic` with the topic assignment for that document-term combination.
#'
#' @importFrom generics augment
#'
#' @export
augment.STM <- function(x, data, ...) {
  if (missing(data)) {
    stop("data argument must be provided in order to augment a stm model")
  }

  if (inherits(data, "data.frame") &&
      (all(c("document", "term") %in% colnames(data)))) {
    data$value <- 1
    mat <- cast_dfm(data, document, term, value)
    data$value <- NULL
  } else if (inherits(data, "dfm")) {
    mat <- data
    data <- tidy(mat)
  } else {
    stop(
      "data argument must either be a dfm ",
      "(from quanteda) or a table with document and term columns"
    )
  }

  beta <- t(as.matrix(x$beta$logbeta[[1]]))
  theta <- x$theta

  term_indices <- match(data$term, x$vocab)
  doc_indices <- match(data$document, rownames(mat))

  products <- exp(beta[term_indices, ]) * theta[doc_indices, ]
  keep <- !is.na(term_indices) & !is.na(doc_indices)

  data$.topic <- NA
  data$.topic[keep] <- apply(products[keep, ], 1, which.max)
  data
}

#' @rdname stm_tidiers
#' @export

glance.STM <- function(x, ...) {
  ret <- tibble(
    k = as.integer(x$settings$dim$K),
    docs = x$settings$dim$N,
    terms = x$settings$dim$V,
    iter = length(x$convergence$bound),
    alpha = x$settings$init$alpha
  )

  ret
}

#' @export
generics::augment
