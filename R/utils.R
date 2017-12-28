#' Supported dictionaries
#'
#' Get the hunspell dictionaries supported natively in \pkg{tidytext}.
#' These dictionaries were downloaded from \url{https://github.com/titoBouzout/Dictionaries}
#'
#' @importFrom purrr map_chr
#'
#' @export

supported_dictionaries <- function(){
  map_chr(list.files(system.file("extdata/", package = "tidytext"), pattern = "aff"),
          ~ gsub("(.*)\\..*", "\\1", .x))
}
