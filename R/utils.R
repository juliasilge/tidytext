#' Supported languages
#'
#' Get the languages supported by the parser.
#' These dictionaries were downloaded from \url{https://github.com/titoBouzout/Dictionaries}
#'
#' @importFrom purrr map_chr
#'
#' @export

supported_languages <- function(){
  c("english",
        map_chr(list.files(system.file("extdata/", package = "tidytext"), pattern = "aff"),
      ~ gsub("(.*)\\..*", "\\1", .x)),
    "custom"
  )
}

# The function are from the tokenizers package, but not exported.

tokenizers_check_input <- getFromNamespace("check_input", "tokenizers")

tokenizers_simplify_list <- getFromNamespace("simplify_list", "tokenizers")

tokenizers_skip_ngrams <- getFromNamespace("skip_ngrams", "tokenizers")

tokenizers_generate_ngrams_batch <- getFromNamespace("generate_ngrams_batch", "tokenizers")
