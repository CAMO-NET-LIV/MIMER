

## Usage

amrabxlookup::clean_antibiotics( x , … )

# amrabxlookup

<!-- badges: start -->

**This is utility to clean antiobiotics data by leveraging AMR
Package.**
<!-- badges: end -->

The goal of amrabxlookup is to find matching antibiotics in AMR dataset.

## Installation

You can install the development version of amrabxlookup from
[GitHub](https://github.com/) with:

``` r
install.packages("devtools")
devtools::install_github("CAMO-NET-LIV/amrabxlookup", auth_token="<Your Personal Access Token (PAT)>")

or

install.packages("pak")
pak::pak("CAMO-NET-LIV/amrabxlookup")

```

## Example

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
