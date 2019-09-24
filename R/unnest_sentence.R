#' Wrapper around unnest_tokens for sentences, lines and paragraphs
#'
#' These functions are wrappers around `unnest_tokens( token = "sentences" )`
#' `unnest_tokens( token = "lines" )` and `unnest_tokens( token = "paragraphs" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#' @inheritParams tokenizers::tokenize_ngrams
#' @inheritParams tokenizers::tokenize_skip_ngrams
#'
#' @param ... Extra arguments passed on to \link[tokenizers]{tokenizers}
#'
#' @export
#' @rdname unnest_sentences
#' @importFrom dplyr enquo
#'
#' @examples
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- tibble(txt = prideprejudice)
#' d
#' d %>%
#'   unnest_sentences(word, txt)
#'
unnest_sentences <- function(
  tbl,
  output,
  input,
  strip_punct = FALSE,
  simplify = FALSE,
  format = c("text", "man", "latex", "html", "xml"),
  to_lower = TRUE,
  drop = TRUE,
  collapse = NULL,
  ...
){
  format <- match.arg(format)
  unnest_tokens(tbl,
                !! enquo(output),
                !! enquo(input),
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
                token = "sentences",
                strip_punct = strip_punct,
                simplify = simplify,
                ...
  )
}

#' @export
#' @rdname unnest_sentences
#' @importFrom dplyr enquo
unnest_lines <- function(
  tbl,
  output,
  input,
  simplify = FALSE,
  format = c("text", "man", "latex", "html", "xml"),
  to_lower = TRUE,
  drop = TRUE,
  collapse = NULL,
  ...
){
  format <- match.arg(format)
  unnest_tokens(tbl,
                !! enquo(output),
                !! enquo(input),
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
                token = "lines",
                simplify = simplify,
                ...
  )
}

#' @export
#' @rdname unnest_sentences
#' @importFrom dplyr enquo
unnest_paragraphs <- function(
  tbl,
  output,
  input,
  paragraph_break = "\n\n",
  simplify = FALSE,
  format = c("text", "man", "latex", "html", "xml"),
  to_lower = TRUE,
  drop = TRUE,
  collapse = NULL,
  ...
){
  format <- match.arg(format)
  unnest_tokens(tbl,
                !! enquo(output),
                !! enquo(input),
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
                token = "paragraphs",
                paragraph_break = paragraph_break,
                simplify = simplify,
                ...
  )
}

