---
title: 'MIMER: R Package for MIMIC Data Wrangling for AMR Use Cases'
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

Primarily intended for healthcare-related research projects, MIMER is an R package tailored for analyzing the MIMIC-IV (Medical Information Mart for Intensive Care) dataset [@Johnson2023-qp]. MIMIC-IV is an open-source psedonymised electronic health care data for over 40,000 patients admitted at the Beth Israel Deaconess Medical Center (BIDMC), accessible to credentialed users (https://physionet.org/content/mimiciv/2.2/). MIMER provides a suite of data wrangling functions specifically designed to prepare the dataset for research projects. Developed entirely in R, MIMER is aimed at R developers primarily engaged in antimicrobial resistance (AMR) [@Prestinaci2015-pj] studies utilizing MIMIC data. The package seamlessly integrates with the AMR [@Berends2022-iv] package, enhancing the analytical capabilities for AMR-related studies.

# Statement of need

The abstraction of complex data wrangling procedures into a library fulfills a critical need in research projects. This approach offers a standardized solution for managing complex data manipulation tasks, enabling reserachers to concentrate on their primary research inquiries without struggling with data wrangling complexities. While similar projects exist for MIMIC data wrangling [@Gupta2022-el], MIMER distinguishes itself by prioritizing Anti-Microbial Resistance (AMR) research, offering seamless integration with the AMR package for R users (AMR package is an open-source R Package to simplify the process of analyzing and predicting antimicrobial resistance).

Major Features of MIMER:

1.  Convert National Drug Code to corresponding antibiotic code:

    MIMER provides a function to convert National Drug Codes (NDC) to corresponding antibiotic codes by mapping NDC codes to specific antibiotic names or identifiers, making the dataset more understandable and usable for analysis. Additionally, MIMER provides functionality to verify whether an NDC code corresponds to an antimicrobial agent and includes a feature to determine if the route represents a systemic route or not.

2.  Check previous events observed in the dataset within a particular period:

    MIMER offers a powerful functionality to analyze previous events within a dataset over a specified period. This feature is highly customizable, allowing users to define various parameters according to their analytical requirements. By leveraging this capability, users can gain insights into historical trends and patterns present in the dataset. This historical analysis proves invaluable for a wide range of analytical purposes, enabling researchers to make informed decisions and derive meaningful conclusions from the data.

3.  Transposing (pivoting) the microbiology dataset for Antimicrobial susceptibility testing (AST):

    MIMER provides a feature for transposing or pivoting susceptibility columns in the microbiology datasets, restructures the dataset to enhance its usability for machine learning/analytical purposes. This functionality ultimately enables more effective model training and analysis in the context of Antimicrobial Susceptibility Testing.

These features represent just a portion of MIMER's capabilities, and the project is designed to be scalable, allowing for the addition of more functionalities as needed.

# Acknowledgements

This research was funded in part by the Wellcome Trust [grant ref: 226691/Z/22/Z]. For the purpose of open access, the author has applied a CC BY public copyright licence to any Author Accepted Manuscript version arising from this submission.

# References
