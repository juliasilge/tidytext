#' Wrapper around unnest_tokens for sentences, lines, and paragraphs
#'
#' These functions are wrappers around `unnest_tokens( token = "sentences" )`
#' `unnest_tokens( token = "lines" )` and `unnest_tokens( token = "paragraphs" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#' @inheritParams tokenizers::tokenize_sentences
#' @inheritParams tokenizers::tokenize_lines
#' @inheritParams tokenizers::tokenize_paragraphs
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
#'
#' d %>%
#'   unnest_sentences(word, txt)
#'
unnest_sentences <- function(
  tbl,
  output,
  input,
  strip_punct = FALSE,
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
                token = "sentences",
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
                strip_punct = strip_punct,
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
                token = "lines",
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
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
                token = "paragraphs",
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
                paragraph_break = paragraph_break,
                ...
  )
}

