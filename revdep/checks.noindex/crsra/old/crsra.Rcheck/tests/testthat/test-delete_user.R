
context("Users")

all_tables = crsra::example_course_import

test_that("Deleting users", {

    del_user = example_course_import$users$jhu_user_id[1]
    expect_true(del_user %in% example_course_import$users$jhu_user_id)

    res = crsra_delete_user(example_course_import, users = del_user)
    expect_false(del_user %in% res$users$jhu_user_id)

})
