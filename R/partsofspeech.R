#' Parts of speech for English words from the Moby Project
#'
#' Parts of speech for English words from the Moby Project by Grady Ward.
#' Words with non-ASCII characters and items with a space have been removed.
#' The raw data is in \code{inst/extdata}.
#'
#' @format A data frame with 205,985 rows and 2 variables:
#' \describe{
#'  \item{word}{An English word}
#'  \item{pos}{The part of speech of the word. One of 13 options, such as
#'             "Noun", "Adverb", "Adjective"}
#' }
#'
#' @examples
#'
#' library(dplyr)
#'
#' partsofspeech
#'
#' partsofspeech %>%
#'   count(pos, sort = TRUE)
#'
#' @source \url{http://icon.shef.ac.uk/Moby/mpos.html}
"partsofspeech"
