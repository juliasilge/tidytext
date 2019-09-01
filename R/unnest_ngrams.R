#' Wrapper around unnest_tokens for n-grams
#'
#' This function is a wrapper around `unnest_tokens( token = "ngrams" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#' @inheritParams tokenizers::tokenize_ngrams
#'
#' @param ... Extra arguments passed on to \link[tokenizers]{tokenizers}
#'
#' @export
#' @importFrom dplyr enquo
#'
#' @examples
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- tibble(txt = prideprejudice)
#' d
#' d %>%
#'   unnest_ngrams(word, txt)
#'
unnest_ngrams <- function(
  tbl,
  output,
  input,
  n = 3L,
  n_min = n,
  ngram_delim = " ",
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
                token = "ngrams",
                n = n,
                n_min = n_min,
                ngram_delim = ngram_delim,
                ...
  )
}
