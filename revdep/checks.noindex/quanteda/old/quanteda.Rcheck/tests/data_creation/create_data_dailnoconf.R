## Dail no confidence debates

library("readtext")

data_readtext_dailnoconf1991 <- 
    readtext("tests/data/Dail_noconfidence.zip", encoding = "ISO-8859-1", verbosity = 0)
docvars <- 
    stringi::stri_replace_all_regex(rownames(data_readtext_dailnoconf1991), 
                                    "^v{0,1}(.*)\\.txt$",
                                    "$1") %>%
    stringi::stri_split_fixed("_") 

docvars <- data.frame(do.call(rbind, docvars))
names(docvars) <- c("name", "party", "position")
    
data_corpus_dailnoconf1991 <- corpus(data_readtext_dailnoconf1991,
                                     metacorpus(list(source = "LBG (2003)")))

docvars(data_corpus_dailnoconf1991) <- docvars

