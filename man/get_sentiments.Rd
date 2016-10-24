% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sentiments.R
\name{get_sentiments}
\alias{get_sentiments}
\title{Get a tidy data frame of a single sentiment lexicon}
\usage{
get_sentiments(lexicon = c("afinn", "bing", "nrc"))
}
\value{
A tbl_df with a \code{word} column, and either a \code{sentiment}
column (if \code{lexicon} is "bing" or "nrc") or a numeric \code{score} column
(if \code{lexicon} is "afinn").
}
\description{
Get specific sentiment lexicons in a tidy format, with one row per word,
in a form that can be joined with a one-word-per-row dataset.
Each of these comes from the included \code{\link{sentiments}} data frame,
but this performs the filtering for a specific lexicon, and removes
columns that are not used in that lexicon.
}
\examples{

library(dplyr)
get_sentiments("afinn")
get_sentiments("bing")

}
