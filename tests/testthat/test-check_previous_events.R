test_that("Check Previous Resistance - base", {

  test_data <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','R','R','R','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))

  test_df <- test_data %>% check_previous_events(cols = c('CEFEPIME','CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id')


  expected_df <- data.frame(subject_id=c('10038332','10038332','10038332','10038332','10038332','10038332','10016742','10016742','10016742','10016742','10016742'),
                            chartdate= c('2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05','2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25'),
                            CEFEPIME=c('R','R','R','S','S','S','R','R','R','R','S'),
                            CEFTAZIDIME=c('S','S','S','R','R','S','S','R','S','R','R'),
                            pr_event_CEFEPIME =c(FALSE,TRUE,TRUE,TRUE,TRUE,TRUE,FALSE,TRUE,TRUE,TRUE,TRUE),
                            pr_event_CEFTAZIDIME =c(FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,FALSE,FALSE,FALSE,FALSE,TRUE))

  expect_equal(as.data.frame(test_df),expected_df)

})


test_that("Check Previous Resistance with 'time_period_in_days' parameter", {

  test_data <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-07-22','2178-08-03','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','S','R','S','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))

  test_df <- test_data %>% check_previous_events(cols = c('CEFEPIME','CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', time_period_in_days = 25)

  expected_df <- data.frame(subject_id=c('10038332','10038332','10038332','10038332','10038332','10038332','10016742','10016742','10016742','10016742','10016742'),
                            chartdate= c('2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05','2178-07-03','2178-07-22','2178-08-01','2178-08-03','2178-09-25'),
                            CEFEPIME=c('R','R','R','S','S','S','R','R','S','S','S'),
                            CEFTAZIDIME=c('S','S','S','R','R','S','S','S','R','R','R'),
                            pr_event_CEFEPIME =c(FALSE,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE),
                            pr_event_CEFTAZIDIME =c(FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,TRUE,FALSE))

  expect_equal(as.data.frame(test_df),expected_df)

})

test_that("Check Previous Resistance with 'minimum_prev_events' parameter", {

  test_data <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-07-22','2178-08-03','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','S','R','S','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))

  test_df <- test_data %>% check_previous_events(cols = c('CEFEPIME','CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', minimum_prev_events = 2)

  expected_df <- data.frame(subject_id=c('10038332','10038332','10038332','10038332','10038332','10038332','10016742','10016742','10016742','10016742','10016742'),
                            chartdate= c('2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05','2178-07-03','2178-07-22','2178-08-01','2178-08-03','2178-09-25'),
                            CEFEPIME=c('R','R','R','S','S','S','R','R','S','S','S'),
                            CEFTAZIDIME=c('S','S','S','R','R','S','S','S','R','R','R'),
                            pr_event_CEFEPIME =c(FALSE,FALSE,FALSE,TRUE,TRUE,TRUE,FALSE,FALSE,TRUE,TRUE,TRUE),
                            pr_event_CEFTAZIDIME =c(FALSE,FALSE,FALSE,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,TRUE))

  expect_equal(as.data.frame(test_df),expected_df)

})


test_that("Check Previous Resistance with 'minimum_prev_events' + 'time_period_in_days' parameters", {

  test_data <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-07-22','2178-08-03','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','S','R','S','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))

  test_df <- test_data %>% check_previous_events(cols = c('CEFEPIME','CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', time_period_in_days = 62, minimum_prev_events = 2)

  expected_df <- data.frame(subject_id=c('10038332','10038332','10038332','10038332','10038332','10038332','10016742','10016742','10016742','10016742','10016742'),
                            chartdate= c('2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05','2178-07-03','2178-07-22','2178-08-01','2178-08-03','2178-09-25'),
                            CEFEPIME=c('R','R','R','S','S','S','R','R','S','S','S'),
                            CEFTAZIDIME=c('S','S','S','R','R','S','S','S','R','R','R'),
                            pr_event_CEFEPIME =c(FALSE,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,TRUE,TRUE,FALSE),
                            pr_event_CEFTAZIDIME =c(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE))

  expect_equal(as.data.frame(test_df),expected_df)

})


test_that("Check Previous Resistance with 'minimum_prev_events' + 'time_period_in_days' parameters with events in same date scenario", {

  test_data <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','R','R','R','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))

  test_df <- test_data %>% check_previous_events(cols = c('CEFEPIME','CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', time_period_in_days = 62, minimum_prev_events = 2)

  expected_df <- data.frame(subject_id=c('10038332','10038332','10038332','10038332','10038332','10038332','10016742','10016742','10016742','10016742','10016742'),
                            chartdate= c('2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05','2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25'),
                            CEFEPIME=c('R','R','R','S','S','S','R','R','R','R','S'),
                            CEFTAZIDIME=c('S','S','S','R','R','S','S','R','S','R','R'),
                            pr_event_CEFEPIME =c(FALSE,FALSE,FALSE,TRUE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE),
                            pr_event_CEFTAZIDIME =c(FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,FALSE,TRUE))

  expect_equal(as.data.frame(test_df),expected_df)

})
