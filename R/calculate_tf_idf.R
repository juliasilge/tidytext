#' Calculate the term-frequency and inverse document frequency
#' of a tidy text dataset
#'
#' Calculate the term frequency and inverse document frequency of a
#' tidy text dataset, along with the product, tf-idf. Each of these
#' values are added as columns.
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
#' Note that the dataset does not necessarily need exactly one row per
#' document-term combination; the per-document term frequency will sum
#' \code{n_col} across rows if necessary.
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
#'   calculate_tf_idf(word, book, n) %>%
#'   arrange(desc(tf_idf))
#'
#' @export
calculate_tf_idf <- function(tbl, term_col, document_col, n_col) {

  ############# beginning of matrix math for new version tf-idf
  dtm <- cast_sparse_(tbl,
                     col_name(substitute(document_col)),
                     col_name(substitute(term_col)),
                     col_name(substitute(n_col)))
  tf <- dtm/Matrix::rowSums(dtm)
  idf <- log(nrow(dtm)/Matrix::colSums(abs(sign(dtm))))
  tfidf <- tf*idf
  ############# end of new version draft

  calculate_tf_idf_(tbl,
                    col_name(substitute(term_col)),
                    col_name(substitute(document_col)),
                    col_name(substitute(n_col)))
}


#' @rdname calculate_tf_idf
#' @export
calculate_tf_idf_ <- function(tbl, term_col, document_col, n_col) {
  g <- groups(tbl)

  total_documents <- n_distinct(tbl[[document_col]])

  by_doc_dots <- list(.document_total = substitute(sum(x), list(x = as.name(n_col))))
  # by_term_dots <- list(.nterm = substitute(sum(x), list(x = as.name(n_col))),
  #                      .ndocs = substitute(n_distinct(x), list(x = as.name(document_col))))
  by_term_dots <- list(.nterm = substitute(x, list(x = as.name(n_col))),
                       .ndocs = substitute(n_distinct(x), list(x = as.name(document_col))))
  ungrouped_dots <- list(tf = substitute(.nterm / .document_total),
                         idf = substitute(log(total_documents / .ndocs)))


  # Julia's new version -- does this work right?

  total_terms <- tbl %>% group_by_(document_col) %>%
    summarize_(.dots = by_doc_dots)
  ret <- left_join(tbl, total_terms) %>%
    mutate_(.dots = by_term_dots) %>%
    ungroup() %>%
    mutate_(.dots = ungrouped_dots) %>%
    mutate(tf_idf = tf * idf) %>%
    select(-.ndocs, -.nterm, -.document_total)


  # Dave's old version -- is this wrong? or right?
  # ret <- tbl %>%
  #   group_by_(document_col) %>%
  #   mutate_(.dots = by_doc_dots) %>%
  #   group_by_(term_col) %>%
  #   mutate_(.dots = by_term_dots) %>%
  #   ungroup() %>%
  #   mutate_(.dots = ungrouped_dots) %>%
  #   mutate(tf_idf = tf * idf) %>%
  #   select(-.ndocs, -.nterm, -.document_total)

  if (!is.null(g)) {
    ret <- group_by_(ret, .dots = g)
  }

  ret
}
