#' Set up dataset in the data/ folder
#'
#' This is run by package authors to set up all the datasets in data/.
setup_data <- function() {
  SMART <- data_frame(word = tm::stopwords("SMART"), lexicon = "SMART")
  snowball <- data_frame(word = tm::stopwords("en"), lexicon = "snowball")
  onix <- data_frame(word = qdapDictionaries::OnixTxtRetToolkitSWL1, lexicon = "onix")

  stopwords <- bind_rows(SMART, snowball, onix)

  devtools::use_data(stopwords, overwrite = TRUE)

  # parts of speech
  moby_file <- system.file("extdata", "mobyposi.i", package = "tidytext")
  mobypos <- readr::read_delim(moby_file, delim = "\xd7", ) %>%
    tidyr::unnest(pos = str_split(AN, ""))
}
