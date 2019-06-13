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

#' Get a tidy data frame of a single stopword lexicon
#'
#' Get a specific stop word lexicon via the \pkg{stopwords} package's
#' \link[stopwords]{stopwords} function, in a tidy format with one word per row.
#'
#' @param language The language of the stopword lexicon specified as a
#' two-letter ISO code, such as \code{"es"}, \code{"de"}, or \code{"fr"}.
#' Default is \code{"en"} for English. Use
#' \link[stopwords]{stopwords_getlanguages} from \pkg{stopwords} to see available
#' languages.
#' @param source The source of the stopword lexicon specified. Default is
#' \code{"snowball"}. Use \link[stopwords]{stopwords_getsources} from
#' \pkg{stopwords} to see available sources.
#'
#' @return A tibble with two columns, \code{word} and \code{lexicon}. The
#' parameter \code{lexicon} is "quanteda" in this case.
#'
#' @examples
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
  tibble(
    word = stopwords::stopwords(language = language, source = source),
    lexicon = source
  )
}
