---
title: 'MIMER: R package for MIMIC Data Wrangling'
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
   
date: 23 April 2024
bibliography: paper.bib

---

# Summary

Primarily intended for healthcare-related research projects, MIMER is an R package tailored for analyzing the MIMIC-IV (Medical Information Mart for Intensive Care) dataset [@Johnson2023-qp]. This dataset, containing pseudonymized electronic health records, is accessible to credentialed users. MIMER provides a suite of data wrangling functions specifically designed to prepare the dataset for research endeavors, such as antimicrobial resistance (AMR) studies utilizing MIMIC data.

# Statement of need

The abstraction of complex data wrangling procedures into a library fulfills a critical need in research projects [@Gupta2022-el] [@Hempel2023-ud]. This approach offers a standardized solution for managing complex data manipulation tasks, enabling scholars to concentrate on their primary research inquiries without struggling with data wrangling complexities.


Major Features of MIMER:

1.  Convert National Drug Code to corresponding antibiotic code:

    MIMER provides a function to convert National Drug Codes (NDC) to corresponding antibiotic codes by mapping NDC codes to specific antibiotic names or identifiers, making the dataset more understandable and usable for     analysis. Additionally, MIMER provides functionality to verify whether an NDC code corresponds to an antimicrobial agent and includes a feature to determine if the route represents a systemic route or not. 

2.  Check previous events observed in the dataset within a particular period:

    MIMER offers a powerful functionality to analyze previous events within a dataset over a specified period. This feature is highly customizable, allowing users to define various parameters according to their analytical requirements. By leveraging this capability, users can gain insights into historical trends and patterns present in the dataset. This historical analysis proves invaluable for a wide range of analytical purposes, enabling researchers to make informed decisions and derive meaningful conclusions from the data.

3.  Transposing (pivoting) the microbiology dataset:

    MIMER offers functionality to transpose or pivot microbiology datasets. This process involves reorganizing the   dataset to make it more consumable and useful for machine learning applications. By pivoting the data, users can reshape it into a format that is easier to analyse and interpret, enabling more effective model training and analysis.


These features represent just a portion of MIMER's capabilities, and the project is designed to be scalable, allowing for the addition of more functionalities as needed.

# Acknowledgements

This research was funded in part by the Wellcome Trust [grant ref: 226691/Z/22/Z]. For the purpose of open access, the author has applied a CC BY public copyright licence to any Author Accepted Manuscript version arising from this submission. 

# References




