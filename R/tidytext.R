#' @keywords internal
"_PACKAGE"

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
