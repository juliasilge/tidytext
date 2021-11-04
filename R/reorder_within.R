#' Reorder an x or y axis within facets
#'
#' Reorder a column before plotting with faceting, such that the values are
#' ordered within each facet. This requires two functions: \code{reorder_within}
#' applied to the column, then either \code{scale_x_reordered} or
#' \code{scale_y_reordered} added to the plot.
#' This is implemented as a bit of a hack: it appends ___ and then the facet
#' at the end of each string.
#'
#' @param x Vector to reorder.
#' @param by Vector of the same length, to use for reordering.
#' @param within Vector or list of vectors of the same length that will later
#' be used for faceting. A list of vectors will be used to facet within multiple
#' variables.
#' @param fun Function to perform within each subset to determine the resulting
#' ordering. By default, mean.
#' @param labels Function to transform the labels of
#' [ggplot2::scale_x_discrete()], by default `reorder_func`.
#' @param sep Separator to distinguish `by` and `within`. You may want to set this
#' manually if ___ can exist within one of your labels.
#' @param ... In \code{reorder_within} arguments passed on to
#' \code{\link{reorder}}. In the scale functions, extra arguments passed on to
#' \code{\link[ggplot2]{scale_x_discrete}} or \code{\link[ggplot2]{scale_y_discrete}}.
#'
#' @source "Ordering categories within ggplot2 Facets" by Tyler Rinker:
#' \url{https://trinkerrstuff.wordpress.com/2016/12/23/ordering-categories-within-ggplot2-facets/}
#'
#' @examples
#'
#' library(tidyr)
#' library(ggplot2)
#'
#' iris_gathered <- gather(iris, metric, value, -Species)
#'
#' # reordering doesn't work within each facet (see Sepal.Width):
#' ggplot(iris_gathered, aes(reorder(Species, value), value)) +
#'   geom_boxplot() +
#'   facet_wrap(~ metric)
#'
#' # reorder_within and scale_x_reordered work.
#' # (Note that you need to set scales = "free_x" in the facet)
#' ggplot(iris_gathered, aes(reorder_within(Species, value, metric), value)) +
#'   geom_boxplot() +
#'   scale_x_reordered() +
#'   facet_wrap(~ metric, scales = "free_x")
#'
#' # to reorder within multiple variables, set within to the list of
#' # facet variables.
#' ggplot(mtcars, aes(reorder_within(carb, mpg, list(vs, am)), mpg)) +
#'   geom_boxplot() +
#'   scale_x_reordered() +
#'   facet_wrap(vs ~ am, scales = "free_x")
#'
#' @importFrom lifecycle deprecated
#' @export
reorder_within <- function(x, by, within, fun = mean, sep = "___", ...) {
  if (!is.list(within)) {
    within <- list(within)
  }

  new_x <- do.call(paste, c(list(x, sep = sep), within))
  stats::reorder(new_x, by, FUN = fun)
}


#' @rdname reorder_within
#' @export
scale_x_reordered <- function(..., labels = reorder_func, sep = deprecated()) {

  if (lifecycle::is_present(sep)) {
    lifecycle::deprecate_soft(
      "0.3.3",
      "scale_x_reordered(sep = )",
      "reorder_func(sep = )"
    )
  }

  ggplot2::scale_x_discrete(labels = labels, ...)
}


#' @rdname reorder_within
#' @export
scale_y_reordered <- function(..., labels = reorder_func, sep = deprecated()) {

  if (lifecycle::is_present(sep)) {
    lifecycle::deprecate_soft(
      "0.3.3",
      "scale_y_reordered(sep = )",
      "reorder_func(sep = )"
    )
  }

  ggplot2::scale_y_discrete(labels = labels, ...)
}

#' @rdname reorder_within
#' @export
reorder_func <- function(x, sep = "___") {
  reg <- paste0(sep, ".+$")
  gsub(reg, "", x)
}

