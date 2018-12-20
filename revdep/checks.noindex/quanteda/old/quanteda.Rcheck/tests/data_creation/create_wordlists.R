makeWordList <- function(filename) {
    wordList <- readtext(filename, cache = FALSE)@texts
    wordList <- stringi::stri_replace_all_regex(wordList, "-", "_")
    wordList <- tokens(wordList, simplify = TRUE)
    wordList <- stringi::stri_replace_all_regex(wordList, "_", "-")
    wordList
}
dalechall    <- makeWordList("~/Dropbox/QUANTESS/quanteda_working_files/readability/Dale-Chall.txt")
spache    <- makeWordList("~/Dropbox/QUANTESS/quanteda_working_files/readability/Spache.txt")
wordlists <- list(dalechall = dalechall, spache = spache)
devtools::use_data(wordlists)
