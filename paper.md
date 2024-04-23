---
title: 'MIMER: A R package for MIMIC Data Wrangling'
tags:
  - R
  - MIMIC
  - Healthcare
  
authors:
  - name: Anoop Velluva
    orcid: 0009-0001-6198-6016
    equal-contrib: true
    affiliation: 1
  - name: Alessandro Gerada
    orcid: 0000-0002-6743-4271
    equal-contrib: true 
    affiliation: 1
  - name: Alex Howard
    orcid: 0000-0000-0000-0000
    equal-contrib: true
    affiliation: 1
affiliations:
 - name: Dept.of Pharmacology, University of Liverpool, United Kingdom
   index: 1
---

# Summary

MIMER is an R package tailored for reading and analysing the MIMIC-IV (Medical Information Mart for Intensive Care) dataset - a pseudonymised dataset of electronic health records, available for credentialed users. MIMER provides various data wrangling functions, rendering the dataset more amenable for machine learning use cases.

# Statement of need

Abstracting complex data wrangling logic into a library serves an essential requirement in research projects. By providing a standardized solution for handling complicated data manipulation tasks, scholars can focus on core research inquiries.


THE following are major features of MIMER (the project is scalable to add more functionalities):

1.  Convert National Drug Code to corresponding antibiotic code:

MIMER provides a function to convert National Drug Codes (NDC) to corresponding antibiotic codes by mapping NDC codes to specific antibiotic names or identifiers, making the dataset more understandable and usable for analysis.

2.  Check previous events observed in the dataset within a particular period:

Another important functionality of MIMER is the ability to analyse previous events within a dataset over a specified period. This feature allows users to understand historical trends and patterns in the data, which can be valuable for various analytical purposes.

3.  Transposing (pivoting) the microbiology dataset:

MIMER offers functionality to transpose or pivot microbiology datasets. This process involves reorganizing the dataset to make it more consumable and useful for machine learning applications. By pivoting the data, users can reshape it into a format that is easier to analyse and interpret, enabling more effective model training and analysis.

# Acknowledgements

This research was funded in part by the Wellcome Trust [grant ref: 226691/Z/22/Z]. For the purpose of open access, the author has applied a CC BY public copyright licence to any Author Accepted Manuscript version arising from this submission. 

# References
