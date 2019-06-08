pkgname <- "TextForecast"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('TextForecast')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("get_collocations")
### * get_collocations

flush(stderr()); flush(stdout())

### Name: get_collocations
### Title: get_collocations function
### Aliases: get_collocations

### ** Examples

path_name=system.file("news",package="TextForecast")
days=c("2019-30-01","2019-31-01")
z_coll=get_collocations(corpus_dates=days[1],path_name=path_name,
ntrms=500,ngrams_number=3,min_freq=1)




cleanEx()
nameEx("get_terms")
### * get_terms

flush(stderr()); flush(stdout())

### Name: get_terms
### Title: Title
### Aliases: get_terms

### ** Examples

path_name=system.file("news",package="TextForecast")
days=c("2019-30-01","2019-31-01")
z_terms=get_terms(corpus_dates=days[1],path.name=path_name,
ntrms_words=500,ngrams_number=3,st=0,ntrms_collocation=500,min_freq=1)




cleanEx()
nameEx("get_words")
### * get_words

flush(stderr()); flush(stdout())

### Name: get_words
### Title: get_words function
### Aliases: get_words

### ** Examples

path_name=system.file("news",package="TextForecast")
days=c("2019-31-01","2019-31-01")
z_wrd=get_words(corpus_dates=days,path_name=path_name,ntrms=500,st=0)




cleanEx()
nameEx("hard_thresholding")
### * hard_thresholding

flush(stderr()); flush(stdout())

### Name: hard_thresholding
### Title: hard thresholding
### Aliases: hard_thresholding

### ** Examples

data("stock_data")
data("optimal_factors")
y=as.matrix(stock_data[,2])
y=as.vector(y)
w=as.matrix(stock_data[,3])
pc=as.matrix(optimal_factors)
t=length(y)
news_factor <- hard_thresholding(w=w[1:(t-1),],x=pc[1:(t-1),],y=y[2:t],p_value = 0.01,newx = pc)




cleanEx()
nameEx("optimal_alphas")
### * optimal_alphas

flush(stderr()); flush(stdout())

### Name: optimal_alphas
### Title: Title optimal alphas function
### Aliases: optimal_alphas

### ** Examples


set.seed(1)
data("stock_data")
data("news_data")
y=as.matrix(stock_data[1:200,2])
w=as.matrix(stock_data[1:200,3])
data("news_data")
X=news_data[1:200,2:ncol(news_data)]
x=as.matrix(X)
grid_alphas=seq(by=0.25,to=1,from=0.5)
cont_folds=TRUE
t=length(y)
optimal_alphas=optimal_alphas(x[1:(t-1),],
w[1:(t-1),],y[2:t],grid_alphas,TRUE,"gaussian")




cleanEx()
nameEx("optimal_number_factors")
### * optimal_number_factors

flush(stderr()); flush(stdout())

### Name: optimal_number_factors
### Title: optimal number of factors function
### Aliases: optimal_number_factors

### ** Examples

data("optimal_x")
optimal_factor <- optimal_number_factors(x=optimal_x,kmax=8)



cleanEx()
nameEx("text_forecast")
### * text_forecast

flush(stderr()); flush(stdout())

### Name: text_forecast
### Title: Text Forecast function
### Aliases: text_forecast

### ** Examples

set.seed(1)
data("stock_data")
data("news_data")
y=as.matrix(stock_data[,2])
w=as.matrix(stock_data[,3])
data("news_data")
data("optimal_factors")
pc=optimal_factors
z=cbind(w,pc)
fcsts=text_forecast(z,y,1,TRUE)



cleanEx()
nameEx("text_nowcast")
### * text_nowcast

flush(stderr()); flush(stdout())

### Name: text_nowcast
### Title: text nowcast
### Aliases: text_nowcast

### ** Examples

set.seed(1)
data("stock_data")
data("news_data")
y=as.matrix(stock_data[,2])
w=as.matrix(stock_data[,3])
data("news_data")
data("optimal_factors")
pc=optimal_factors
z=cbind(w,pc)
t=length(y)
ncsts=text_nowcast(z,y[1:(t-1)],TRUE)



