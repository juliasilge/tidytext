#' Split a column into tokens
#'
#' Split a column into tokens, flattening the table into one-token-per-row.
#' This function supports non-standard evaluation through the tidyeval framework.
#'
#' @param tbl A data frame
#'
#' @param token Unit for tokenizing, or a custom tokenizing function. Built-in
#' options are "words" (default), "characters", "character_shingles", "ngrams",
#' "skip_ngrams", "sentences", "lines", "paragraphs", "regex", and
#' "ptb" (Penn Treebank). If a function, should take a character vector and
#' return a list of character vectors of the same length.
#'
#' @param format Either "text", "man", "latex", "html", or "xml". When the
#' format is "text", this function uses the tokenizers package. If not "text",
#' this uses the hunspell tokenizer, and can tokenize only by "word".
#'
#' @param to_lower Whether to convert tokens to lowercase.
#'
#' @param drop Whether original input column should get dropped. Ignored
#' if the original input and new output column have the same name.
#'
#' @param output Output column to be created as string or symbol.
#'
#' @param input Input column that gets split as string or symbol.
#'
#'   The output/input arguments are passed by expression and support
#'   [quasiquotation][rlang::quasiquotation]; you can unquote strings and symbols.
#'
#' @param collapse A character vector of variables to collapse text across,
#'  or `NULL`.
#'
#'   For tokens like n-grams or sentences, text can be collapsed across rows
#'   within variables specified by `collapse` before tokenization. At tidytext
#'   0.2.7, the default behavior for `collapse = NULL` changed to be more
#'   consistent. The new behavior is that text is _not_ collapsed for `NULL`.
#'
#'   Grouping data specifies variables to collapse across in the same way as
#'   `collapse` but you **cannot** use both the `collapse` argument and
#'   grouped data. Collapsing applies mostly to `token` options of "ngrams",
#'   "skip_ngrams", "sentences", "lines", "paragraphs", or "regex".
#'
#' @param ... Extra arguments passed on to [tokenizers][tokenizers::tokenizers], such
#' as `strip_punct` for "words", `n` and `k` for "ngrams" and "skip_ngrams",
#' and `pattern` for "regex".
#'
#' @details If format is anything other than "text", this uses the
#' [hunspell::hunspell_parse()] tokenizer instead of the tokenizers package.
#' This does not yet have support for tokenizing by any unit other than words.
#'
#' Support for `token = "tweets"` was removed in tidytext 0.4.0 because of
#' changes in upstream dependencies.
#'
#' @import dplyr
#' @import rlang
#' @import tokenizers
#' @import janeaustenr
#' @importFrom vctrs vec_rep_each
#' @importFrom vctrs vec_slice
#' @export
#'
#' @name unnest_tokens
#'
#' @examplesIf rlang::is_installed("hunspell")
#'
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- tibble(txt = prideprejudice)
#' d
#'
#' d |>
#'   unnest_tokens(output = word, input = txt)
#'
#' d |>
#'   unnest_tokens(output = sentence, input = txt, token = "sentences")
#'
#' d |>
#'   unnest_tokens(output = ngram, input = txt, token = "ngrams", n = 2)
#'
#' d |>
#'   unnest_tokens(chapter, txt, token = "regex", pattern = "Chapter [\\\\d]")
#'
#' d |>
#'   unnest_tokens(shingle, txt, token = "character_shingles", n = 4)
#'
#' # custom function
#' d |>
#'   unnest_tokens(word, txt, token = stringr::str_split, pattern = " ")
#'
#' # tokenize HTML
#' h <- tibble(row = 1:2,
#'                 text = c("<h1>Text <b>is</b>", "<a href='example.com'>here</a>"))
#'
#' h |>
#'   unnest_tokens(word, text, format = "html")
#'
unnest_tokens <- function(
  tbl,
  output,
  input,
  token = "words",
  format = c(
    "text",
    "man",
    "latex",
    "html",
    "xml"
  ),
  to_lower = TRUE,
  drop = TRUE,
  collapse = NULL,
  ...
) {
  output <- enquo(output)
  input <- enquo(input)
  format <- arg_match(format)

  tokenfunc <- find_function(token, format, to_lower, ...)

  if (!is_null(collapse)) {
    if (is_logical(collapse)) {
      rlang::abort("`collapse` must be `NULL` or a character vector")
    }
    if (is_grouped_df(tbl)) {
      rlang::abort("Use the `collapse` argument or grouped data, but not both.")
    }
    if (any(!purrr::map_lgl(tbl, is_atomic))) {
      rlang::abort(
        paste0(
          "If collapse != NULL (such as for unnesting by sentence or paragraph),\n",
          "unnest_tokens needs all input columns to be atomic vectors (not lists)"
        )
      )
    }

    tbl <- group_by(tbl, !!!syms(collapse))
  }

  if (is_grouped_df(tbl)) {
    tbl <- tbl |>
      ungroup() |>
      mutate(new_groups = cumsum(c(1, diff(group_indices(tbl)) != 0))) |>
      group_by(new_groups, !!!groups(tbl)) |>
      summarise(!!input := stringr::str_c(!!input, collapse = "\n")) |>
      group_by(!!!groups(tbl)) |>
      dplyr::select(-new_groups)

    if (!is_null(collapse)) {
      tbl <- ungroup(tbl)
    }
  }

  col <- pull(tbl, !!input)
  output_lst <- tokenfunc(col, ...)

  if (!(is.list(output_lst) && length(output_lst) == nrow(tbl))) {
    rlang::abort(
      sprintf(
        "Expected output of tokenizing function to be a list of length %d",
        nrow(tbl)
      )
    )
  }

  output <- quo_name(output)
  input <- quo_name(input)

  tbl_indices <- vec_rep_each(seq_len(nrow(tbl)), lengths(output_lst))
  ret <- vec_slice(tbl, tbl_indices)
  ret[[output]] <- purrr::list_c(output_lst)

  if (to_lower) {
    ret[[output]] <- stringr::str_to_lower(ret[[output]])
  }

  # For data.tables we want this to hit the result and be after the result
  # has been assigned, just to make sure that we don't reduce the data.table
  # to 0 rows before inserting the output.
  if (drop && output != input) {
    ret[[input]] <- NULL
  }

  ret
}

find_function <- function(token, format, to_lower, ...) {
  if (is_function(token)) {
    tokenfunc <- token
    return(tokenfunc)
  }
  if (token %in% c("tweets", "tweet")) {
    lifecycle::deprecate_stop(
      "0.4.0",
      I('Support for `token = "tweets"`')
    )
  }
  if (
    token %in%
      c(
        "word",
        "character",
        "character_shingle",
        "ngram",
        "skip_ngram",
        "sentence",
        "line",
        "paragraph",
        "tweet"
      )
  ) {
    cli::cli_abort(
      c(
        "Token must be a supported type, or a function that takes a character vector as input",
        i = 'Did you mean `token = "{token}s"`?'
      )
    )
  }
  if (format != "text") {
    if (token != "words") {
      rlang::abort(
        "Cannot tokenize by any unit except words when format is not text"
      )
    }
    rlang::check_installed("hunspell")
    tokenfunc <- function(col, ...) {
      hunspell::hunspell_parse(
        col,
        format = format
      )
    }
  } else {
    tf <- get(paste0("tokenize_", token))
    if (
      token %in%
        c(
          "characters",
          "character_shingles",
          "words",
          "ngrams",
          "skip_ngrams",
          "ptb"
        )
    ) {
      tokenfunc <- function(col, ...) tf(col, lowercase = to_lower, ...)
    } else {
      tokenfunc <- tf
    }
  }

  tokenfunc
}
