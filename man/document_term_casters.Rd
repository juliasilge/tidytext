% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sparse_casters.R
\name{cast_tdm}
\alias{cast_tdm}
\alias{cast_dtm}
\alias{cast_dfm}
\title{Casting a data frame to
a DocumentTermMatrix, TermDocumentMatrix, or dfm}
\usage{
cast_tdm(data, term, document, value, weighting = tm::weightTf, ...)

cast_dtm(data, document, term, value, weighting = tm::weightTf, ...)

cast_dfm(data, document, term, value, ...)
}
\arguments{
\item{data}{Table with one-term-per-document-per-row}

\item{term}{Column containing terms as string or symbol}

\item{document}{Column containing document IDs as string or symbol}

\item{value}{Column containing values as string or symbol}

\item{weighting}{The weighting function for the DTM/TDM
(default is term-frequency, effectively unweighted)}

\item{...}{Extra arguments passed on to
\code{\link[Matrix:sparseMatrix]{Matrix::sparseMatrix()}}}
}
\description{
This turns a "tidy" one-term-per-document-per-row data frame into a
DocumentTermMatrix or TermDocumentMatrix from the tm package, or a
dfm from the quanteda package. These functions support non-standard
evaluation through the tidyeval framework. Groups are ignored.
}
\details{
The arguments \code{term}, \code{document}, and \code{value}
are passed by expression and support \link[rlang:topic-inject]{quasiquotation};
you can unquote strings and symbols.
}
