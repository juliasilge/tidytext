#' Parts of speech for English words from the Moby Project
#'
#' Parts of speech for English words from the Moby Project by Grady Ward.
#' Words with non-ASCII characters and items with a space have been removed.
#'
#' @format A data frame with 205,985 rows and 2 variables:
#' \describe{
#'  \item{word}{An English word}
#'  \item{pos}{The part of speech of the word. One of 13 options, such as
#'             "Noun", "Adverb", "Adjective"}
#' }
#'
#' @details Another dataset of English parts of speech, available only for
#' non-commercial use, is available as part of SUBTLEXus at
#' \url{https://www.ugent.be/pp/experimentele-psychologie/en/research/documents/subtlexus/}.
#'
#' @examples
#'
#' library(dplyr)
#'
#' parts_of_speech
#'
#' parts_of_speech %>%
#'   count(pos, sort = TRUE)
#'
#' @source \url{https://archive.org/details/mobypartofspeech03203gut}
"parts_of_speech"
