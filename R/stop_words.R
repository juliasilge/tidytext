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

#' Get a tidy data frame of a single quanteda stop word lexicon
#'
#' Get a specific stop word lexicon from quanteda's \link[quanteda]{stopwords}
#' in a tidy format, with one row per word, in a form that can be joined or
#' anti-joined with a one-word-per-row dataset.
#'
#' @param language The language of the stop word lexicon specified, one of
#' \code{"english"}, \code{"SMART"}, \code{"danish"}, \code{"french"},
#' \code{"greek"}, \code{"hungarian"}, \code{"norwegian"}, \code{"russian"},
#' \code{"swedish"}, \code{"catalan"}, \code{"dutch"}, \code{"finnish"},
#' \code{"german"}, \code{"italian"}, \code{"portuguese"}, \code{"spanish"},
#' or \code{"arabic"}
#'
#' @return A tibble with two columns, \code{word} and \code{lexicon}. The
#' parameter \code{lexicon} is "quanteda" in this case.
#'
#' @examples
#'
#' library(dplyr)
#' get_quanteda_stopwords("spanish")
#' get_quanteda_stopwords("arabic")
#'
#' @export
#'
get_quanteda_stopwords <- function(language = "english") {
  data_frame(word = quanteda::stopwords(kind = language), lexicon = "quanteda")
}

