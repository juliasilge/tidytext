pkgname <- "crsra"
source(file.path(R.home("share"), "R", "examples-header.R"))
options(warn = 1)
library('crsra')

base::assign(".oldSearch", base::search(), pos = 'CheckExEnv')
base::assign(".old_wd", base::getwd(), pos = 'CheckExEnv')
cleanEx()
nameEx("crsra_anonymize")
### * crsra_anonymize

flush(stderr()); flush(stdout())

### Name: crsra_anonymize
### Title: Anonymizes ID variables (such as Partner hashed user ids)
###   throughout the data set. The function is based on the function
###   'digest' from the package 'digest'.
### Aliases: crsra_anonymize

### ** Examples

res = crsra_anonymize(example_course_import,
col_to_mask = "jhu_user_id",
algorithm = "crc32")



cleanEx()
nameEx("crsra_assessmentskips")
### * crsra_assessmentskips

flush(stderr()); flush(stdout())

### Name: crsra_assessmentskips
### Title: Frequencies of skipping an peer-assessed submission
### Aliases: crsra_assessmentskips

### ** Examples

crsra_assessmentskips(example_course_import)
crsra_assessmentskips(example_course_import, bygender = TRUE, n = 10)



cleanEx()
nameEx("crsra_delete_user")
### * crsra_delete_user

flush(stderr()); flush(stdout())

### Name: crsra_delete_user
### Title: Deletes a specific user from all tables in the data in case
###   Coursera data privacy laws require you to delete a specific (or set
###   of) user(s) from your data.
### Aliases: crsra_delete_user

### ** Examples

del_user = example_course_import$users$jhu_user_id[1]
del_user %in% example_course_import$users$jhu_user_id
res = crsra_delete_user(example_course_import, users = del_user)
del_user %in% res$users$jhu_user_id




cleanEx()
nameEx("crsra_gradesummary")
### * crsra_gradesummary

flush(stderr()); flush(stdout())

### Name: crsra_gradesummary
### Title: The average course grade across different groups
### Aliases: crsra_gradesummary

### ** Examples

crsra_gradesummary(example_course_import)
crsra_gradesummary(example_course_import, groupby = "education")



cleanEx()
nameEx("crsra_import")
### * crsra_import

flush(stderr()); flush(stdout())

### Name: crsra_import
### Title: Imports all the .csv files into one list consisting of all the
###   courses and all the tables within each course.
### Aliases: crsra_import

### ** Examples

zip_file = system.file("extdata", "fake_course_7051862327916.zip",
package = "crsra")
bn = basename(zip_file)
bn = sub("[.]zip$", "", bn)
res = unzip(zip_file, exdir = tempdir(), overwrite = TRUE)
example_import = crsra_import(workdir = tempdir(),
check_problems = FALSE)




cleanEx()
nameEx("crsra_import_course")
### * crsra_import_course

flush(stderr()); flush(stdout())

### Name: crsra_import_course
### Title: Imports all the .csv files into one list consisting of all the
###   tables within the course.
### Aliases: crsra_import_course

### ** Examples

zip_file = system.file("extdata", "fake_course_7051862327916.zip",
package = "crsra")
bn = basename(zip_file)
bn = sub("[.]zip$", "", bn)
res = unzip(zip_file, exdir = tempdir(), overwrite = TRUE)
workdir = file.path(tempdir(), bn)
course_tables = crsra_import_course(workdir,
check_problems = FALSE)



cleanEx()
nameEx("crsra_membershares")
### * crsra_membershares

flush(stderr()); flush(stdout())

### Name: crsra_membershares
### Title: The share of learners in each course based on specific
###   characteristics.
### Aliases: crsra_membershares

### ** Examples

crsra_membershares(
example_course_import,
groupby = "country")
crsra_membershares(
example_course_import,
groupby = "roles", remove_missing = FALSE)
crsra_membershares(
example_course_import,
groupby = "roles", remove_missing = TRUE)



cleanEx()
nameEx("crsra_progress")
### * crsra_progress

flush(stderr()); flush(stdout())

### Name: crsra_progress
### Title: Ordered list of course items and the number and share of
###   learners who have completed the item
### Aliases: crsra_progress

### ** Examples

crsra_progress(example_course_import)



cleanEx()
nameEx("crsra_tabledesc")
### * crsra_tabledesc

flush(stderr()); flush(stdout())

### Name: crsra_tabledesc
### Title: Returns description for a table
### Aliases: crsra_tabledesc

### ** Examples

crsra_tabledesc("assessments")



cleanEx()
nameEx("crsra_timetofinish")
### * crsra_timetofinish

flush(stderr()); flush(stdout())

### Name: crsra_timetofinish
### Title: Time that took each learner (in days) to finish a course
### Aliases: crsra_timetofinish

### ** Examples

crsra_timetofinish(example_course_import)



cleanEx()
nameEx("crsra_whichtable")
### * crsra_whichtable

flush(stderr()); flush(stdout())

### Name: crsra_whichtable
### Title: Returns a list of tables a variable appears in
### Aliases: crsra_whichtable

### ** Examples

crsra_whichtable(example_course_import, "assessment_id")



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
