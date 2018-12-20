#' Tidiers for Latent Dirichlet Allocation models from the mallet package
#'
#' Tidy LDA models fit by the mallet package, which wraps the Mallet topic
#' modeling package in Java. The arguments and return values
#' are similar to \code{\link{lda_tidiers}}.
#'
#' @param x A jobjRef object, of type RTopicModel, such as created
#' by \code{\link[mallet]{MalletLDA}}.
#' @param matrix Whether to tidy the beta (per-term-per-topic, default)
#' or gamma (per-document-per-topic) matrix.
#' @param data For \code{augment}, the data given to the LDA function, either
#' as a DocumentTermMatrix or as a tidied table with "document" and "term"
#' columns.
#' @param log Whether beta/gamma should be on a log scale, default FALSE
#' @param normalized If true (default), normalize so that each
#' document or word sums to one across the topics. If false, values will
#' be integers representing the actual number of word-topic or document-topic
#' assignments.
#' @param smoothed If true (default), add the smoothing parameter to each
#' to avoid any values being zero. This smoothing parameter is initialized
#' as \code{alpha.sum} in \code{\link[mallet]{MalletLDA}}.
#' @param ... Extra arguments, not used
#'
#' @details Note that the LDA models from \code{\link[mallet]{MalletLDA}}
#' are technically a special case of S4 objects with class \code{jobjRef}.
#' These are thus implemented as \code{jobjRef} tidiers, with a check for
#' whether the \code{toString} output is as expected.
#'
#' @seealso \code{\link{lda_tidiers}}, \code{\link[mallet]{mallet.doc.topics}},
#' \code{\link[mallet]{mallet.topic.words}}
#'
#' @name mallet_tidiers
#'
#' @examples
#'
#' \dontrun{
#' library(mallet)
#' library(dplyr)
#'
#' data("AssociatedPress", package = "topicmodels")
#' td <- tidy(AssociatedPress)
#'
#' # mallet needs a file with stop words
#' tmp <- tempfile()
#' writeLines(stop_words$word, tmp)
#'
#' # two vectors: one with document IDs, one with text
#' docs <- td %>%
#'   group_by(document = as.character(document)) %>%
#'   summarize(text = paste(rep(term, count), collapse = " "))
#'
#' docs <- mallet.import(docs$document, docs$text, tmp)
#'
#' # create and run a topic model
#' topic_model <- MalletLDA(num.topics = 4)
#' topic_model$loadDocuments(docs)
#' topic_model$train(20)
#'
#' # tidy the word-topic combinations
#' td_beta <- tidy(topic_model)
#' td_beta
#'
#' # Examine the four topics
#' td_beta %>%
#'   group_by(topic) %>%
#'   top_n(8, beta) %>%
#'   ungroup() %>%
#'   mutate(term = reorder(term, beta)) %>%
#'   ggplot(aes(term, beta)) +
#'   geom_col() +
#'   facet_wrap(~ topic, scales = "free") +
#'   coord_flip()
#'
#' # find the assignments of each word in each document
#' assignments <- augment(topic_model, td)
#' assignments
#' }
#'
#' @export
tidy.jobjRef <- function(x, matrix = c("beta", "gamma"), log = FALSE,
                         normalized = TRUE, smoothed = TRUE, ...) {
  s <- x$toString()
  if (!stringr::str_detect(s, "TopicModel")) {
    stop("Don't know how to tidy jobjRef ", s)
  }

  matrix <- match.arg(matrix)

  if (matrix == "beta") {
    func <- mallet::mallet.topic.words
  } else {
    func <- mallet::mallet.doc.topics
  }
  m <- func(x, normalized = normalized, smoothed = smoothed)
  ret <- dplyr::tbl_df(reshape2::melt(m))

  if (matrix == "beta") {
    # per term per topic
    colnames(ret) <- c("topic", "term", "beta")
    ret$term <- x$getVocabulary()[ret$term]
  } else {
    # per document per topic
    colnames(ret) <- c("document", "topic", "gamma")
    ret$document <- x$getDocumentNames()[ret$document]
  }

  if (log) {
    ret[[matrix]] <- log(ret[[matrix]])
  }

  ret
}

#' @rdname mallet_tidiers
#'
#' @return \code{augment} must be provided a data argument containing
#' one row per original document-term pair, such as is returned by
#' \link{tdm_tidiers}, containing columns \code{document} and \code{term}.
#' It returns that same data with an additional column
#' \code{.topic} with the topic assignment for that document-term combination.
#'
#' @importFrom generics augment
#'
#' @export
augment.jobjRef <- function(x, data, ...) {
  s <- x$toString()
  if (!stringr::str_detect(s, "TopicModel")) {
    stop("Don't know how to augment jobjRef ", s)
  }

  if (missing(data)) {
    stop("data argument must be provided in order to augment a mallet model")
  }

  beta <- t(mallet::mallet.topic.words(x, normalized = TRUE, smoothed = TRUE))
  gamma <- mallet::mallet.doc.topics(x, normalized = TRUE, smoothed = TRUE)

  term_indices <- match(data$term, x$getVocabulary())
  doc_indices <- match(data$document, x$getDocumentNames())

  products <- beta[term_indices, ] * gamma[doc_indices, ]
  keep <- !is.na(term_indices) & !is.na(doc_indices)

  data$.topic <- NA
  data$.topic[keep] <- apply(products[keep, ], 1, which.max)
  data
}
