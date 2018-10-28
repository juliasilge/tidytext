pkgname <- "available"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('available')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("available")
### * available

flush(stderr()); flush(stdout())

### Name: available
### Title: See if a name is available
### Aliases: available

### ** Examples

## Not run: 
##D # Check if the available package is available
##D available("available")
##D 
##D # You can disable opening of browser windows with browse = FALSE
##D available("survival", browse = FALSE)
##D 
##D # Or by setting a global option
##D options(available.browse = FALSE)
##D available("survival")
## End(Not run)



cleanEx()
nameEx("suggest")
### * suggest

flush(stderr()); flush(stdout())

### Name: suggest
### Title: Suggest a package name based on a development package title or
###   description
### Aliases: suggest

### ** Examples

## Not run: 
##D # Default will use the title from the current path.
##D suggest()
##D 
##D # Can also suggest based on the description
##D suggest(field = "Description")
## End(Not run)

# Or by explictly using the text argument
suggest(text =
  "A Package for Displaying Visual Scenes as They May Appear to an Animal with Lower Acuity")



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
