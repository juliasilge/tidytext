#' Set up dataset in the data/ folder
#'
#' This is run by package authors to set up all the datasets in data/.
setup_data <- function() {
  SMART <- data_frame(word = tm::stopwords("SMART"), lexicon = "SMART")
  snowball <- data_frame(word = tm::stopwords("en"), lexicon = "snowball")
  onix <- data_frame(word = qdapDictionaries::OnixTxtRetToolkitSWL1, lexicon = "onix")

  stopwords <- bind_rows(SMART, snowball, onix)

  devtools::use_data(stopwords, overwrite = TRUE)

  parts_of_speech <- readr::read_csv("Noun,N
Plural,p
Noun Phrase,h
Verb (usu participle),V
Verb (transitive),t
Verb (intransitive),i
Adjective,A
Adverb,v
Conjunction,C
Preposition,P
Interjection,!
Pronoun,r
Definite Article,D
Indefinite Article,I
Nominative,o
", col_names = c("pos", "code"))

  # parts of speech
  moby_file <- system.file("extdata", "mobyposi.i", package = "tidytext")
  partsofspeech <- readr::read_delim(moby_file, delim = "\xd7",
                               col_names = c("word", "code")) %>%
    tidyr::unnest(code = str_split(code, "")) %>%
    inner_join(parts_of_speech, by = "code") %>%
    mutate(word = str_to_lower(word)) %>%
    distinct()

  devtools::use_data(partsofspeech, overwrite = TRUE)
}
