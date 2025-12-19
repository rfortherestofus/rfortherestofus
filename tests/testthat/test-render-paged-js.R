test_that("render_pagedjs_pdf fails as expected", {
  expect_snapshot(
    error = TRUE,
    x = render_pagedjs_pdf(file_path = character())
  )
})
