context("test default methods for nice error messages")

test_that("test detault corpus* methods", {
    expect_error(
        corpus(TRUE),
        "corpus\\(\\) only works on.*character.*corpus.*objects"
    )   
    expect_error(
        as.corpus(c(1, 2, 3)),
        "as.corpus\\(\\) only works on.*corpuszip"
    )   
    expect_error(
        corpus_reshape(1),
        "corpus_reshape\\(\\) only works on corpus objects"
    )
    expect_error(
        corpus_sample(1),
        "corpus_sample\\(\\) only works on corpus objects"
    )    
    expect_error(
        corpus_segment(1),
        "corpus_segment\\(\\) only works on corpus objects"
    )
    expect_error(
        corpus_subset(1),
        "corpus_subset\\(\\) only works on corpus objects"
    )
})

test_that("test detault n-methods", {
    expect_error(
        ndoc(TRUE),
        "ndoc\\(\\) only works on.*corpus.*tokens.*objects"
    )
    expect_error(
        nfeat(TRUE),
        "nfeat\\(\\) only works on dfm.*objects"
    )    
    expect_error(
        nscrabble(TRUE),
        "nscrabble\\(\\) only works on character.*objects"
    )
    expect_error(
        nsentence(TRUE),
        "nsentence\\(\\) only works on.*corpus.*tokens objects"
    )
    expect_error(
        nsyllable(TRUE),
        "nsyllable\\(\\) only works on character, tokens objects"
    )
    expect_error(
        ntoken(TRUE),
        "ntoken\\(\\) only works on character.*tokens objects"
    )
    expect_error(
        ntype(TRUE),
        "ntype\\(\\) only works on character.*tokens objects"
    )
})

test_that("test detault char_* methods", {
    expect_error(
        char_ngrams(1),
        "char_ngrams\\(\\) only works on character objects"
    )
    expect_error(
        char_segment(1),
        "char_segment\\(\\) only works on character objects"
    )    
    expect_error(
        char_tolower(1),
        "char_tolower\\(\\) only works on character objects"
    )
    expect_error(
        char_toupper(1),
        "char_toupper\\(\\) only works on character objects"
    )
    expect_error(
        char_wordstem(1),
        "char_wordstem\\(\\) only works on character objects"
    )
})

test_that("test detault fcm* methods", {
    expect_error(
        fcm(0),
        "fcm\\(\\) only works on character.*tokens objects"
    )   
    expect_error(
        fcm_compress(1),
        "fcm_compress\\(\\) only works on fcm objects"
    )
    expect_error(
        fcm_keep(1),
        "fcm_keep\\(\\) only works on fcm objects"
    )    
    expect_error(
        fcm_remove(1),
        "fcm_remove\\(\\) only works on fcm objects"
    )
    expect_error(
        fcm_select(1),
        "fcm_select\\(\\) only works on fcm objects"
    )
    expect_error(
        fcm_sort(1),
        "fcm_sort\\(\\) only works on fcm objects"
    )
    expect_error(
        fcm_tolower(1),
        "fcm_tolower\\(\\) only works on fcm objects"
    )
    expect_error(
        fcm_toupper(1),
        "fcm_toupper\\(\\) only works on fcm objects"
    )
})

test_that("test default docvars methods", {
    expect_error(
        docvars(0),
        "docvars\\(\\) only works on.*corpus.*tokens objects"
    )   
    expect_error(
        docvars(data_char_sampletext) <- "X",
        "docvars<-\\(\\) only works on.*corpus.*tokens objects"
    )
})

test_that("test default metadoc methods", {
    expect_error(
        metadoc(0),
        "metadoc\\(\\) only works on.*corpus.*tokens objects"
    )   
    expect_error(
        metadoc(data_char_sampletext) <- "X",
        "metadoc<-\\(\\) only works on corpus objects"
    )
})

test_that("test default metacorpus method", {
    expect_error(
        metacorpus(0),
        "metacorpus\\(\\) only works on corpus objects"
    )   
    expect_error(
        metacorpus(data_char_sampletext) <- "X",
        "metacorpus<-\\(\\) only works on corpus objects"
    )
})

test_that("kwic default works", {
    expect_error(
        kwic(TRUE),
        "kwic\\(\\) only works on character, corpus, tokens objects"
    )
})

test_that("phrase default works", {
    expect_error(
        phrase(TRUE),
        "phrase\\(\\) only works on character.*tokens objects"
    )
})

test_that("types defaults work", {
    expect_error(
        types(TRUE),
        "types\\(\\) only works on tokens objects"
    )
    # expect_error(
    #     quanteda:::types(data_char_sampletext) <- c("a", "b"),
    #     "types<-\\(\\) only works on tokens objects"
    # )
})

test_that("test new bootstrap_dfm methods", {
    expect_error(
        bootstrap_dfm(TRUE),
        "bootstrap_dfm\\(\\) only works on character.*dfm.*objects"
    )   
})

test_that("test new convert methods", {
    expect_error(
        convert(TRUE),
        "convert\\(\\) only works on .*dfm.*objects"
    )   
})

