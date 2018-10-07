pkgname <- "rzeit2"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('rzeit2')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("get_article_text")
### * get_article_text

flush(stderr()); flush(stdout())

### Name: get_article_text
### Title: Get article text
### Aliases: get_article_text

### ** Examples

url <- paste0("https://www.zeit.de/kultur/film/2018-04/",
"tatort-frankfurt-unter-kriegern-obduktionsbericht")
get_article_text(url = url)




cleanEx()
nameEx("get_client")
### * get_client

flush(stderr()); flush(stdout())

### Name: get_client
### Title: Client status and API usage
### Aliases: get_client

### ** Examples

## Not run: 
##D get_client()
## End(Not run)




cleanEx()
nameEx("get_content")
### * get_content

flush(stderr()); flush(stdout())

### Name: get_content
### Title: Content endpoint
### Aliases: get_content

### ** Examples

## Not run: 
##D get_content(query = "Merkel")
## End(Not run)




cleanEx()
nameEx("get_content_all")
### * get_content_all

flush(stderr()); flush(stdout())

### Name: get_content_all
### Title: Content endpoint (all)
### Aliases: get_content_all

### ** Examples

## Not run: 
##D get_content(query = "Merkel")
##D  
## End(Not run)




cleanEx()
nameEx("set_api_key")
### * set_api_key

flush(stderr()); flush(stdout())

### Name: set_api_key
### Title: Set api key to the .Renviron
### Aliases: set_api_key

### ** Examples

## Not run: 
##D # this is not an actual api key
##D api_key <- "5t5yno5qqkufxis5q2vzx26vxq2hqej9"
##D set_api_key(api_key, tempdir())
## End(Not run)



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
