#' Wrapper around unnest_tokens & characters / character_shingles
#'
#' Thes functions are a wrapper around `unnest_tokens( token = "characters" )`
#' and `unnest_tokens( token = "character_shingles" )`.
#'
#' @seealso
#' + [unnest_tokens()]
#'
#' @inheritParams unnest_tokens
#' @inheritParams tokenizers::tokenize_characters
#' @inheritParams tokenizers::tokenize_character_shingles
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
#' d
#' d %>%
#'   unnest_characters(word, txt)
unnest_characters <- function(
  tbl,
  output,
  input,
  strip_non_alphanum = TRUE,
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
                drop = to_lower,
                collapse = to_lower,
                token = "characters",
                strip_non_alphanum = strip_non_alphanum,
                simplify = simplify,
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
                drop = to_lower,
                collapse = to_lower,
                token = "character_shingles",
                n = n,
                n_min = n_min,
                strip_non_alphanum = strip_non_alphanum,
                simplify = simplify,
                ...
  )
}
