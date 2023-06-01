#' Wrapper around unnest_tokens for tweets
#'
#' `r lifecycle::badge("deprecated")`
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#'
#' @param ... Extra arguments passed on to [tokenizers][tokenizers::tokenizers]
#'
#' @export
#' @keywords internal
#' @importFrom dplyr enquo
#'
unnest_tweets <- function(tbl, output, input, ...){
  lifecycle::deprecate_stop("0.4.0", "unnest_tweets()")
}
