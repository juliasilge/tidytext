#' Count pairs of items that cooccur within a group
#'
#' Count the number of times pairs of items cooccur within a group.
#' This returns a table with one row for each word-word pair that
#' occurs within a group, along with \code{n}, the number of groups
#' the pair cooccurs in. \code{pair_count_} is the standard-evaluation
#' version that can be programmed with.
#'
#' @param data A tbl
#' @param group,group_col Column to count pairs within
#' @param value,value_col Column containing values to count pairs of
#' @param unique_pair Whether to have only one pair of value1 and
#' value2. Setting this to FALSE is useful if you want to afterwards
#' find the most common values paired with one of interest.
#' @param self Whether to include an item as co-occuring with itself
#' @param sort Whether to sort in decreasing order of frequency
#'
#' @return A data frame with three columns: \code{value1}, \code{value2},
#' and \code{n}.
#'
#' @examples
#'
#' library(janeaustenr)
#' library(dplyr)
#'
#' pride_prejudice_words <- data_frame(text = prideprejudice) %>%
#'   mutate(line = row_number()) %>%
#'   unnest_tokens(word, text) %>%
#'   anti_join(stop_words)
#'
#' # find words that co-occur within lines
#' pride_prejudice_words %>%
#'   pair_count(line, word, sort = TRUE)
#'
#' # when finding words most often occuring with a particular word,
#' # use unique_pair = FALSE
#' pride_prejudice_words %>%
#'   pair_count(line, word, sort = TRUE, unique_pair = FALSE) %>%
#'   filter(value1 == "elizabeth")
#'
#' @export
pair_count <- function(data, group, value, unique_pair = TRUE,
                       self = FALSE, sort = FALSE) {
  group_col <- col_name(substitute(group))
  value_col <- col_name(substitute(value))
  pair_count_(data, group_col, value_col, unique_pair = unique_pair,
           self = self, sort = sort)
}


#' @rdname pair_count
#' @export
pair_count_ <- function(data, group_col, value_col,
                        unique_pair = TRUE,
                        self = FALSE,
                        sort = FALSE) {
  requireNamespace("Matrix")

  value_vals <- unique(data[[value_col]])
  value_indices <- match(data[[value_col]], value_vals)
  data[[".value_indices"]] <- value_indices

  sparse_mat <- cast_sparse_(data, group_col, ".value_indices", value_col = 1)
  co <- t(sparse_mat) %*% sparse_mat
  matrix_indices <- as.integer(rownames(co))

  # turn into i, j, x triplets
  triplets <- Matrix::summary(co)

  if (unique_pair) {
    triplets <- filter(triplets, i <= j)
  }
  if (!self) {
    triplets <- filter(triplets, i != j)
  }

  ret <- triplets %>%
    transmute(value1 = value_vals[matrix_indices[i]],
              value2 = value_vals[matrix_indices[j]],
              n = x) %>%
    tbl_df()

  if (sort) {
    ret <- arrange(ret, desc(n))
  }

  ret
}
