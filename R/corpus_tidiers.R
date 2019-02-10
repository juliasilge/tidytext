#' Tidy a Corpus object from the tm package
#'
#' Tidy a Corpus object from the tm package. Returns a data frame
#' with one-row-per-document, with a \code{text} column containing
#' the document's text, and one column for each local (per-document)
#' metadata tag. For corpus objects from the quanteda package,
#' see \code{\link{tidy.corpus}}.
#'
#' @param x A Corpus object, such as a VCorpus or PCorpus
#' @param collapse A string that should be used to
#' collapse text within each corpus (if a document has multiple lines).
#' Give NULL to not collapse strings, in which case a corpus
#' will end up as a list column if there are multi-line documents.
#' @param ... Extra arguments, not used
#'
#' @examples
#'
#' library(dplyr)   # displaying tbl_dfs
#'
#' if (requireNamespace("tm", quietly = TRUE)) {
#'   library(tm)
#'   #' # tm package examples
#'   txt <- system.file("texts", "txt", package = "tm")
#'   ovid <- VCorpus(DirSource(txt, encoding = "UTF-8"),
#'                   readerControl = list(language = "lat"))
#'
#'   ovid
#'   tidy(ovid)
#'
#'   # choose different options for collapsing text within each
#'   # document
#'   tidy(ovid, collapse = "")$text
#'   tidy(ovid, collapse = NULL)$text
#'
#'   # another example from Reuters articles
#'   reut21578 <- system.file("texts", "crude", package = "tm")
#'   reuters <- VCorpus(DirSource(reut21578),
#'                      readerControl = list(reader = readReut21578XMLasPlain))
#'   reuters
#'
#'   tidy(reuters)
#' }
#'
#' @export
tidy.Corpus <- function(x, collapse = "\n", ...) {
  local_meta <- NLP::meta(x, type = "local") %>%
    purrr::transpose()

  columns <- purrr::map(local_meta, function(m) {
    lengths <- purrr::map_dbl(m, length)
    if (any(lengths > 1)) {
      # keep as a list column
      return(m)
    }
    m <- purrr::map_at(m, which(lengths == 0), ~ NA)

    ret <- unname(do.call(c, m))
    ## tbl_df() doesn't support POSIXlt format
    ## https://github.com/hadley/dplyr/issues/1382
    if (inherits(ret, "POSIXlt")) {
      ret <- as.POSIXct(ret)
    }
    ret
  })

  ret <- as_tibble(columns)

  # most importantly, add text
  text <- purrr::map(as.list(x), as.character)

  if (all(purrr::map(text, length) == 1)) {
    text <- unlist(text)
  } else if (!is.null(collapse)) {
    text <- purrr::map_chr(text, stringr::str_c, collapse = collapse)
  }
  ret$text <- text

  ret
}


#' Tidiers for a corpus object from the quanteda package
#'
#' Tidy a corpus object from the quanteda package. \code{tidy} returns a
#' tbl_df with one-row-per-document, with a \code{text} column containing
#' the document's text, and one column for each document-level metadata.
#' \code{glance} returns a one-row tbl_df with corpus-level metadata,
#' such as source and created. For Corpus objects from the tm package,
#' see \code{\link{tidy.Corpus}}.
#'
#' @param x A Corpus object, such as a VCorpus or PCorpus
#' @param ... Extra arguments, not used
#'
#' @importFrom generics glance
#'
#' @details For the most part, the \code{tidy} output is equivalent to the
#' "documents" data frame in the corpus object, except that it is converted
#' to a tbl_df, and \code{texts} column is renamed to \code{text}
#' to be consistent with other uses in tidytext.
#'
#' Similarly, the \code{glance} output is simply the "metadata" object,
#' with NULL fields removed and turned into a one-row tbl_df.
#'
#' @examples
#'
#' if (requireNamespace("quanteda", quietly = TRUE)) {
#'  data("data_corpus_inaugural", package = "quanteda")
#'
#'  data_corpus_inaugural
#'
#'  tidy(data_corpus_inaugural)
#' }
#'
#' @name corpus_tidiers
#'
#' @export
tidy.corpus <- function(x, ...) {
  dplyr::tbl_df(data.frame(
    text = quanteda::texts(x),
    quanteda::docvars(x),
    stringsAsFactors = FALSE
  ))
}


#' @rdname corpus_tidiers
#' @export
glance.corpus <- function(x, ...) {
  md <- purrr::compact(quanteda::metacorpus(x))

  # turn vectors into list columns
  md <- purrr::map_if(md, ~ length(.) > 1, list)

  as_tibble(md)
}

#' @export
generics::glance
