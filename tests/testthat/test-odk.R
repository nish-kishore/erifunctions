test_that("ODK Connection Test Caches Token", {
  expect_true(init_odk_connection(testing = T, verbose = F))
})
