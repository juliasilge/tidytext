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
#' \item \url{http://www.lextek.com/manuals/onix/stopwords1.html}
#' \item \url{http://www.jmlr.org/papers/volume5/lewis04a/lewis04a.pdf}
#' \item \url{http://snowball.tartarus.org/algorithms/english/stop.txt}
#' }
"stop_words"

#' Get a tidy data frame of stopwords
#'
#' Get stopwords in a tidy format, with one row per word,
#' in a form that can be joined with a one-word-per-row dataset.
#'
#' @param language The stopwords language;
#' either "en" for english, or "fr" for french
#'
#' @return For english, a tbl_df with a \code{word} column, and a \code{lexicon}
#' column, which is either "onix", "SMART", or "snowball".
#'
#' For french, a tbl_df with a single \code{word} column.
#'
#'
#' @examples
#'
#' get_stopwords("en")
#' get_stopwords("fr")
#'
#' @importFrom proustr proust_stopwords
#'
#' @export
get_stopwords <- function(language = c("en", "fr")) {
  data(list = "stop_words", package = "tidytext", envir = environment())
  lang <- match.arg(language)

  if (lang == "en") {
    tidytext::stop_words
  } else {
    proustr::proust_stopwords()
  }

}