test_that("test new dfm methods", {
    expect_error(
        dfm(TRUE),
        "dfm\\(\\) only works on character.*corpus.*tokens.*objects"
    )
    expect_error(
        dfm_compress(TRUE),
        "dfm_compress\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_group(TRUE),
        "dfm_group\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_keep(TRUE),
        "dfm_select\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_lookup(TRUE),
        "dfm_lookup\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_remove(TRUE),
        "dfm_select\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_sample(TRUE),
        "dfm_sample\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_select(TRUE),
        "dfm_select\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_smooth(TRUE),
        "dfm_smooth\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_sort(TRUE),
        "dfm_sort\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_subset(TRUE),
        "dfm_subset\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_tolower(TRUE),
        "dfm_tolower\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_toupper(TRUE),
        "dfm_toupper\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_trim(TRUE),
        "dfm_trim\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_weight(TRUE),
        "dfm_weight\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_wordstem(TRUE),
        "dfm_wordstem\\(\\) only works on dfm objects"
    )
    expect_error(
        dfm_tfidf(TRUE),
        "dfm_tfidf\\(\\) only works on dfm objects"
    )
    # expect_error(
    #     tf(TRUE),
    #     "tf\\(\\) only works on dfm objects"
    # )
    expect_error(
        docfreq(TRUE),
        "docfreq\\(\\) only works on dfm objects"
    )
})

test_that("test token default methods", {
    expect_error(
        as.tokens(c(1, 2, 3)),
        "as.tokens\\(\\) only works on.*list"
    )   
    expect_error(
        tokens(TRUE),
        "tokens\\(\\) only works on character, corpus, tokens objects"
    )   
    expect_error(
        tokens_compound(TRUE),
        "tokens_compound\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_keep(TRUE),
        "tokens_select\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_lookup(TRUE),
        "tokens_lookup\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_ngrams(TRUE),
        "tokens_ngrams\\(\\) only works on.*tokens objects"
    )
    expect_error(
        tokens_remove(TRUE),
        "tokens_select\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_replace(TRUE),
        "tokens_replace\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_select(TRUE),
        "tokens_select\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_skipgrams(TRUE),
        "tokens_skipgrams\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_tolower(TRUE),
        "tokens_tolower\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_toupper(TRUE),
        "tokens_toupper\\(\\) only works on tokens objects"
    )
    expect_error(
        tokens_wordstem(TRUE),
        "tokens_wordstem\\(\\) only works on tokens objects"
    )
})

test_that("test new as.dfm methods", {
    expect_error(
        as.dfm(TRUE),
        "as\\.dfm\\(\\) only works on.*data\\.frame.*dfm.*matrix.*objects"
    )   
})

test_that("test sparsity default", {
    expect_error(
        sparsity(TRUE),
        "sparsity\\(\\) only works on dfm objects"
    )   
})

test_that("test topfeatures default", {
    expect_error(
        topfeatures(TRUE),
        "topfeatures\\(\\) only works on dfm objects"
    )   
})

test_that("test new as.dictionary methods", {
    expect_error(
        as.dictionary(TRUE),
        "as\\.dictionary\\(\\) only works on data\\.frame objects"
    )   
})

test_that("test new docnames methods", {
    expect_error(
        docnames(0),
        "docnames\\(\\) only works on.*corpus.*tokens objects"
    )   
})

test_that("test new docnames<- methods", {
    expect_error(
        docnames(data_char_sampletext) <- "X",
        "docnames<-\\(\\) only works on.*corpus.*tokens objects"
    )   
})

test_that("test default textmodel methods", {
    expect_error(
        textmodel_affinity(TRUE, FALSE),
        "textmodel_affinity\\(\\) only works on dfm.*objects"
    )   
    expect_error(
        textmodel_ca(TRUE),
        "textmodel_ca\\(\\) only works on dfm.*objects"
    )
    expect_error(
        textmodel_nb(TRUE),
        "textmodel_nb\\(\\) only works on dfm.*objects"
    )
    expect_error(
        textmodel_wordfish(TRUE),
        "textmodel_wordfish\\(\\) only works on dfm.*objects"
    )
    expect_error(
        textmodel_wordscores(TRUE),
        "textmodel_wordscores\\(\\) only works on dfm.*objects"
    )
})

test_that("test default textstat methods", {
    expect_error(
        textstat_dist(TRUE),
        "textstat_dist\\(\\) only works on dfm objects"
    )   
    expect_error(
        textstat_frequency(TRUE),
        "textstat_frequency\\(\\) only works on dfm objects"
    )   
    expect_error(
        textstat_keyness(TRUE),
        "textstat_keyness\\(\\) only works on dfm objects"
    )   
    expect_error(
        textstat_lexdiv(TRUE),
        "textstat_lexdiv\\(\\) only works on dfm objects"
    )   
    expect_error(
        textstat_readability(TRUE),
        "textstat_readability\\(\\) only works on character, corpus objects"
    )   
    expect_error(
        textstat_simil(TRUE),
        "textstat_simil\\(\\) only works on dfm objects"
    )   
    expect_error(
        textstat_collocations(TRUE),
        "textstat_collocations\\(\\) only works on.*tokens objects"
    )
})

test_that("test default textplot methods", {
    expect_error(
        textplot_influence(TRUE),
        "textplot_influence\\(\\) only works on influence\\..*textmodel_affinity objects"
    )   
    expect_error(
        textplot_keyness(TRUE),
        "textplot_keyness\\(\\) only works on keyness objects"
    )   
    expect_error(
        textplot_scale1d(TRUE),
        "textplot_scale1d\\(\\) only works on predict\\.textmodel.*objects"
    )   
    expect_error(
        textplot_wordcloud(TRUE),
        "textplot_wordcloud\\(\\) only works on dfm objects"
    )   
    expect_error(
        textplot_xray(TRUE),
        "textplot_xray\\(\\) only works on kwic objects"
    )   
})
