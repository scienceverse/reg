test_that("defaults", {
  j <- study() %>% study_to_json()

  comp <- '{
    "name": "Demo Study",
    "info": [],
    "authors": [],
    "hypotheses": [],
    "methods": [],
    "data": [],
    "analyses": []
}
'
  class(comp) <- "json"

  testthat::expect_equal(j, comp)
})

test_that("extra study args", {
  j <- study("Name", description = "My study") %>% study_to_json()
  comp <- '{
    "name": "Name",
    "info": {
        "description": "My study"
    },
    "authors": [],
    "hypotheses": [],
    "methods": [],
    "data": [],
    "analyses": []
}
'
  class(comp) <- "json"

  testthat::expect_equal(j, comp)
})

test_that("numeric arrays", {
  dat <- data.frame(x = 1:5)
  j <- study() %>% add_data("dat", dat) %>% study_to_json()
  match <- grep('"x": [1, 2, 3, 4, 5]', j, fixed = TRUE)
  expect_equal(match, 1)
})

test_that("remove values", {
  dat <- data.frame(x = 1:5)
  j <- study() %>% add_data("dat", dat) %>% study_to_json(data_values = FALSE)
  match <- grep('"x": [1, 2, 3, 4, 5]', j, fixed = TRUE)
  expect_equal(match, integer())
})

test_that("analyses", {
  s <- study() %>% add_analysis("A1", t.test(rnorm(100)))
  j <- study_to_json(s)

  expect_equal(grep("\"code\"\\: \"t\\.test\\(rnorm\\(100\\)\\)\"", j), 1)
})
