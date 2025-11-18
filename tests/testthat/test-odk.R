test_that("ODK Connection Test Caches Token", {
  expect_false(init_odk_connection(testing = T) == "")
})
