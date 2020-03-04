#' Sentiment lexicon from Bing Liu and collaborators
#'
#' Lexicon for opinion and sentiment analysis in a tidy data frame. This
#' dataset is included in this package with permission of the creators, and
#' may be used in research, commercial, etc. contexts with attribution, using
#' either the paper or URL below.
#'
#' This lexicon was first published in:
#'
#' Minqing Hu and Bing Liu, ``Mining and summarizing customer reviews.'',
#' Proceedings of the ACM SIGKDD International Conference on Knowledge Discovery
#' & Data Mining (KDD-2004), Seattle, Washington, USA, Aug 22-25, 2004.
#'
#' Words with non-ASCII characters were removed.
#'
#' @format A data frame with 6,786 rows and 2 variables:
#' \describe{
#'  \item{word}{An English word}
#'  \item{sentiment}{A sentiment for that word, either positive or negative.}
#' }
#'
#'
#' @source \url{https://www.cs.uic.edu/~liub/FBS/sentiment-analysis.html}
"sentiments"


#' Get a tidy data frame of a single sentiment lexicon
#'
#' Get specific sentiment lexicons in a tidy format, with one row per word,
#' in a form that can be joined with a one-word-per-row dataset.
#' The \code{"bing"} option comes from the included \code{\link{sentiments}}
#' data frame, and others call the relevant function in the \pkg{textdata}
#' package.
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
#'
#' get_sentiments("bing")
#'
#' \dontrun{
#' get_sentiments("afinn")
#' get_sentiments("nrc")
#' }
#'
#' @export
get_sentiments <- function(lexicon = c("bing", "afinn", "loughran", "nrc")) {
  lexicon <- match.arg(lexicon)

  lexicon_names <- list(afinn    = "AFINN",
                        loughran = "Loughran-McDonald",
                        nrc      = "NRC word-emotion association")

  if (lexicon != "bing" && !requireNamespace("textdata", quietly = TRUE)) {
    msg <- "The textdata package is required to download the {lexicon_names[[lexicon]]} lexicon.\nInstall the textdata package to access this dataset."
    stop(stringr::str_glue(msg), call. = FALSE)
  }

  switch(
    lexicon,
    afinn    = textdata::lexicon_afinn(),
    nrc      = textdata::lexicon_nrc(),
    loughran = textdata::lexicon_loughran(),
    bing     = tidytext::sentiments,
    stop("Unexpected lexicon", call. = FALSE)
  )
}
