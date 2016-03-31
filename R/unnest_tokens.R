#' Split a column into tokens
#'
#' @param tbl Data frame
#' @param token_col Token column to be created
#' @param text_col Text column that gets split
#' @param method Method for tokenizing. If tokenizer package
#' is installed, use tokenize. Otherwise, use str_split.
#' @param to_lower Whether to turn column lowercase
#' @param drop Whether original text column should get dropped
#' @param ... Extra arguments passed on to the tokenizer
#'
#' @name unnest_tokens
#'
#' @export
unnest_tokens_ <- function(tbl, token_col, text_col, method = NULL,
                          to_lower = TRUE, drop = TRUE, ...) {
  col <- tbl[[text_col]]
  if (to_lower) {
    col <- stringr::str_to_lower(col)
  }

  # I don't have tokenizer so TODO on Julia's computer
  tbl[[token_col]] <- stringr::str_split(col, "[^A-Za-z']+")

  if (drop) {
    tbl[[text_col]] <- NULL
  }

  ret <- tidyr::unnest_(tbl, token_col)

  ret <- ret[ret[[token_col]] != "", ]

  ret
}


#' @export
unnest_tokens <- function(tbl, token, text, method = NULL,
                           to_lower = TRUE, drop = TRUE, ...) {
  token_col <- col_name(substitute(token))
  text_col <- col_name(substitute(text))

  unnest_tokens_(tbl, token_col, text_col, method = method,
                 to_lower = to_lower, drop = drop, ...)
}
