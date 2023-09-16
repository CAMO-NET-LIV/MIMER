
**This library mainly for cleaning antiobiotics data by leveraging AMR
Package, with some additional useful functions.**

## Usages

    amrabxlookup::clean_antibiotics(
      x ,
     ... 
      )

    amrabxlookup::check_previous_events(df, cols, sort_by_col, patient_id_col, event_indi_value="R", new_col_prefix="pr_event_", 
                                    time_period_in_days = 0, minimum_prev_events = 0)

<!-- df   A data frame containing microbiology events -->
<!-- cols  Columns for each antibiotics which contains events -->
<!-- sort_by_col  A date column to order the input data frame -->
<!-- patient_id_col  Patient Id Column -->
<!-- event_indi_value (optional)  Event value indicating Resistance (Default 'R' ) -->
<!-- new_col_prefix (optional)   Custom Prefix for new column(Default 'pr_event_' ) -->
<!-- time_period_in_days (optional)  Values to check any  previous events in last 'n' days or not -->
<!-- minimum_prev_events (optional)  Values to check any 'n' number of previous events happened or not -->

# amrabxlookup

<!-- badges: start -->
<!-- badges: end -->

The goal of amrabxlookup is to find matching antibiotics in AMR dataset
and some other additinal useful utility functions.

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
amrabxlookup::clean_antibiotics(c("Amoxicilli"))
```

    ## [1] "Amoxicillin"

``` r
library(amrabxlookup)
## basic example code
df <- data.frame(drug = c("Amoxicilln","moxicillin","Paracetamol") )
amrabxlookup::clean_antibiotics(df, drug_col = drug)
```

    ##          drug    abx_name    synonyms is_abx
    ## 1  Amoxicilln Amoxicillin Amoxicillin   TRUE
    ## 2  moxicillin Amoxicillin Amoxicillin   TRUE
    ## 3 Paracetamol        <NA>        <NA>  FALSE

``` r
library(amrabxlookup)
## basic example code
df <- data.frame(subject_id=c('10016742','10016742','10016742','10016742','10016742','10038332','10038332','10038332','10038332','10038332','10038332'),
                          chartdate= c('2178-07-03','2178-08-01','2178-08-01','2178-08-01','2178-09-25','2164-07-31','2164-12-22','2164-12-22','2165-01-07','2165-04-17','2165-05-05'),
                          CEFEPIME=c('R','R','R','R','S','R','R','R','S','S','S'),
                          CEFTAZIDIME=c('S','R','S','R','R','S','S','S','R','R','S'))
    amrabxlookup::check_previous_events(df, cols = c('CEFTAZIDIME'), sort_by_col = 'chartdate', patient_id_col = 'subject_id', event_indi_value='R')
```

    ## [1] "Adding Resistance Column for "
    ## [1] "CEFTAZIDIME"
    ## [1] "Total Antibiotics Column (Resistance) Added :  1"

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

    ## [1] "Adding Resistance Column for "
    ## [1] "CEFEPIME"
    ## [1] "Total Antibiotics Column (Resistance) Added :  1"

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

    ## [1] "Adding Resistance Column for "
    ## [1] "CEFTAZIDIME"
    ## [1] "Total Antibiotics Column (Resistance) Added :  1"

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

    ## [1] "Adding Resistance Column for "
    ## [1] "CEFEPIME"
    ## [1] "Total Antibiotics Column (Resistance) Added :  1"

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
