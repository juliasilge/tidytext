#' Wrapper around unnest_tokens for characters and character shingles
#'
#' These functions are a wrapper around `unnest_tokens( token = "characters" )`
#' and `unnest_tokens( token = "character_shingles" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams tokenizers::tokenize_characters
#' @inheritParams tokenizers::tokenize_character_shingles
#' @inheritParams unnest_tokens
#'
#' @param ... Extra arguments passed on to \link[tokenizers]{tokenizers}
#'
#' @export
#' @importFrom dplyr enquo
#' @rdname unnest_character
#'
#' @examples
#' library(dplyr)
#' library(janeaustenr)
#'
#' d <- tibble(txt = prideprejudice)
#'
#' d %>%
#'   unnest_characters(word, txt)
#'
#' d %>%
#'   unnest_character_shingles(word, txt, n = 3)
#'
unnest_characters <- function(
  tbl,
  output,
  input,
  strip_non_alphanum = TRUE,
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
                token = "characters",
                format = format,
                to_lower = to_lower,
                drop = to_lower,
                collapse = to_lower,
                strip_non_alphanum = strip_non_alphanum,
                ...
  )
}

#' @export
#' @importFrom dplyr enquo
#' @rdname unnest_character
#'
unnest_character_shingles <- function(
  tbl,
  output,
  input,
  n = 3L,
  n_min = n,
  strip_non_alphanum = TRUE,
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
                token = "character_shingles",
                format = format,
                to_lower = to_lower,
                drop = to_lower,
                collapse = to_lower,
                n = n,
                n_min = n_min,
                strip_non_alphanum = strip_non_alphanum,
                ...
  )
}
