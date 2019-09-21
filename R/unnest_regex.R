#' Wrapper around unnest_tokens for regex
#'
#' This function is a wrapper around `unnest_tokens( token = "regex" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#' @inheritParams tokenizers::tokenize_regex
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
unnest_regex <- function(
  tbl,
  output,
  input,
  pattern = "\\s+",
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
                token = "regex",
                pattern = pattern,
                simplify = simplify,
                ...
  )
}
