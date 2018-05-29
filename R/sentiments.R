#' Sentiment lexicons from four sources
#'
#' Four lexicons for sentiment analysis are combined here in a tidy data frame.
#' The lexicons are the NRC Emotion Lexicon from Saif Mohammad and Peter Turney,
#' the sentiment lexicon from Bing Liu and collaborators, of
#' Finn Arup Nielsen, and of Tim Loughran and Bill McDonald.
#' Words with non-ASCII characters were removed from the
#' lexicons.
#'
#' @format A data frame with 27,314 rows and 4 variables:
#' \describe{
#'  \item{word}{An English word}
#'  \item{sentiment}{A sentiment whose possible values depend on the lexicon.
#'  The "afinn" lexicon has no sentiment category (all are NA), and each of the
#'  others can be "positive" or "negative". The NRC lexicon can also be
#'  "anger", "anticipation", "disgust", "fear", "joy", "sadness", "surprise",
#'  or "trust", and the Loughran lexicon can also be "litigious", "uncertainty",
#'  "constraining", and "superfluous".}
#'  \item{lexicon}{The source of the sentiment for the word. One of either
#'  "nrc", "bing", "loughran", or "AFINN".}
#'  \item{score}{A numerical score for the sentiment. This value is \code{NA}
#'  for the Bing, NRC, and Loughran lexicons, and runs between -5 and 5 for the
#'  AFINN lexicon.}
#' }
#'
#' @details Note that the Loughran lexicon is best suited for financial text,
#' (e.g. where "share" is not necessarily positive and "liability"
#' not necessarily negative).
#'
#' @source \itemize{
#'  \item \url{http://saifmohammad.com/WebPages/lexicons.html}
#'  \item \url{https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html}
#'  \item \url{http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010}
#'  \item \url{http://www3.nd.edu/~mcdonald/Word_Lists.html}
#'  }
"sentiments"


#' Get a tidy data frame of a single sentiment lexicon
#'
#' Get specific sentiment lexicons in a tidy format, with one row per word,
#' in a form that can be joined with a one-word-per-row dataset.
#' Each of these comes from the included \code{\link{sentiments}} data frame,
#' but this performs the filtering for a specific lexicon, and removes
#' columns that are not used in that lexicon.
#'
#' @param lexicon The sentiment lexicon to retrieve;
#' either "afinn", "bing", "nrc", or "loughran"
#'
#' @return A tbl_df with a \code{word} column, and either a \code{sentiment}
#' column (if \code{lexicon} is not "afinn") or a numeric \code{score} column
#' (if \code{lexicon} is "afinn").
#'
#' @examples
#'
#' library(dplyr)
#' get_sentiments("afinn")
#' get_sentiments("bing")
#'
#' @importFrom utils data
#' @export
get_sentiments <- function(lexicon = c("afinn", "bing", "nrc", "loughran")) {
  data(list = "sentiments", package = "tidytext", envir = environment())
  lex <- match.arg(lexicon)

  if (lex == "afinn") {
    # turn uppercase: reverse compatibility issue
    lex <- "AFINN"
  }

  ret <- sentiments %>%
    dplyr::filter(lex == lexicon) %>%
    dplyr::select(-lexicon)

  if (lex == "AFINN") {
    ret$sentiment <- NULL
  } else {
    ret$score <- NULL
  }

  ret
}
