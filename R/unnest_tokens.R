#' Split a column into tokens using either the tokenizer package or str_split
#'
#' @param tbl Data frame
#' @param token_col Token column to be created
#' @param text_col Text column that gets split
#' @param method Method for tokenizing. If tokenizer package
#' is installed, options are "characters", "words", "sentences", "lines",
#' "paragraphs", and "regex". Otherwise, using str_split the option is "words".
#' Default is "words".
#' @param to_lower Whether to turn column lowercase
#' @param drop Whether original text column should get dropped. Ignored
#' if the original text and new token column have the same name.
#' @param token Token column to be created as bare name
#' @param text Text column that gets split as bare name
#' @param ... Extra arguments passed on to the tokenizer
#'
#' @details If the method for tokenizing is sentences, lines, paragraphs, or
#' regex, the entire text will be collapsed together before tokenizing.
#'
#' @import dplyr
#' @import tokenizers
#'
#' @name unnest_tokens
#'
#' @examples
#'
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- data_frame(txt = prideprejudice)
#' d
#'
#' d %>%
#'   unnest_tokens(word, txt)
#'
#' d %>%
#'   unnest_tokens(word, txt, method = "sentences")
#'
#' @export
unnest_tokens_ <- function(tbl, token_col, text_col, method = "words",
                          to_lower = TRUE, drop = TRUE, ...) {
  if (method %in% c("sentences", "lines", "paragraphs", "regex")) {
    exps <- list(substitute(stringr::str_c(colname, collapse = "\n"),
                            list(colname = as.name(text_col))))
    names(exps) <- text_col
    tbl <- group_by_(tbl, .dots = setdiff(colnames(tbl), text_col)) %>%
      summarise_(.dots = exps)
  }
  col <- tbl[[text_col]]
  if (to_lower) {
    col <- stringr::str_to_lower(col)
  }

  method <- paste0("tokenize_", method)
  tokenfunc <- get(method, as.environment("package:tokenizers"))
  if (method == "tokenize_characters" || method == "tokenize_words") {
    tbl[[token_col]] <- tokenfunc(col, lowercase = FALSE, ...)
  } else { # mash the whole character string together here for other tokenizer functions
    tbl[[token_col]] <- tokenfunc(col, ...)
  }

  if (drop && text_col != token_col) {
    tbl[[text_col]] <- NULL
  }

  ret <- tidyr::unnest_(tbl, token_col)

  ret <- ret[ret[[token_col]] != "", ]

  ret
}


#' @rdname unnest_tokens
#' @export
unnest_tokens <- function(tbl, token, text, method = "words",
                           to_lower = TRUE, drop = TRUE, ...) {
  token_col <- col_name(substitute(token))
  text_col <- col_name(substitute(text))

  unnest_tokens_(tbl, token_col, text_col, method = method,
                 to_lower = to_lower, drop = drop, ...)
}
