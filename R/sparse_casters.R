#' Standard-evaluation version of cast_sparse
#'
#' @param data A tbl
#' @param row_col String version of column to use as row names
#' @param column_col String version of column to use as column names
#' @param value_col String version of column to use as sparse matrix
#' values, or a numeric vector to use. Default 1 (to create a binary
#' matrix)
#' @param ... Extra arguments to pass on to \code{\link{sparseMatrix}}
#'
#' @import Matrix
#' @export
cast_sparse_ <- function(data, row_col, column_col, value_col = 1,
                         ...) {
  data <- distinct_(data, row_col, column_col)
  row_names <- data[[row_col]]
  col_names <- data[[column_col]]
  if (is.numeric(value_col)) {
    values <- value_col
  } else {
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

  ret <- Matrix::sparseMatrix(i = i, j = j, x = values,
                              dimnames = list(row_u, col_u), ...)

  ret
}


#' Create a sparse matrix from row names, column names, and values
#' in a table.
#'
#' @param data A tbl
#' @param row A bare column name to use as row names in sparse matrix
#' @param column A bare column name to use as column names in sparse matrix
#' @param value A bare column name to use as sparse matrix values, default 1
#'
#' @return A sparse Matrix object, with one row for each unique value in
#' the \code{row} column, one column for each unique value in the \code{column}
#' column, and with as many non-zero values as there are rows in \code{data}.
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
#' @export
cast_sparse <- function(data, row, column, value) {
  if (missing(value)) {
    value_col <- 1
  } else {
    value_col <- col_name(substitute(value))
    if (is.null(data[[value_col]])) {
      value_col <- value
    }
  }

  cast_sparse_(data,
               col_name(substitute(row)),
               col_name(substitute(column)),
               value_col)
}


#' Casting a data frame to
#' a DocumentTermMatrix, TermDocumentMatrix, or dfm
#'
#' This turns a "tidy" one-term-per-dopument-per-row data frame into a
#' DocumentTermMatrix or TermDocumentMatrix from the tm package, or a
#' dfm from the quanteda package. Each caster
#' can be called either with non-standard evaluation (bare column names)
#' or character vectors (for \code{cast_tdm_} and \code{cast_dtm_}).
#'
#' @param data Table with one-term-per-document-per-row
#' @param term,term_col (Bare) name of a column with terms
#' @param document,document_col (Bare) name of a column with documents
#' @param value,value_col (Bare) name of a column containing values
#' @param weighting The weighting function for the DTM/TDM
#' (default is term-frequency, effectively unweighted)
#' @param ... Extra arguments passed on to
#' \code{\link{sparseMatrix}}
#'
#' @rdname document_term_casters
#' @export
cast_tdm_ <- function(data, term_col, document_col, value_col,
                      weighting = tm::weightTf, ...) {
  m <- cast_sparse_(data, term_col, document_col, value_col, ...)
  tm::as.TermDocumentMatrix(m, weighting = weighting)
}


#' @rdname document_term_casters
#' @export
cast_tdm <- function(data, term, document, value,
                      weighting = tm::weightTf, ...) {
  cast_tdm_(data,
            col_name(substitute(term)),
            col_name(substitute(document)),
            col_name(substitute(value)),
            weighting = weighting, ...)
}



#' @rdname document_term_casters
#' @export
cast_dtm_ <- function(data, document_col, term_col, value_col,
                      weighting = tm::weightTf, ...) {
  m <- cast_sparse_(data, document_col, term_col, value_col, ...)
  tm::as.DocumentTermMatrix(m, weighting = weighting)
}


#' @rdname document_term_casters
#' @export
cast_dtm <- function(data, document, term, value,
                     weighting = tm::weightTf, ...) {
  cast_dtm_(data,
            col_name(substitute(document)),
            col_name(substitute(term)),
            col_name(substitute(value)),
            weighting = weighting, ...)
}


#' @rdname document_term_casters
#' @export
cast_dfm_ <- function(data, document_col, term_col, value_col, ...) {
  m <- cast_sparse_(data, document_col, term_col, value_col, ...)
  methods::new("dfmSparse", m)
}


#' @rdname document_term_casters
#' @export
cast_dfm <- function(data, document, term, value, ...) {
  cast_dfm_(data,
            col_name(substitute(document)),
            col_name(substitute(term)),
            col_name(substitute(value)), ...)
}
