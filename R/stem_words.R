#' Word stemming
#'
#' @param df the data.frame containing the unnested text
#' @param col the column containing the words. Default is word.
#' @param language language of the text. Default is english. The list of all supported languages
#' is available with \code{\link[SnowballC]{getStemLanguages}}
#'
#' @importFrom proustr pr_stem_words
#'
#' @return a tibble with stemmed words
#' @export
#'
#' @examples
#' library(janeaustenr)
#' library(dplyr)
#' original_books <- austen_books() %>%
#'  group_by(book) %>%
#'  mutate(linenumber = row_number()) %>%
#'  ungroup()
#'
#' library(tidytext)
#' tidy_books <- original_books %>%
#'  unnest_tokens(word, text) %>%
#'  stem_words()
#'
#'  tidy_books
#'

stem_words <- function(df, col = word, language = "english"){
  col <- rlang::enquo(col)
  proustr::pr_stem_words(df, !!col, language = language)
}
