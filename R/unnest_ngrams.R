#' Wrapper around unnest_tokens for n-grams
#'
#' These functions are wrappers around `unnest_tokens( token = "ngrams" )`
#' and `unnest_tokens( token = "skip_ngrams" )` .
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams tokenizers::tokenize_ngrams
#' @inheritParams tokenizers::tokenize_skip_ngrams
#' @inheritParams unnest_tokens
#'
#' @param ... Extra arguments passed on to \link[tokenizers]{tokenizers}
#'
#' @export
#' @rdname unnest_ngrams
#' @importFrom dplyr enquo
#'
#' @examples
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- tibble(txt = prideprejudice)
#'
#' d %>%
#'   unnest_ngrams(word, txt, n = 2)
#'
#' d %>%
#'   unnest_skip_ngrams(word, txt, n = 3, k = 1)
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

#' @export
#' @rdname unnest_ngrams
#' @importFrom dplyr enquo
unnest_skip_ngrams <- function(
  tbl,
  output,
  input,
  n_min = 1,
  n = 3,
  k = 1,
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
                token = "skip_ngrams",
                n = n,
                n_min = n_min,
                k = k,
                ...
  )
}
