test_that("Check Previous Resistance", {

  test_data <- data.frame(patient_id = c(1,2,2,2,3,3), date = c(1,1,2,3,4,5), abx_event=c('R','R','S','S','S','R'))

  test_df <- test_data %>% add_previous_resistance(cols="abx_event", sort_by_col='date', patient_id_col='patient_id')

  expected_df <- data.frame(patient_id = c(1,2,2,2,3,3),
                            date = c(1,1,2,3,4,5),
                            abx_event=c('R','R','S','S','S','R'),
                            pr_R_abx_event=c(FALSE, FALSE,TRUE,TRUE,FALSE,FALSE)) %>% group_by(patient_id) %>% arrange(patient_id,date)

  expect_equal(test_df,expected_df)

})
