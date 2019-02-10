#' Tidiers for LDA and CTM objects from the topicmodels package
#'
#' Tidy the results of a Latent Dirichlet Allocation or Correlated Topic Model.
#'
#' @param x An LDA or CTM (or LDA_VEM/CTA_VEM) object from the topicmodels package
#' @param matrix Whether to tidy the beta (per-term-per-topic, default)
#' or gamma (per-document-per-topic) matrix
#' @param data For \code{augment}, the data given to the LDA or CTM function, either
#' as a DocumentTermMatrix or as a tidied table with "document" and "term"
#' columns
#' @param log Whether beta/gamma should be on a log scale, default FALSE
#' @param ... Extra arguments, not used
#'
#' @return \code{tidy} returns a tidied version of either the beta or gamma matrix.
#'
#' If \code{matrix == "beta"} (default), returns a table with one row per topic and term,
#' with columns
#' \describe{
#'   \item{topic}{Topic, as an integer}
#'   \item{term}{Term}
#'   \item{beta}{Probability of a term generated from a topic according to
#'   the multinomial model}
#' }
#'
#' If \code{matrix == "gamma"}, returns a table with one row per topic and document,
#' with columns
#' \describe{
#'   \item{topic}{Topic, as an integer}
#'   \item{document}{Document name or ID}
#'   \item{gamma}{Probability of topic given document}
#' }
#'
#' @examples
#'
#' if (requireNamespace("topicmodels", quietly = TRUE)) {
#'   set.seed(2016)
#'   library(dplyr)
#'   library(topicmodels)
#'
#'   data("AssociatedPress", package = "topicmodels")
#'   ap <- AssociatedPress[1:100, ]
#'   lda <- LDA(ap, control = list(alpha = 0.1), k = 4)
#'
#'   # get term distribution within each topic
#'   td_lda <- tidy(lda)
#'   td_lda
#'
#'   library(ggplot2)
#'
#'   # visualize the top terms within each topic
#'   td_lda_filtered <- td_lda %>%
#'     filter(beta > .004) %>%
#'     mutate(term = reorder(term, beta))
#'
#'   ggplot(td_lda_filtered, aes(term, beta)) +
#'     geom_bar(stat = "identity") +
#'     facet_wrap(~ topic, scales = "free") +
#'     theme(axis.text.x = element_text(angle = 90, size = 15))
#'
#'   # get classification of each document
#'   td_lda_docs <- tidy(lda, matrix = "gamma")
#'   td_lda_docs
#'
#'   doc_classes <- td_lda_docs %>%
#'     group_by(document) %>%
#'     top_n(1) %>%
#'     ungroup()
#'
#'   doc_classes
#'
#'   # which were we most uncertain about?
#'   doc_classes %>%
#'     arrange(gamma)
#' }
#'
#' @name lda_tidiers
#'
#' @export
tidy.LDA <- function(x, matrix = c("beta", "gamma"), log = FALSE, ...) {
  tidy_topicmodels(x = x, matrix = matrix, log = log, ...)
}

#' @name lda_tidiers
#'
#' @export
tidy.CTM <- function(x, matrix = c("beta", "gamma"), log = FALSE, ...) {
  tidy_topicmodels(x = x, matrix = matrix, log = log, ...)
}

tidy_topicmodels <- function(x, matrix = c("beta", "gamma"), log = FALSE, ...) {
  matrix <- match.arg(matrix)
  if (matrix == "gamma") {
    mat <- x@gamma
  } else {
    mat <- x@beta
  }

  ret <- reshape2::melt(mat) %>%
    tbl_df()

  if (matrix == "beta") {
    ret <- transmute(ret, topic = Var1, term = x@terms[Var2], beta = value)
  } else {
    ret <- transmute(ret, document = Var1, topic = Var2, gamma = value)
    if (!is.null(x@documents)) {
      ret$document <- x@documents[ret$document]
    }
  }

  if (matrix == "beta" && !log) {
    ret[[matrix]] <- exp(ret[[matrix]])
  } else if (matrix == "gamma" && log) {
    ret[[matrix]] <- log(ret[[matrix]])
  }
  ret
}


#' @rdname lda_tidiers
#'
#' @return \code{augment} returns a table with one row per original
#' document-term pair, such as is returned by \link{tdm_tidiers}:
#' \describe{
#'   \item{document}{Name of document (if present), or index}
#'   \item{term}{Term}
#'   \item{.topic}{Topic assignment}
#' }
#'
#' If the \code{data} argument is provided, any columns in the original
#' data are included, combined based on the \code{document} and \code{term}
#' columns.
#'
#' @importFrom generics augment
#'
#' @export
augment.LDA <- function(x, data, ...) {
  augment_topicmodels(x, data, ...)
}

#' @name lda_tidiers
#'
#' @export
augment.CTM <- function(x, data, ...) {
  augment_topicmodels(x, data, ...)
}

augment_topicmodels <- function(x, data, ...) {
  word_assignments <- x@wordassignments
  rownames(word_assignments) <- x@documents
  colnames(word_assignments) <- x@terms
  ret <- tidy.simple_triplet_matrix(word_assignments)
  colnames(ret) <- c("document", "term", ".topic")

  if (!missing(data)) {
    if (inherits(data, "simple_triplet_matrix")) {
      data <- tidy(data)
    } else if (!inherits(data, "data.frame") &&
               !(all(c("document", "term") %in% colnames(data)))) {
      stop(
        "data argument must either be a simple_triplet_matrix (such as ",
        "a DocumentTermMatrix) or a table with document and term columns"
      )
    }
    ret <- left_join(data, ret, by = c("document", "term"))
  }

  ret
}

#' @rdname lda_tidiers
#'
#' @return \code{glance} always returns a one-row table, with columns
#' \describe{
#'   \item{iter}{Number of iterations used}
#'   \item{terms}{Number of terms in the model}
#'   \item{alpha}{If an LDA_VEM, the parameter of the Dirichlet distribution
#'   for topics over documents}
#' }
#'
#' @export
glance.LDA <- function(x, ...) {
  ret <- tibble(iter = x@iter, terms = x@n)

  if (!is.null(x@alpha)) {
    ret$alpha <- x@alpha
  }
  ret
}

#' @name lda_tidiers
#'
#' @export
glance.CTM <- function(x, ...) {
  tibble(iter = x@iter, terms = x@n)

}

#' @export
generics::augment
