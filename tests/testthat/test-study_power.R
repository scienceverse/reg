s <- study() %>%
  add_hypothesis("H1") %>%
  add_analysis("A1", t.test(D1$Sepal.Length)) %>%
  add_criterion("C1", "p.value", "<", .05) %>%
  add_eval("corroboration", "the t-test is significant", "C1") %>%
  add_eval("falsification", "the t-test is not significant", "!C1") %>%
  add_data("D1", iris)

test_that("messages", {
  expect_message(study_power(s, 10), "The data `D1` will not be simulated, but be used as is for each analysis.", fixed = TRUE)
})

test_that("warnings", {
  s <- add_data(s, "D2")
  expect_warning(study_power(s, 10), "There is no data or design information for `D2`. Analyses that require this data are likely to fail.", fixed = TRUE)
})

test_that("errors", {
  s <- study()

  err_txt <- "The argument `rep` needs to be a positive number."
  expect_error(study_power(s, -10), err_txt, fixed = TRUE)
  expect_error(study_power(s, "a"), err_txt, fixed = TRUE)
  expect_error(study_power(s, 0.2), err_txt, fixed = TRUE)

  expect_error(study_power(s), "There are no hypotheses.", fixed = TRUE)

  s <- study() %>% add_hypothesis()
  expect_error(study_power(s), "There are no analyses", fixed = TRUE)
})

test_that("basic", {
  study <- study() %>%
    add_hypothesis("H1") %>%
    add_analysis("A1", t.test(y~A, data = D1)) %>%
    add_criterion("C1", "p.value", "<", 0.05) %>%
    add_analysis("A2", t.test(y~A, data = D2)) %>%
    add_criterion("C2", "p.value", "<", 0.05) %>%
    add_eval("corroboration", "", "C1 | C2") %>%
    add_eval("falsification", "", "!C1 & !C2") %>%
    add_sim_data("D1", between = 2, n = 20, mu = c(0, 1)) %>%
    add_sim_data("D2", between = 2, n = 30, mu = c(0, 1))

  study_power <- study_power(study, 100)

  p <- study_power$hypotheses[[1]]$power

  expect_equal(names(p), c("corroboration", "falsification",
                              "inconclusive", "criteria"))

  expect_true(p$corroboration > 0.95)
  expect_true(p$falsification < 0.05)
  expect_true(p$inconclusive < 0.05)
  expect_equal(names(p$criteria), c("C1", "C2"))

  expect_true(is.numeric(p$criteria$C1))
  expect_true(is.numeric(p$criteria$C2))
  expect_equal(length(p$criteria$C1), 100)
  expect_equal(length(p$criteria$C2), 100)
})

test_that("null", {
  study <- study() %>%
    add_hypothesis("H1") %>%
    add_analysis("A1", t.test(y~A, data = D1)) %>%
    add_criterion("C1", "p.value", "<", 0.05) %>%
    add_eval("corroboration", "", "C1") %>%
    add_eval("falsification", "", "!C1") %>%
    add_sim_data("D1", between = 2, n = 20) %>%
    study_power(100)

  expect_true(study$hypotheses[[1]]$power$corroboration < .15)
})

test_that("null", {
  study <- study() %>%
    add_hypothesis("H1") %>%
    add_analysis("A1", t.test(y~A, data = D1)) %>%
    add_criterion("C1", "p.value", "<", 0.05) %>%
    add_eval("corroboration", "", "C1") %>%
    add_eval("falsification", "", "!C1")

  for (d in seq(0, 1, 0.1)) {
     add_sim_data(study, "D1", between = 2, n = 20, mu = c(0, d)) %>%
      study_power(100)
  }
})