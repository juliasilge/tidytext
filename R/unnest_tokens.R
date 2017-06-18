#'@export
unnest_tokens_.default <- function(tbl, output, input, token = "words",
                                  format = c("text", "man", "latex",
                                             "html", "xml"),
                                  to_lower = TRUE, drop = TRUE,
                                  collapse = NULL, ...) {
  if (any(!purrr::map_lgl(tbl, is.atomic))) {
    stop("unnest_tokens expects all columns of input to be atomic vectors (not lists)")
  }

  # retain top-level attributes
  attrs <- attributes(tbl)
  custom_attributes <- attrs[setdiff(names(attrs),
                                    c("class", "dim", "dimnames",
                                      "names", "row.names", ".internal.selfref"))]

  format <- match.arg(format)

  if (is.function(token)) {
    tokenfunc <- token
  } else if (format != "text") {
    if (token != "words") {
      stop("Cannot tokenize by any unit except words when format is not text")
    }
    tokenfunc <- function(col, ...) hunspell::hunspell_parse(col,
                                                             format = format)
  } else {
    if (is.null(collapse) && token %in% c("ngrams", "skip_ngrams", "sentences",
                                          "lines", "paragraphs", "regex")) {
      collapse <- TRUE
    }

    tf <- get(paste0("tokenize_", token))
    if (token %in% c("characters", "words", "ngrams", "skip_ngrams")) {
      tokenfunc <- function(col, ...) tf(col, lowercase = FALSE, ...)
    } else {
      tokenfunc <- tf
    }
  }

  if (!is.null(collapse) && collapse) {
    exps <- list(substitute(stringr::str_c(colname, collapse = "\n"),
                            list(colname = as.name(input))))
    names(exps) <- input
    tbl <- group_by_(tbl, .dots = setdiff(colnames(tbl), input)) %>%
      summarise_(.dots = exps) %>%
      ungroup()
  }

  col <- tbl[[input]]
  output_lst <- tokenfunc(col, ...)

  if (!(is.list(output_lst) && length(output_lst) == nrow(tbl))) {
    stop("Expected output of tokenizing function to be a list of length ",
         nrow(tbl))
  }

  ret <- tbl[rep(seq_len(nrow(tbl)), lengths(output_lst)), , drop = FALSE]
  ret[[output]] <- unlist(output_lst)

  if (to_lower) {
    ret[[output]] <- stringr::str_to_lower(ret[[output]])
  }

  ret <- ret[ret[[output]] != "", , drop = FALSE]

  # For data.tables we want this to hit the result and be after the result
  # has been assigned, just to make sure that we don't reduce the data.table
  # to 0 rows before inserting the output.
  if (drop && (input != output)) {
    ret[[input]] <- NULL
  }

  # re-assign top-level attributes
  for (n in names(custom_attributes)) {
    attr(ret, n) <- custom_attributes[[n]]
  }

  ret
}

#'@export
unnest_tokens_.data.table <- function(tbl, output, input, token = "words",
                                     format = c("text", "man", "latex",
                                                "html", "xml"),
                                     to_lower = TRUE, drop = TRUE,
                                     collapse = NULL, ...) {
  ret <- unnest_tokens_.default(tbl, output, input, token,
                                format, to_lower, drop, collapse, ...)

  ret
}

#' Split a column into tokens using the tokenizers package
#'
#' Split a column into tokens using the tokenizers package, splitting the table
#' into one-token-per-row. \code{unnest_tokens_} is the standard evaluation version.
#'
#' @param tbl Data frame
#'
#' @param token Unit for tokenizing, or a custom tokenizing function. Built-in
#' options are "words" (default), "characters", "ngrams", "skip_ngrams",
#' "sentences", "lines", "paragraphs", and "regex". If a function, should take
#' a character vector and return a list of character vectors of the same length.
#'
#' @param format Either "text", "man", "latex", "html", or "xml". If not text,
#' this uses the hunspell tokenizer, and can tokenize only by "word"
#'
#' @param to_lower Whether to turn column lowercase.
#'
#' @param drop Whether original input column should get dropped. Ignored
#' if the original input and new output column have the same name.
#'
#' @param output Output column to be created as bare name.
#'
#' @param input Input column that gets split as bare name.
#'
#' @param collapse Whether to combine text with newlines first in case tokens
#' (such as sentences or paragraphs) span multiple lines. If NULL, collapses
#' when token method is "ngrams", "skip_ngrams", "sentences", "lines",
#' "paragraphs", or "regex".
#'
#' @param ... Extra arguments passed on to the tokenizer, such as \code{n} and
#' \code{k} for "ngrams" and "skip_ngrams" or \code{pattern} for "regex".
#'
#' @details If the unit for tokenizing is ngrams, skip_ngrams, sentences, lines,
#' paragraphs, or regex, the entire input will be collapsed together before
#' tokenizing.
#'
#' If format is anything other than "text", this uses the
#' \code{\link[hunspell]{hunspell_parse}} tokenizer instead of the tokenizers package.
#' This does not yet have support for tokenizing by any unit other than words.
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
#'   unnest_tokens(sentence, txt, token = "sentences")
#'
#' d %>%
#'   unnest_tokens(ngram, txt, token = "ngrams", n = 2)
#'
#' d %>%
#'   unnest_tokens(ngram, txt, token = "skip_ngrams", n = 4, k = 2)
#'
#' d %>%
#'   unnest_tokens(chapter, txt, token = "regex", pattern = "Chapter [\\d]")
#'
#' # custom function
#' d %>%
#'   unnest_tokens(word, txt, token = stringr::str_split, pattern = " ")
#'
#' # tokenize HTML
#' h <- data_frame(row = 1:2,
#'                 text = c("<h1>Text <b>is<b>", "<a href='example.com'>here</a>"))
#'
#' h %>%
#'   unnest_tokens(word, text, format = "html")
#'
#' @rdname unnest_tokens
#' @export
unnest_tokens <- function(tbl, output, input, token = "words",
                          format = c("text", "man", "latex", "html", "xml"),
                          to_lower = TRUE, drop = TRUE,
                          collapse = NULL, ...) {
  output_col <- col_name(substitute(output))
  input_col <- col_name(substitute(input))

  unnest_tokens_(tbl, output_col, input_col, token = token,
                 format = format, to_lower = to_lower,
                 drop = drop, collapse = collapse, ...)
}

#' @rdname unnest_tokens
#' @export
unnest_tokens_ <- function(tbl, output, input, token = "words",
                          format = c("text", "man", "latex", "html", "xml"),
                          to_lower = TRUE, drop = TRUE,
                          collapse = NULL, ...) {
  UseMethod("unnest_tokens_")
}

