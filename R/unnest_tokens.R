#' Split a column into tokens using the tokenizers package
#'
#' Split a column into tokens using the tokenizers package, splitting the table
#' into one-token-per-row. This function supports non-standard evaluation
#' through the tidyeval framework.
#'
#' @param tbl A data frame
#'
#' @param token Unit for tokenizing, or a custom tokenizing function. Built-in
#' options are "words" (default), "characters", "character_shingles", "ngrams",
#' "skip_ngrams", "sentences", "lines", "paragraphs", "regex", "tweets"
#' (tokenization by word that preserves usernames, hashtags, and URLS ), and
#' "ptb" (Penn Treebank). If a function, should take a character vector and
#' return a list of character vectors of the same length.
#'
#' @param format Either "text", "man", "latex", "html", or "xml". If not text,
#' this uses the hunspell tokenizer, and can tokenize only by "word"
#'
#' @param to_lower Whether to convert tokens to lowercase. If tokens include
#' URLS (such as with \code{token = "tweets"}), such converted URLs may no
#' longer be correct.
#'
#' @param drop Whether original input column should get dropped. Ignored
#' if the original input and new output column have the same name.
#'
#' @param output Output column to be created as string or symbol.
#'
#' @param input Input column that gets split as string or symbol.
#'
#'   The output/input arguments are passed by expression and support
#'   \link[rlang]{quasiquotation}; you can unquote strings and symbols.
#'
#' @param collapse Whether to combine text with newlines first in case tokens
#' (such as sentences or paragraphs) span multiple lines. If NULL, collapses
#' when token method is "ngrams", "skip_ngrams", "sentences", "lines",
#' "paragraphs", or "regex".
#'
#' @param ... Extra arguments passed on to \link[tokenizers]{tokenizers}, such
#' as \code{strip_punct} for "words" and "tweets", \code{n} and \code{k} for
#' "ngrams" and "skip_ngrams", \code{strip_url} for "tweets", and
#' \code{pattern} for "regex".
#'
#' @details If the unit for tokenizing is ngrams, skip_ngrams, sentences, lines,
#' paragraphs, or regex, the entire input will be collapsed together before
#' tokenizing unless \code{collapse = FALSE}.
#'
#' If format is anything other than "text", this uses the
#' \code{\link[hunspell]{hunspell_parse}} tokenizer instead of the tokenizers package.
#' This does not yet have support for tokenizing by any unit other than words.
#'
#' @import dplyr
#' @import rlang
#' @import tokenizers
#' @import janeaustenr
#' @export
#'
#' @name unnest_tokens
#'
#' @examples
#'
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- tibble(txt = prideprejudice)
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
#'   unnest_tokens(chapter, txt, token = "regex", pattern = "Chapter [\\\\d]")
#'
#' d %>%
#'   unnest_tokens(shingle, txt, token = "character_shingles", n = 4)
#'
#' # custom function
#' d %>%
#'   unnest_tokens(word, txt, token = stringr::str_split, pattern = " ")
#'
#' # tokenize HTML
#' h <- tibble(row = 1:2,
#'                 text = c("<h1>Text <b>is</b>", "<a href='example.com'>here</a>"))
#'
#' h %>%
#'   unnest_tokens(word, text, format = "html")
#'
unnest_tokens <- function(tbl, output, input, token = "words",
                          format = c(
                            "text", "man", "latex",
                            "html", "xml"
                          ),
                          to_lower = TRUE, drop = TRUE,
                          collapse = NULL, ...) {
  output <- quo_name(enquo(output))
  input <- quo_name(enquo(input))

  # retain top-level attributes
  attrs <- attributes(tbl)
  custom_attributes <- attrs[setdiff(
    names(attrs),
    c(
      "dim", "dimnames",
      "names", "row.names",
      ".internal.selfref"
    )
  )]

  format <- match.arg(format)

  if (is.function(token)) {
    tokenfunc <- token
  } else if (token %in% c(
    "word", "character",
    "character_shingle", "ngram",
    "skip_ngram", "sentence", "line",
    "paragraph", "tweet"
  )) {
    rlang::abort(paste0(
      "Error: Token must be a supported type, or a function that takes a character vector as input\nDid you mean token = ",
      token, "s?"
    ))
  } else if (format != "text") {
    if (token != "words") {
      rlang::abort("Cannot tokenize by any unit except words when format is not text")
    }
    tokenfunc <- function(col, ...) hunspell::hunspell_parse(col,
                                                             format = format
    )
  } else {
    if (is.null(collapse) && token %in% c(
      "ngrams", "skip_ngrams", "sentences",
      "lines", "paragraphs", "regex",
      "character_shingles"
    )) {
      collapse <- TRUE
    }
    tf <- get(paste0("tokenize_", token))
    if (token %in% c(
      "characters", "words", "ngrams", "skip_ngrams",
      "tweets", "ptb"
    )) {
      tokenfunc <- function(col, ...) tf(col, lowercase = FALSE, ...)
    } else {
      tokenfunc <- tf
    }
  }

  if (!is.null(collapse) && collapse) {
    if (any(!purrr::map_lgl(tbl, is.atomic))) {
      rlang::abort(
        paste0("If collapse = TRUE (such as for unnesting by sentence or paragraph),\n",
               "unnest_tokens needs all input columns to be atomic vectors (not lists)")
      )
    }

    group_vars <- setdiff(names(tbl), input)
    exps <- substitute(
      stringr::str_c(colname, collapse = "\n"),
      list(colname = as.name(input))
    )

    if (is_empty(group_vars)) {
      tbl <- summarise(tbl, col = !!exps)
    } else {
      tbl <- group_by(tbl, !!!syms(group_vars)) %>%
        summarise(col = !!exps) %>%
        ungroup()
    }

    names(tbl)[names(tbl) == "col"] <- input
  }

  col <- tbl[[input]]
  output_lst <- tokenfunc(col, ...)

  if (!(is.list(output_lst) && length(output_lst) == nrow(tbl))) {
    rlang::abort(
      "Expected output of tokenizing function to be a list of length ",
      nrow(tbl)
    )
  }

  ret <- tbl[rep(seq_len(nrow(tbl)), lengths(output_lst)), , drop = FALSE]
  ret[[output]] <- unlist(output_lst)

  if (to_lower) {
    if (!is.function(token))
      if(token == "tweets") {
        rlang::inform("Using `to_lower = TRUE` with `token = 'tweets'` may not preserve URLs.")
      }
    ret[[output]] <- stringr::str_to_lower(ret[[output]])
  }

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
