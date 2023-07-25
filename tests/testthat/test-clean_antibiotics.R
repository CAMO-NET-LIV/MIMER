test_that("Antibiotic Check : DataFrame with Medicine", {
  test_df <- clean_antibiotics(data.frame(drug = c("Amoxicilln","Amoxicillin","Paracetamol") ), drug_col=drug)
  expected_df <- data.frame(drug = c("Amoxicilln","Amoxicillin","Paracetamol") ,
                            abx_name=c("Amoxicillin","Amoxicillin",NA),
                            synonyms= c("Amoxicillin","Amoxicillin",NA),
                            is_abx=c(TRUE,TRUE,FALSE))
  expect_equal(test_df,expected_df)
})


test_that("Antibiotic Check : Character Vector with Medicine", {
  test_df <- clean_antibiotics( c("Amoxicilln","Amoxicillin","Paracetamol"))
  expected_df <- c("Amoxicillin","Amoxicillin",NA)
  expect_equal(test_df,expected_df)
})
