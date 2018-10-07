pkgname <- "tidymodels"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('tidymodels')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("tag_show")
### * tag_show

flush(stderr()); flush(stdout())

### Name: tag_show
### Title: Facilities for loading and updating other packages
### Aliases: tag_show tags tag_attach tag_update

### ** Examples

tag_show()



cleanEx()
nameEx("tidymodels_conflicts")
### * tidymodels_conflicts

flush(stderr()); flush(stdout())

### Name: tidymodels_conflicts
### Title: Conflicts between the tidymodels and other packages
### Aliases: tidymodels_conflicts

### ** Examples

tidymodels_conflicts()



cleanEx()
nameEx("tidymodels_packages")
### * tidymodels_packages

flush(stderr()); flush(stdout())

### Name: tidymodels_packages
### Title: List all packages in the tidymodels
### Aliases: tidymodels_packages

### ** Examples

tidymodels_packages()



cleanEx()
nameEx("tidymodels_update")
### * tidymodels_update

flush(stderr()); flush(stdout())

### Name: tidymodels_update
### Title: Update tidymodels packages
### Aliases: tidymodels_update

### ** Examples

## Not run: 
##D tidymodels_update()
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
