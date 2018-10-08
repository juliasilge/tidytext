## create the dictionary objects

require(quanteda)

data_dictionary_LSD2015 <- dictionary(file = "~/Dropbox/QUANTESS/dictionaries/Lexicoder/LSDaug2015/LSD2015.lc3")
data_dictionary_LSD2015neg <- dictionary(file = "~/Dropbox/QUANTESS/dictionaries/Lexicoder/LSDaug2015/LSD2015_NEG.lc3")
lengths(data_dictionary_LSD2015)
lengths(temp_dict)

# combine
temp <- dictionary(c(as.list(data_dictionary_LSD2015), as.list(temp_dict)))
names(temp) <- c("negative", "positive", "neg_positive", "neg_negative")

data_dictionary_LSD2015 <- temp
lengths(data_dictionary_LSD2015)

devtools::use_data(data_dictionary_LSD2015, overwrite = TRUE)


