#' Tidy a sparseMatrix object from the Matrix package
#'
#' Tidy a sparseMatrix object from the Matrix package into
#' a three-column data frame, row, column, and value (with
#' zeros missing). If there are row names or column names,
#' use those, otherwise use indices
#'
#' @importFrom broom tidy
#'
#' @param x A Matrix object
#' @param ... Extra arguments, not used
#'
#' @name sparse_tidiers
#'
#' @export
tidy.dgTMatrix <- function(x, ...) {
  tidy_triplet(x, Matrix::summary(x))
}


#' @rdname sparse_tidiers
#' @export
tidy.dgCMatrix <- function(x, ...) {
  tidy(as(x, "dgTMatrix"))
}


#' @rdname sparse_tidiers
#' @export
tidy.sparseMatrix <- function(x, ...) {
  tidy(as(x, "dgTMatrix"))
}


tidy.simple_triplet_matrix <- function(x, ...) {
  triplets <- unclass(x)[c("i", "j", "v")]
  names(triplets) <- c("i", "j", "x")
  tidy_triplet(x, triplets)
}


#' @rdname sparse_tidiers
#' @export
tidy.DocumentTermMatrix <- function(x, ...) {
  ret <- tidy.simple_triplet_matrix(x)
  colnames(ret) <- c("document", "term", "count")
  ret
}


#' @rdname sparse_tidiers
#' @export
tidy.TermDocumentMatrix <- function(x, ...) {
  ret <- tidy.simple_triplet_matrix(x)
  colnames(ret) <- c("term", "document", "count")
  ret
}


#' Utility function to tidy a simple triplet matrix
#'
#' @param x Object with rownames and colnames
#' @param triplets A data frame or list of i, j, x
tidy_triplet <- function(x, triplets) {
  row <- triplets$i
  if (!is.null(rownames(x))) {
    row <- rownames(x)[row]
  }
  col <- triplets$j
  if (!is.null(colnames(x))) {
    col <- colnames(x)[col]
  }

  ret <- data_frame(row = row, column = col, value = triplets$x)
  ret
}


#' @export
tidy

