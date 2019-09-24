#' Wrapper around unnest_tokens for tweets
#'
#' This function is a wrapper around `unnest_tokens( token = "tweets" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#' @inheritParams tokenizers::tokenize_tweets
#'
#' @param ... Extra arguments passed on to \link[tokenizers]{tokenizers}
#'
#' @export
#' @importFrom dplyr enquo
#'
#' @examples
#' library(dplyr)
#' tweets <- tibble(
#'    id = 1,
#'    txt = "@rOpenSci and #rstats see: https://cran.r-project.org"
#')
#'
#' tweets %>%
#'    unnest_tweets(out, txt)
#'
unnest_tweets <- function(
  tbl,
  output,
  input,
  strip_punct = TRUE,
  strip_url = FALSE,
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
                token = "tweets",
                format = format,
                to_lower = to_lower,
                drop = drop,
                collapse = collapse,
                strip_punct = strip_punct,
                strip_url = strip_url,
                ...
  )
}
