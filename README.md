
# amrabxlookup

<!-- badges: start -->
<!-- badges: end -->

The goal of amrabxlookup is to provide various utility functions to
process MIMIC dataset to support various data science projects.

## Usages

    amrabxlookup::ndc_to_antimicrobial(ndc, class)   

    amrabxlookup::ndc_is_antimicrobial(ndc, class)  

    amrabxlookup::is_systemic_route(route, class)  

    amrabxlookup::check_previous_events(df, cols, sort_by_col, patient_id_col,
                                    event_indi_value="R", new_col_prefix="pr_event_", 
                                    time_period_in_days = 0, minimum_prev_events = 0)
      

    amrabxlookup::transpose_microbioevents(df, key_columns, required_columns, transpose_key_column,
                                          transpose_value_column, fill = "N/A")  
                                          
    #not recommended to use                                      
    amrabxlookup::clean_antibiotics(
      x ,
     ... 
      )

## Installation

You can install the development version of amrabxlookup from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("CAMO-NET-LIV/amrabxlookup", auth_token="<your_personal_access_token>")

or

install.packages("pak")
pak::pak("CAMO-NET-LIV/amrabxlookup")
```

## Examples

This is a basic example which shows you how to solve a common problem:

``` r
library(amrabxlookup)
## basic example code
amrabxlookup::ndc_to_antimicrobial(ndc='65649030303', class='antibacterial')
```

    ## [1] "RFX"

``` r
library(amrabxlookup)
## basic example code
amrabxlookup::ndc_is_antimicrobial(ndc='65649030303')
```

    ## [1] TRUE

``` r
library(amrabxlookup)
## basic example code
amrabxlookup::is_systemic_route(route='PO/NG')
```

    ## [1] TRUE

``` r
library(amrabxlookup)
## basic example code
df <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','R','R','R','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))
    amrabxlookup::check_previous_events(df, cols = c('CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', event_indi_value='R')
```

    ## [1] "Checking Previous Events for "
    ## [1] "CEFTAZIDIME"
    ## [1] "Total Antibiotics Column (Events) Added :  1"

    ## # A tibble: 11 × 5
    ## # Groups:   subject_id [2]
    ##    subject_id chartdate  CEFEPIME CEFTAZIDIME pr_event_CEFTAZIDIME
    ##    <chr>      <chr>      <chr>    <chr>       <lgl>               
    ##  1 10038332   2164-07-31 R        S           FALSE               
    ##  2 10038332   2164-12-22 R        S           FALSE               
    ##  3 10038332   2164-12-22 R        S           FALSE               
    ##  4 10038332   2165-01-07 S        R           FALSE               
    ##  5 10038332   2165-04-17 S        R           TRUE                
    ##  6 10038332   2165-05-05 S        S           TRUE                
    ##  7 10016742   2178-07-03 R        S           FALSE               
    ##  8 10016742   2178-08-01 R        R           FALSE               
    ##  9 10016742   2178-08-01 R        S           FALSE               
    ## 10 10016742   2178-08-01 R        R           FALSE               
    ## 11 10016742   2178-09-25 S        R           TRUE

``` r
## example with 'minimum_prev_events' parameter
 df <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-07-22','2178-08-03','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','S','R','S','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))
  amrabxlookup::check_previous_events(df, cols = c('CEFEPIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', minimum_prev_events = 2)
```

    ## [1] "Checking Previous Events for "
    ## [1] "CEFEPIME"
    ## [1] "Total Antibiotics Column (Events) Added :  1"

    ## # A tibble: 11 × 5
    ## # Groups:   subject_id [2]
    ##    subject_id chartdate  CEFEPIME CEFTAZIDIME pr_event_CEFEPIME
    ##    <chr>      <chr>      <chr>    <chr>       <lgl>            
    ##  1 10038332   2164-07-31 R        S           FALSE            
    ##  2 10038332   2164-12-22 R        S           FALSE            
    ##  3 10038332   2164-12-22 R        S           FALSE            
    ##  4 10038332   2165-01-07 S        R           TRUE             
    ##  5 10038332   2165-04-17 S        R           TRUE             
    ##  6 10038332   2165-05-05 S        S           TRUE             
    ##  7 10016742   2178-07-03 R        S           FALSE            
    ##  8 10016742   2178-07-22 R        S           FALSE            
    ##  9 10016742   2178-08-01 S        R           TRUE             
    ## 10 10016742   2178-08-03 S        R           TRUE             
    ## 11 10016742   2178-09-25 S        R           TRUE

``` r
## example with 'time_period_in_days' parameter
df <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-07-22','2178-08-03','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','S','R','S','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))
amrabxlookup::check_previous_events(df, cols = c('CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', time_period_in_days = 25)
```

    ## [1] "Checking Previous Events for "
    ## [1] "CEFTAZIDIME"
    ## [1] "Total Antibiotics Column (Events) Added :  1"

    ## # A tibble: 11 × 5
    ## # Groups:   subject_id [2]
    ##    subject_id chartdate  CEFEPIME CEFTAZIDIME pr_event_CEFTAZIDIME
    ##    <chr>      <chr>      <chr>    <chr>       <lgl>               
    ##  1 10038332   2164-07-31 R        S           FALSE               
    ##  2 10038332   2164-12-22 R        S           FALSE               
    ##  3 10038332   2164-12-22 R        S           FALSE               
    ##  4 10038332   2165-01-07 S        R           FALSE               
    ##  5 10038332   2165-04-17 S        R           FALSE               
    ##  6 10038332   2165-05-05 S        S           TRUE                
    ##  7 10016742   2178-07-03 R        S           FALSE               
    ##  8 10016742   2178-07-22 R        S           FALSE               
    ##  9 10016742   2178-08-01 S        R           FALSE               
    ## 10 10016742   2178-08-03 S        R           TRUE                
    ## 11 10016742   2178-09-25 S        R           FALSE

``` r
## example with 'time_period_in_days' & 'minimum_prev_events' parameters
df <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','R','R','R','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))
                          
