#' Bind the term frequency and inverse document frequency of a tidy text
#' dataset to the dataset
#'
#' Calculate and bind the term frequency and inverse document frequency of a
#' tidy text dataset, along with the product, tf-idf to the dataset. Each of
#' these values are added as columns.
#'
#' @param tbl A tidy text dataset with one-row-per-term-per-document
#' @param term_col Column containing terms
#' @param document_col Column containing document IDs
#' @param n_col Column containing document-term counts
#'
#' @details \code{tf_idf} is given bare names, while \code{tf_idf_}
#' is given strings and is therefore suitable for programming with.
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
#'   count(book, word, sort = TRUE) %>%
#'   ungroup()
#'
#' book_words
#'
#' # find the words most distinctive to each document
#' book_words %>%
#'   bind_tf_idf(word, book, n) %>%
#'   arrange(desc(tf_idf))
#'
#' @export
bind_tf_idf <- function(tbl, term_col, document_col, n_col) {
  bind_tf_idf_(tbl,
                    col_name(substitute(term_col)),
                    col_name(substitute(document_col)),
                    col_name(substitute(n_col)))
}


#' @rdname bind_tf_idf
#' @export
bind_tf_idf_ <- function(tbl, term_col, document_col, n_col) {
  terms <- as.character(tbl[[term_col]])
  documents <- as.character(tbl[[document_col]])
  n <- tbl[[n_col]]
  doc_totals <- tapply(n, documents, sum)
  idf <- log(length(doc_totals) / table(terms))

  tbl$tf <- tbl[[n_col]] / as.numeric(doc_totals[documents])
  tbl$idf <- as.numeric(idf[terms])
  tbl$tf_idf <- tbl$tf * tbl$idf

  tbl
}
