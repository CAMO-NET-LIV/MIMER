#Importing required modules
library(data.table)
library(dplyr)
library(purrr)
library(tidyr)


#' @importFrom rlang sym
#' @importFrom rlang :=


#' @name add_previous_resistance
#' @title Add a column and check any previous resistance identified for a particular antibiotic
#' @description
#'  This function helps to check any previous resistance identified or not (TRUE/FALSE)
#' @usage add_previous_resistance(df, cols, sort_by_col, patient_id_col,
#'  event_r_value="R", new_col_prefix="pr_R_")
#' @param df A data frame containing microbiology events
#' @param cols Columns for each antibiotics which contains events
#' @param sort_by_col A date column to order the input data frame
#' @param patient_id_col Patient Id Column
#' @param event_r_value (optional) Event value indicating Resistance (Default 'R' )
#' @param new_col_prefix (optional) Custom Prefix for new column(Default 'pr_R_' )

#'
#' @return Data Frame
#' @examples
#'
#' test_data <- data.frame(subject_id = c(10000032,10000280,10000280,
#'                                      10000280,10000826,10000826),
#'                       chartdate = c('2150-10-12','2150-10-12','2151-03-17',
#'                                   '2146-12-08','2187-09-26','2188-07-01'),
#'                       AMIKACIN=c('R','R','S','S','S','R'))
#'
#' add_previous_resistance(test_data, cols="AMIKACIN", sort_by_col='chartdate',
#'                         patient_id_col='subject_id', event_r_value='R')
#'


add_resistance_column <- function(data, col, new_col, event_r_value) {
  new_data <- data %>%
    mutate(!!new_col := ifelse(cumsum(ifelse(row_number() == 1, 0, ifelse(dplyr::lag(!!sym(col), 1) == sym(event_r_value), 1, 0))) >= 1, TRUE, FALSE))

  return(new_data)
}

#' @export
add_previous_resistance <- function(df,cols,sort_by_col,patient_id_col, event_r_value='R', new_col_prefix="pr_R_") {

  df <- df %>%
    arrange(!!sym(patient_id_col), !!sym(sort_by_col)) %>%
    group_by(!!sym(patient_id_col))

  i=0
  print("Adding Resistance Column for ")
  for(col in cols){
    print(col)
    new_col = paste0(new_col_prefix,col)
    i=i+1

    df <- df %>%
      add_resistance_column({{col}},{{new_col}},event_r_value)

  }
  print(paste("Total Antibiotics Column (Resistance) Added : ",i))

  return(df)
}
