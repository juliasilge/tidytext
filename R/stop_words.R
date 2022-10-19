#' Various lexicons for English stop words
#'
#' English stop words from three lexicons, as a data frame.
#' The snowball and SMART sets are pulled from the tm package. Note
#' that words with non-ASCII characters have been removed.
#'
#' @format A data frame with 1149 rows and 2 variables:
#' \describe{
#'  \item{word}{An English word}
#'  \item{lexicon}{The source of the stop word. Either "onix", "SMART", or "snowball"}
#'  }
#'
#' @source \itemize{
#' \item <http://www.lextek.com/manuals/onix/stopwords1.html>
#' \item <https://www.jmlr.org/papers/volume5/lewis04a/lewis04a.pdf>
#' \item <http://snowball.tartarus.org/algorithms/english/stop.txt>
#' }
"stop_words"

#' Get a tidy data frame of a single stopword lexicon
#'
#' Get a specific stop word lexicon via the \pkg{stopwords} package's
#' [stopwords][stopwords::stopwords] function, in a tidy format with one word per row.
#'
#' @param language The language of the stopword lexicon specified as a
#' two-letter ISO code, such as `"es"`, `"de"`, or `"fr"`.
#' Default is `"en"` for English. Use
#' [stopwords_getlanguages][stopwords::stopwords_getlanguages] from \pkg{stopwords} to see available
#' languages.
#' @param source The source of the stopword lexicon specified. Default is
#' `"snowball"`. Use [stopwords_getsources][stopwords::stopwords_getsources] from
#' \pkg{stopwords} to see available sources.
#'
#' @return A tibble with two columns, `word` and `lexicon`. The
#' parameter `lexicon` is "quanteda" in this case.
#'
#' @examplesIf rlang::is_installed("stopwords")
#'
#' library(dplyr)
#' get_stopwords()
#' get_stopwords(source = "smart")
#' get_stopwords("es", "snowball")
#' get_stopwords("ru", "snowball")
#'
#' @export
#'
get_stopwords <- function(language = "en", source = "snowball") {
  rlang::check_installed("stopwords", "to use this function.")
  tibble(
    word = stopwords::stopwords(language = language, source = source),
    lexicon = source
  )
}
