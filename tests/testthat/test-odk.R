test_that("ODK Connection Test Caches Token", {
  expect_true(init_odk_connection(testing = T, verbose = F))
})

test_that("ODK API is live", {
  expect_true(list_odk_projects(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
  expect_true(list_odk_forms(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
  expect_true(download_odk_form(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
  expect_true(list_all_odk_app_users(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
  expect_error(update_odk_app_user_role(action = "test"))
  expect_error(update_odk_app_user_role(action = "create", project_id = 2))
  expect_error(update_odk_app_user_role(action = "delete", project_id = 2))
  })
