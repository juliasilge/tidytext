#' tidytext: Text Mining using 'dplyr', 'ggplot2', and Other Tidy Tools
#'
#' This package implements tidy data principles to make many text mining tasks easier,
#' more effective, and consistent with tools already in wide use.
#'
#' Much of the infrastructure needed for text mining with tidy data frames
#' already exists in packages like dplyr, broom, tidyr and ggplot2.
#'
#' In this package, we provide functions and supporting data sets to allow conversion
#' of text to and from tidy formats, and to switch seamlessly between tidy tools
#' and existing text mining packages.
#'
#' To learn more about tidytext, start with the vignettes:
#'  \code{browseVignettes(package = "tidytext")}
#' @docType package
#' @name tidytext
NULL

#' Deprecated SE version of functions
#'
#' tidytext used to offer twin versions of each verb suffixed with an
#' underscore, like dplyr and the main tidyverse packages. These
#' versions had standard evaluation (SE) semantics; rather than taking
#' arguments by code, like NSE verbs, they took arguments by value.
#' Their purpose was to make it possible to program with tidytext.
#' However, tidytext now uses tidy evaluation semantics. NSE verbs
#' still capture their arguments, but you can now unquote parts of
#' these arguments. This offers full programmability with NSE verbs.
#' Thus, the underscored versions are now superfluous.
#'
#' Unquoting triggers immediate evaluation of its operand and inlines
#' the result within the captured expression. This result can be a
#' value or an expression to be evaluated later with the rest of the
#' argument.
#'
#' @name deprecated-se
#' @keywords internal
NULL