cleanEx()
nameEx("tf_idf")
### * tf_idf

flush(stderr()); flush(stdout())

### Name: tf_idf
### Title: tf-idf function
### Aliases: tf_idf

### ** Examples

data("news_data")
X=as.matrix(news_data[,2:ncol(news_data)])
tf_idf_terms = tf_idf(X)



cleanEx()
nameEx("top_terms")
### * top_terms

flush(stderr()); flush(stdout())

### Name: top_terms
### Title: Top Terms Function
### Aliases: top_terms

### ** Examples





cleanEx()
nameEx("tv_dictionary")
### * tv_dictionary

flush(stderr()); flush(stdout())

### Name: tv_dictionary
### Title: tv dictionary function
### Aliases: tv_dictionary

### ** Examples


set.seed(1)
data("stock_data")
data("news_data")
y=as.matrix(stock_data[1:200,2])
w=as.matrix(stock_data[1:200,3])
data("news_data")
X=news_data[1:200,2:ncol(news_data)]
x=as.matrix(X)
grid_alphas=seq(by=0.5,to=1,from=0.5)
cont_folds=TRUE
t=length(y)
optimal_alphas=optimal_alphas(x[1:(t-1),],w[1:(t-1),],
y[2:t],grid_alphas,TRUE,"gaussian")
x_star=tv_dictionary(x=x[1:(t-1),],w=w[1:(t-1),],y=y[2:t],
alpha=optimal_alphas[1],lambda=optimal_alphas[2],newx=x,family="gaussian")




cleanEx()
nameEx("tv_sentiment_index")
### * tv_sentiment_index

flush(stderr()); flush(stdout())

### Name: tv_sentiment_index
### Title: tv sentiment index function
### Aliases: tv_sentiment_index

### ** Examples

suppressWarnings(RNGversion("3.5.0"))
set.seed(1)
data("stock_data")
data("news_data")
y=as.matrix(stock_data[,2])
w=as.matrix(stock_data[,3])
data("news_data")
X=news_data[,2:ncol(news_data)]
x=as.matrix(X)
grid_alphas=0.05
cont_folds=TRUE
t=length(y)
optimal_alphas=optimal_alphas(x[1:(t-1),],w[1:(t-1),],
y[2:t],grid_alphas,TRUE,"gaussian")
tv_index <- tv_sentiment_index(x[1:(t-1),],w[1:(t-1),],y[2:t],
optimal_alphas[[1]],optimal_alphas[[2]],x,"gaussian",2)




cleanEx()
nameEx("tv_sentiment_index_all_coefs")
### * tv_sentiment_index_all_coefs

flush(stderr()); flush(stdout())

### Name: tv_sentiment_index_all_coefs
### Title: TV sentiment index using all positive and negative coefficients.
### Aliases: tv_sentiment_index_all_coefs

### ** Examples

suppressWarnings(RNGversion("3.5.0"))
set.seed(1)
data("stock_data")
data("news_data")
y=as.matrix(stock_data[,2])
w=as.matrix(stock_data[,3])
data("news_data")
X=news_data[,2:ncol(news_data)]
x=as.matrix(X)
grid_alphas=0.05
cont_folds=TRUE
t=length(y)
optimal_alphas=optimal_alphas(x=x[1:(t-1),],
                              y=y[2:t],grid_alphas=grid_alphas,cont_folds=TRUE,family="gaussian")
tv_idx=tv_sentiment_index_all_coefs(x=x[1:(t-1),],y=y[2:t],alpha = optimal_alphas[1],
                                 lambda = optimal_alphas[2],newx=x,
                                 scaled = TRUE,k_mov_avg = 4,type_mov_avg = "s")



### * <FOOTER>
###
cleanEx()
options(digits = 7L)
base::cat("Time elapsed: ", proc.time() - base::get("ptime", pos = 'CheckExEnv'),"\n")
grDevices::dev.off()
###
### Local variables: ***
### mode: outline-minor ***
### outline-regexp: "\\(> \\)?### [*]+" ***
### End: ***
quit('no')