amrabxlookup::check_previous_events(df, cols = c('CEFEPIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', time_period_in_days = 62, minimum_prev_events = 2)
```

    ## [1] "Checking Previous Events for "
    ## [1] "CEFEPIME"
    ## [1] "Total Antibiotics Column (Events) Added :  1"

    ## # A tibble: 11 × 5
    ## # Groups:   subject_id [2]
    ##    subject_id chartdate  CEFEPIME CEFTAZIDIME pr_event_CEFEPIME
    ##    <chr>      <chr>      <chr>    <chr>       <lgl>            
    ##  1 10038332   2164-07-31 R        S           FALSE            
    ##  2 10038332   2164-12-22 R        S           FALSE            
    ##  3 10038332   2164-12-22 R        S           FALSE            
    ##  4 10038332   2165-01-07 S        R           TRUE             
    ##  5 10038332   2165-04-17 S        R           FALSE            
    ##  6 10038332   2165-05-05 S        S           FALSE            
    ##  7 10016742   2178-07-03 R        S           FALSE            
    ##  8 10016742   2178-08-01 R        R           FALSE            
    ##  9 10016742   2178-08-01 R        S           FALSE            
    ## 10 10016742   2178-08-01 R        R           FALSE            
    ## 11 10016742   2178-09-25 S        R           TRUE

``` r
##example for transpose_microbioevents
test_data <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          ab_name=c('CEFEPIME','CEFTAZIDIME','CEFEPIME','CEFEPIME','CEFTAZIDIME','CEFTAZIDIME','CEFEPIME','CEFEPIME','CEFTAZIDIME','CEFTAZIDIME','CEFEPIME'),
                          interpretation=c('S','R','S','R','R','S','S','S','R','R','S'))

amrabxlookup::transpose_microbioevents(test_data, key_columns = c('subject_id','chartdate','ab_name') , required_columns =c('subject_id','chartdate'), transpose_key_column = 'ab_name',
                                                    transpose_value_column = 'interpretation', fill = "N/A", non_empty_filter_column='subject_id')
```

    ##   subject_id  chartdate CEFEPIME CEFTAZIDIME
    ## 1   10016742 2178-07-03        S         N/A
    ## 2   10016742 2178-08-01      N/A           R
    ## 3   10016742 2178-09-25      N/A           R
    ## 4   10038332 2164-07-31      N/A           S
    ## 5   10038332 2165-01-07      N/A           R
    ## 6   10038332 2165-04-17      N/A           R
    ## 7   10038332 2165-05-05        S         N/A

``` r
library(amrabxlookup)
## basic example code
amrabxlookup::clean_antibiotics(c("Amoxicilli"))
```

    ## [1] "Amoxicillin"

``` r
library(amrabxlookup)
## basic example code
amrabxlookup::clean_antibiotics(c("Amoxicilli"))
```

    ## [1] "Amoxicillin"
