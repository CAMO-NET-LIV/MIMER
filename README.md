
**This is utility to clean antiobiotics data by leveraging AMR
Package.**

## Usages

amrabxlookup::clean_antibiotics( x , … )

amrabxlookup::add_previous_resistance(df, cols, sort_by_col,
patient_id_col, event_r_value=“R”, new_col_prefix=“pr_R\_”)

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
devtools::install_github("CAMO-NET-LIV/amrabxlookup")

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
df <- data.frame(subject_id = c(10000032,10000280,10000280,10000280,10000826,10000826),
      chartdate = c('2150-10-12','2150-10-12','2151-03-17','2151-12-08','2187-09-26','2188-07-01'),AMIKACIN=c('R','R','S','S','S','R'))
amrabxlookup::add_previous_resistance(df, cols="AMIKACIN", sort_by_col='chartdate',patient_id_col='subject_id', event_r_value='R')
```

    ## [1] "Adding Resistance Column for "
    ## [1] "AMIKACIN"
    ## [1] "Total Antibiotics Column (Resistance) Added :  1"

    ## # A tibble: 6 × 4
    ## # Groups:   subject_id [3]
    ##   subject_id chartdate  AMIKACIN pr_R_AMIKACIN
    ##        <dbl> <chr>      <chr>    <lgl>        
    ## 1   10000032 2150-10-12 R        FALSE        
    ## 2   10000280 2150-10-12 R        FALSE        
    ## 3   10000280 2151-03-17 S        TRUE         
    ## 4   10000280 2151-12-08 S        TRUE         
    ## 5   10000826 2187-09-26 S        FALSE        
    ## 6   10000826 2188-07-01 R        FALSE
