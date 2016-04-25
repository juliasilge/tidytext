#' Tidy DocumentTermMatrix, TermDocumentMatrix, and related objects
#' from the tm package
#'
#' Tidy a DocumentTermMatrix or TermDocumentMatrix into
#' a three-column data frame: \code{term{}}, and value (with
#' zeros missing), with one-row-per-term-per-document.
#'
#' @importFrom broom tidy
#'
#' @param x A DocumentTermMatrix or TermDocumentMatrix object
#' @param row_names Specify row names
#' @param col_names Specify column names
#' @param ... Extra arguments, not used
#'
#' @name tdm_tidiers
#'
#' @examples
#'
#' if (requireNamespace("topicmodels", quietly = TRUE)) {
#'   data("AssociatedPress", package = "topicmodels")
#'   AssociatedPress
#'
#'   tidy(AssociatedPress)
#' }
#'
#' @export
tidy.DocumentTermMatrix <- function(x, ...) {
  ret <- tidy.simple_triplet_matrix(x, x$dimnames$Docs, x$dimnames$Terms)
  colnames(ret) <- c("document", "term", "count")

  ret
}


#' @rdname tdm_tidiers
#' @export
tidy.TermDocumentMatrix <- function(x, ...) {
  ret <- tidy.simple_triplet_matrix(x, x$dimnames$Terms, x$dimnames$Docs)
  colnames(ret) <- c("term", "document", "count")
  ret
}


#' @rdname tdm_tidiers
#' @export
tidy.dfmSparse <- function(x, ...) {
  triplets <- Matrix::summary(methods::as(x, "dgTMatrix"))
  ret <- tidy_triplet(x, triplets)
  colnames(ret) <- c("document", "term", "count")
  ret
}


#' @rdname tdm_tidiers
#' @export
tidy.simple_triplet_matrix <- function(x,
                                       row_names = NULL,
                                       col_names = NULL, ...) {
  triplets <- unclass(x)[c("i", "j", "v")]
  names(triplets) <- c("i", "j", "x")
  tidy_triplet(x, triplets, row_names, col_names)
}


#' Utility function to tidy a simple triplet matrix
#'
#' @param x Object with rownames and colnames
#' @param triplets A data frame or list of i, j, x
#' @param row_names rownames, if not gotten from rownames(x)
#' @param col_names colnames, if not gotten from colnames(x)
tidy_triplet <- function(x, triplets, row_names = NULL, col_names = NULL) {
  row <- triplets$i
  if (!is.null(row_names)) {
    row <- row_names[row]
  } else if (!is.null(rownames(x))) {
    row <- rownames(x)[row]
  }
  col <- triplets$j
  if (!is.null(col_names)) {
    col <- col_names[col]
  } else if (!is.null(colnames(x))) {
    col <- colnames(x)[col]
  }

  ret <- data_frame(row = row, column = col, value = triplets$x)
  ret
}


#' @export
broom::tidy

