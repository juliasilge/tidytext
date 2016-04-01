#' Tidy dictionary objects from the quanteda package
#'
#' @param x A dictionary object
#' @param regex Whether to turn dictionary items from a glob to a regex
#' @param ... Extra arguments, not used
#'
#' @return A data frame with two columns: category and word.
#'
#' @name dictionary_tidiers
#'
#' @export
tidy.dictionary <- function(x, regex = FALSE, ...) {
  ret <- plyr::ldply(x, function(e) data.frame(word = e, stringsAsFactors = FALSE),
                     .id = "category") %>%
    mutate(category = as.character(category))

  if (regex) {
    ret$word <- utils::glob2rx(ret$word)
  }
  ret
}
