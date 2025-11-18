test_that("ODK Connection Test Caches Token", {
  expect_true(init_odk_connection(testing = T, verbose = F))
})

test_that("ODK API is live", {
  expect_true(list_odk_projects(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
  expect_true(list_odk_forms(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
  expect_true(download_odk_form(url = "https://rblf.tccodk.org/", testing = T) == 404.1)
})
