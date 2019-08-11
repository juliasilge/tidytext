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
#' \dontrun{
#' get_sentiments("afinn")
#' get_sentiments("nrc")
#' }
#' get_sentiments("bing")
#'
#' @importFrom utils data
#' @export
get_sentiments <- function(lexicon = c("afinn", "bing", "loughran", "nrc")) {
  data(list = "sentiments", package = "tidytext", envir = environment())
  lex <- match.arg(lexicon)

  if (lex == "afinn") {
    if (!requireNamespace("textdata", quietly = TRUE)){
      stop("The textdata package is required to download the AFINN lexicon. \nInstall the textdata package to access this dataset.",
        call. = FALSE
      )
    }
    return(textdata::lexicon_afinn())
  } else if (lex == "nrc") {
    if (!requireNamespace("textdata", quietly = TRUE)){
      stop("The textdata package is required to download the NRC word-emotion association lexicon. \nInstall the textdata package to access this dataset.",
           call. = FALSE
      )
    }
    return(textdata::lexicon_nrc())
  } else if (lex == "loughran") {
    if (!requireNamespace("textdata", quietly = TRUE)){
      stop("The textdata package is required to download the Loughran-McDonald lexicon. \nInstall the textdata package to access this dataset.",
           call. = FALSE
      )
    }
    return(textdata::lexicon_loughran())
  } else if (lex == "bing") {
    return(sentiments)
  }

}
