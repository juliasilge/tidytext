#' Split a column into tokens using the tokenizers package
#'
#' @param tbl Data frame
#' @param output_col Output column to be created
#' @param input_col Input column that gets split
#' @param token Unit for tokenizing. Options are "characters", "words",
#' "sentences", "lines", "paragraphs", and "regex". Default is "words".
#' @param to_lower Whether to turn column lowercase
#' @param drop Whether original input column should get dropped. Ignored
#' if the original input and new output column have the same name.
#' @param output Output column to be created as bare name
#' @param input Input column that gets split as bare name
#' @param ... Extra arguments passed on to the tokenizer
#'
#' @details If the unit for tokenizing is sentences, lines, paragraphs, or
#' regex, the entire input will be collapsed together before tokenizing.
#'
#' @import dplyr
#' @import tokenizers
#' @import janeaustenr
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
#'   unnest_tokens(word, txt, token = "sentences")
#'
#' @export
unnest_tokens_ <- function(tbl, output_col, input_col, token = "words",
                          to_lower = TRUE, drop = TRUE, ...) {
  if (token %in% c("sentences", "lines", "paragraphs", "regex")) {
    exps <- list(substitute(stringr::str_c(colname, collapse = "\n"),
                            list(colname = as.name(input_col))))
    names(exps) <- input_col
    tbl <- group_by_(tbl, .dots = setdiff(colnames(tbl), input_col)) %>%
      summarise_(.dots = exps)
  }

  col <- tbl[[input_col]]

  token <- paste0("tokenize_", token)
  tokenfunc <- get(token)
  if (token == "tokenize_characters" || token == "tokenize_words") {
    tbl[[output_col]] <- tokenfunc(col, lowercase = FALSE, ...)
  } else { # mash the whole character string together here for other tokenizer functions
    tbl[[output_col]] <- tokenfunc(col, ...)
  }

  if (drop && input_col != output_col) {
    tbl[[input_col]] <- NULL
  }

  ret <- tidyr::unnest_(tbl, output_col)

  if (to_lower) {
    ret[[output_col]] <- stringr::str_to_lower(ret[[output_col]])
  }

  ret <- ret[ret[[output_col]] != "", ]

  ret
}


#' @rdname unnest_tokens
#' @export
unnest_tokens <- function(tbl, output, input, token = "words",
                           to_lower = TRUE, drop = TRUE, ...) {
  output_col <- col_name(substitute(output))
  input_col <- col_name(substitute(input))

  unnest_tokens_(tbl, output_col, input_col, token = token,
                 to_lower = to_lower, drop = drop, ...)
}
