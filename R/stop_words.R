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

#' Stop words from 56 languages
#'
#' This list contains 56 data frames with stop words from various non-english
#' languages. You can acess them with \code{stop_words_foreign$} and the two letters
#' describing the language. For example \code{stop_words_foreign$fr} refer to french
#' stopwords. To find which initial refer to your language, please visit
#' \url{https://github.com/stopwords-iso}.
#'
#' @format A list of 56 data frame with 1 variable each:
#' \describe{
#'  \item{word}{A stop word}
#'  }
#'
#' @source \itemize{
#' \item \url{https://github.com/stopwords-iso/stopwords-iso}
#' }
"stop_words_foreign"
