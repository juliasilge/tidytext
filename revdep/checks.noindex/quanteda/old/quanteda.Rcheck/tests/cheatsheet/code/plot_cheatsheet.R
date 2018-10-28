# Plots for the quanteda cheatsheet

library(quanteda)
library(ggplot2)

###
# Wordcloud
###

set.seed(3)
pdf(file = "plots/textplot_wordcloud.pdf", width = 5, height = 5)
textplot_wordcloud(dfm(corpus_subset(data_corpus_inaugural,
                                     President=="Obama"), remove = stopwords("english"),
                       remove_punct = TRUE), max_words = 50)
dev.off()

###
# X-Ray Plot
###

textplot_xray(kwic(corpus_subset(data_corpus_inaugural, Year > 2000), "american"))
ggsave("plots/textplot_xray.pdf", width = 4, height = 3)

###
# Keyness plot
###

pres_dfm <- dfm(corpus_subset(data_corpus_inaugural, 
                              President %in% c("Obama", "Trump")), 
                groups = "President", 	remove = stopwords("english"), 
                remove_punct = TRUE) 

data_corpus_inaugural %>%   
    corpus_subset(President %in% 
                      c("Obama", "Trump")) %>%
    dfm(groups = "President", 
        remove = stopwords("english")) %>%   
    textstat_keyness(target = "Trump") %>%   
    textplot_keyness(n = 10)
ggsave("plots/textplot_keyness.pdf", width = 8, height = 5)

###
# Wordscores plot
###
           
ie_dfm <- dfm(data_corpus_irishbudget2010)
doclab <- apply(docvars(data_corpus_irishbudget2010, c("name", "party")), 
                1, paste, collapse = " ")

refscores <- c(rep(NA, 4), -1, 1, rep(NA, 8))
ws <- textmodel_wordscores(ie_dfm, refscores, smooth = 1)
pred <- predict(ws, se.fit = TRUE)

# plot estimated word positions
textplot_scale1d(ws, margin = "features", 
                 highlighted = c("minister", "have", "our", "budget"))

# plot estimated document positions
textplot_scale1d(pred, margin = "documents",
                 doclabels = doclab,
                 groups = docvars(data_corpus_irishbudget2010, "party"))
ggsave("plots/textplot_scale1d.pdf", width = 4.2, height = 3)

