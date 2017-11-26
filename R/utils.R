#' Supported languages
#'
#' Get the languages supported by the parser
#'
#' @importFrom purrr map_chr
#'
#' @export

supported_languages <- function(){
  c("english",
        map_chr(list.files(system.file("extdata/", package = "tidytext"), pattern = "dic"),
      ~ gsub("(.*)\\..*", "\\1", .x))
  )
}
