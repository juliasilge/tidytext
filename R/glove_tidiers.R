#' Tidy glove word-to-vector fits
#'
#' Tidy glove word-to-vector fits from the text2vec package
#'
#' @param x A text2vec_glove_fit object, such as returned from the
#' \code{\link[text2vec]{glove}} function.
#' @param ... Extra arguments, not used
#'
#' @rdname glove_tidiers
#' @export
tidy.text2vec_glove_fit <- function(x, terms = NULL) {
  w_i <- x$word_vectors[[1]]

  # if terms are given, use them
  rownames(w_i) <- terms

  ret <- w_i %>%
    reshape2::melt(w_i, varnames = c("term", "index"), value.name = "wi", as.is = TRUE) %>%
    tbl_df()
  ret$wj <- c(x$word_vectors[[2]])
  ret$value <- ret$wi + ret$wj

  ret
}
