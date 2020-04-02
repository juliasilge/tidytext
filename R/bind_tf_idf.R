#' Bind the term frequency and inverse document frequency of a tidy text
#' dataset to the dataset
#'
#' Calculate and bind the term frequency and inverse document frequency of a
#' tidy text dataset, along with the product, tf-idf, to the dataset. Each of
#' these values are added as columns. This function supports non-standard
#' evaluation through the tidyeval framework.
#'
#' @param tbl A tidy text dataset with one-row-per-term-per-document
#' @param term Column containing terms as string or symbol
#' @param document Column containing document IDs as string or symbol
#' @param n Column containing document-term counts as string or symbol
#'
#' @details The arguments \code{term}, \code{document}, and \code{n}
#' are passed by expression and support \link[rlang]{quasiquotation};
#' you can unquote strings and symbols.
#'
#' If the dataset is grouped, the groups are ignored but are
#' retained.
#'
#' The dataset must have exactly one row per document-term combination
#' for this to work.
#'
#' @examples
#'
#' library(dplyr)
#' library(janeaustenr)
#'
#' book_words <- austen_books() %>%
#'   unnest_tokens(word, text) %>%
#'   count(book, word, sort = TRUE)
#'
#' book_words
#'
#' # find the words most distinctive to each document
#' book_words %>%
#'   bind_tf_idf(word, book, n) %>%
#'   arrange(desc(tf_idf))
#'
#' @export

bind_tf_idf <- function(tbl, term, document, n) {
  term <- quo_name(enquo(term))
  document <- quo_name(enquo(document))
  n_col <- quo_name(enquo(n))

  terms <- as.character(tbl[[term]])
  documents <- as.character(tbl[[document]])
  n <- tbl[[n_col]]
  doc_totals <- tapply(n, documents, sum)
  idf <- log(length(doc_totals) / table(terms))

  tbl$tf <- n / as.numeric(doc_totals[documents])
  tbl$idf <- as.numeric(idf[terms])
  tbl$tf_idf <- tbl$tf * tbl$idf

  if(any(tbl$idf < 0, na.rm = TRUE)) {
    rlang::warn(paste("A value for tf_idf is negative:\n",
                      "Input should have exactly one row per document-term combination."))
  }
  tbl
}

