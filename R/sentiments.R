#' Sentiment lexicons from three sources
#'
#' Three lexicons for sentiment analysis are combined here in a tidy data frame.
#' The lexicons are the NRC Emotion Lexicon from Saif Mohammad and Peter Turney,
#' the sentiment lexicon from Bing Liu and collaborators, and the lexicon of
#' Finn Arup Nielsen. Words with non-ASCII characters were removed from the
#' lexicons.
#'
#' @format A data frame with 23,165 rows and 4 variables:
#' \describe{
#'  \item{word}{An English word}
#'  \item{sentiment}{One of either positive, negative, anger, anticipation,
#'  disgust, fear, joy, sadness, surprise, trust, or \code{NA}. The Bing lexicon
#'  has positive/negative, the NRC lexicon has all options except \code{NA}, and
#'  the AFINN lexicon has only \code{NA}.}
#'  \item{lexicon}{The source of the sentiment for the word. One of either
#'  "nrc", "bing", or "AFINN".}
#'  \item{score}{A numerical score for the sentiment. This value is \code{NA}
#'  for the Bing and NRC lexicons, and runs between -5 and 5 for the AFINN
#'  lexicon.}
#' }
#'
#' @source \itemize{
#'  \item \url{http://saifmohammad.com/WebPages/lexicons.html}
#'  \item \url{https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html}
#'  \item \url{http://www2.imm.dtu.dk/pubdb/views/publication_details.php?id=6010}
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
#' either "afinn", "bing", or "nrc"
#'
#' @return A tbl_df with a \code{word} column, and either a \code{sentiment}
#' column (if \code{lexicon} is "bing" or "nrc") or a numeric \code{score} column
#' (if \code{lexicon} is "afinn").
#'
#' @examples
#'
#' library(dplyr)
#' get_sentiments("afinn")
#' get_sentiments("bing")
#'
#' @export
get_sentiments <- function(lexicon = c("afinn", "bing", "nrc")) {
  lex = match.arg(lexicon)

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
