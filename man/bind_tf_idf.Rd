% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/bind_tf_idf.R
\name{bind_tf_idf}
\alias{bind_tf_idf}
\title{Bind the term frequency and inverse document frequency of a tidy text
dataset to the dataset}
\usage{
bind_tf_idf(tbl, term, document, n)
}
\arguments{
\item{tbl}{A tidy text dataset with one-row-per-term-per-document}

\item{term}{Column containing terms as string or symbol}

\item{document}{Column containing document IDs as string or symbol}

\item{n}{Column containing document-term counts as string or symbol}
}
\description{
Calculate and bind the term frequency and inverse document frequency of a
tidy text dataset, along with the product, tf-idf, to the dataset. Each of
these values are added as columns. This function supports non-standard
evaluation through the tidyeval framework.
}
\details{
The arguments \code{term}, \code{document}, and \code{n}
are passed by expression and support \link[rlang:topic-inject]{quasiquotation};
you can unquote strings and symbols.

If the dataset is grouped, the groups are ignored but are
retained.

The dataset must have exactly one row per document-term combination
for this to work.
}
\examples{

library(dplyr)
library(janeaustenr)

book_words <- austen_books() |>
  unnest_tokens(word, text) |>
  count(book, word, sort = TRUE)

book_words

# find the words most distinctive to each document
book_words |>
  bind_tf_idf(word, book, n) |>
  arrange(desc(tf_idf))

}
