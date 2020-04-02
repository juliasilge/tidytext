#' Create a sparse matrix from row names, column names, and values
#' in a table.
#'
#' This function supports non-standard evaluation through the tidyeval framework.
#'
#' @param data A tbl
#' @param row Column name to use as row names in sparse matrix, as string or symbol
#' @param column Column name to use as column names in sparse matrix, as string or symbol
#' @param value Column name to use as sparse matrix values (default 1) as string or symbol
#' @param ... Extra arguments to pass on to \code{\link{sparseMatrix}}
#'
#' @return A sparse Matrix object, with one row for each unique value in
#' the \code{row} column, one column for each unique value in the \code{column}
#' column, and with as many non-zero values as there are rows in \code{data}.
#'
#' @details Note that cast_sparse ignores groups in a grouped tbl_df. The arguments
#' \code{row}, \code{column}, and \code{value} are passed by expression and support
#' \link[rlang]{quasiquotation}; you can unquote strings and symbols.
#'
#' @examples
#'
#' dat <- data.frame(a = c("row1", "row1", "row2", "row2", "row2"),
#'                   b = c("col1", "col2", "col1", "col3", "col4"),
#'                   val = 1:5)
#'
#' cast_sparse(dat, a, b)
#'
#' cast_sparse(dat, a, b, val)
#'
#' @import Matrix
#' @export

cast_sparse <- function(data, row, column, value, ...) {
  row_col <- quo_name(enquo(row))
  column_col <- quo_name(enquo(column))
  value_col <- enquo(value)
  if (quo_is_missing(value_col)) {
    value_col <- 1
  }
  data <- ungroup(data)
  data <- distinct(data, !!sym(row_col), !!sym(column_col), .keep_all = TRUE)
  row_names <- data[[row_col]]
  col_names <- data[[column_col]]
  if (is.numeric(value_col)) {
    values <- value_col
  } else {
    value_col <- quo_name(value_col)
    values <- data[[value_col]]
  }

  # if it's a factor, preserve ordering
  if (is.factor(row_names)) {
    row_u <- levels(row_names)
    i <- as.integer(row_names)
  } else {
    row_u <- unique(row_names)
    i <- match(row_names, row_u)
  }

  if (is.factor(col_names)) {
    col_u <- levels(col_names)
    j <- as.integer(col_names)
  } else {
    col_u <- unique(col_names)
    j <- match(col_names, col_u)
  }

  ret <- Matrix::sparseMatrix(
    i = i, j = j, x = values,
    dimnames = list(row_u, col_u), ...
  )

  ret
}

#' Casting a data frame to
#' a DocumentTermMatrix, TermDocumentMatrix, or dfm
#'
#' This turns a "tidy" one-term-per-document-per-row data frame into a
#' DocumentTermMatrix or TermDocumentMatrix from the tm package, or a
#' dfm from the quanteda package. These functions support non-standard
#' evaluation through the tidyeval framework. Groups are ignored.
#'
#' @param data Table with one-term-per-document-per-row
#' @param term Column containing terms as string or symbol
#' @param document Column containing document IDs as string or symbol
#' @param value Column containing values as string or symbol
#' @param weighting The weighting function for the DTM/TDM
#' (default is term-frequency, effectively unweighted)
#' @param ... Extra arguments passed on to
#' \code{\link{sparseMatrix}}
#'
#' @details The arguments \code{term}, \code{document}, and \code{value}
#' are passed by expression and support \link[rlang]{quasiquotation};
#' you can unquote strings and symbols.
#'
#' @rdname document_term_casters
#' @export
cast_tdm <- function(data, term, document, value,
                     weighting = tm::weightTf, ...) {
  term <- quo_name(enquo(term))
  document <- quo_name(enquo(document))
  value <- quo_name(enquo(value))
  m <- cast_sparse(data, !!term, !!document, !!value, ...)
  tm::as.TermDocumentMatrix(m, weighting = weighting)
}

#' @rdname document_term_casters
#' @export
cast_dtm <- function(data, document, term, value,
                     weighting = tm::weightTf, ...) {
  document <- quo_name(enquo(document))
  term <- quo_name(enquo(term))
  value <- quo_name(enquo(value))
  m <- cast_sparse(data, !!document, !!term, !!value, ...)
  tm::as.DocumentTermMatrix(m, weighting = weighting)
}

#' @rdname document_term_casters
#' @export
cast_dfm <- function(data, document, term, value, ...) {
  document <- quo_name(enquo(document))
  term <- quo_name(enquo(term))
  value <- quo_name(enquo(value))
  m <- cast_sparse(data, !!document, !!term, !!value, ...)
  quanteda::as.dfm(m)
}
