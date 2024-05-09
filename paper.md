---
title: 'MIMER: R Package for MIMIC Data Wrangling for AMR Studies'
tags:
  - R
  - MIMIC
  - Healthcare
  
authors:
  - name: Anoop Velluva
    orcid: 0009-0001-6198-6016
    equal-contrib: true
    affiliation: 1
  - name: Alex Howard
    orcid: 0000-0000-0000-0000
    equal-contrib: true
    affiliation: 1
  - name: Alessandro Gerada
    orcid: 0000-0002-6743-4271
    equal-contrib: true 
    affiliation: 1
affiliations:
 - name: Department of Antimicrobial Pharmacodynamics and Therapeutics, Institute of Systems, Molecular and Integrative Biology, University of Liverpool, Liverpool, United Kingdom
   index: 1
   
date: 23 April 2024
bibliography: paper.bib
---

# Summary

The Medical Information Mart for Intensive Care (MIMIC) dataset is a deidentified electronic health dataset of over 40,000 patients admitted at the Beth Israel Deaconess Medical Center (BIDMC) [@Johnson2023-qp]. The latest version, MIMIC-IV, is freely accessible to credentialed users, and has been established as one of the premier datasets for research analysis of healthcare data [@Johnson2023-ny]. MIMER is an R package that facilitates analysis of the MIMIC-IV dataset for infectious disease epidemiology, microbiology, and antimicrobial resistance research. MIMER provides a suite of data wrangling functions specifically designed to prepare the dataset for research projects. Developed entirely in R, MIMER is aimed at R developers primarily engaged in antimicrobial resistance (AMR) [@Prestinaci2015-pj] studies utilizing MIMIC data. The package seamlessly integrates with the AMR [@Berends2022-iv] package, enhancing the analytical capabilities for AMR-related studies.

# Statement of need

The abstraction of complex data wrangling procedures into a library fulfills a critical need in research projects. This approach offers a standardized solution for managing complex data manipulation tasks, enabling reserachers to concentrate on their primary research inquiries without struggling with data wrangling complexities. While similar projects exist for MIMIC data wrangling [@Gupta2022-el], MIMER distinguishes itself by prioritizing Anti-Microbial Resistance (AMR) research, offering seamless integration with the AMR package for R users (AMR package is an open-source R Package to simplify the process of analyzing and predicting antimicrobial resistance).

# Major features of MIMER

1.  Convert National Drug Code to corresponding antibiotic code:

    MIMER provides a function to convert National Drug Codes (NDC) to corresponding antibiotic codes by mapping NDC codes to specific antibiotic names or identifiers, making the dataset more understandable and usable for analysis. Additionally, MIMER provides functionality to verify whether an NDC code corresponds to an antimicrobial agent and includes a feature to determine if the route represents a systemic route or not.
    
     Example Usages:
    
        MIMER::ndc_to_antimicrobial(ndc, class)

    Converts NDC (National Drug Code) to antimicrobial class.

        MIMER::ndc_is_antimicrobial(ndc, class)

    Checks if the given NDC is an antimicrobial drug.
    
2.  Check previous events observed in the dataset within a particular period:

    MIMER offers a powerful functionality to analyze previous events within a dataset over a specified period. This feature is highly customizable, allowing users to define various parameters according to their analytical requirements. By leveraging this capability, users can gain insights into historical trends and patterns present in the dataset. This historical analysis proves invaluable for a wide range of analytical purposes, enabling researchers to make informed decisions and derive meaningful conclusions from the data.
    
    Example Usages:
    
        MIMER::check_previous_events(df,
                                    cols,
                                    sort_by_col, 
                                    patient_id_col,
                                    event_indi_value="R",
                                    new_col_prefix="pr_event_", 
                                    time_period_in_days = 0, 
                                    minimum_prev_events = 0)

3.  Transposing (pivoting) the microbiology dataset for Antimicrobial susceptibility testing (AST):

    MIMER provides a feature for transposing or pivoting susceptibility columns in the microbiology datasets, restructures the dataset to enhance its usability for machine learning/analytical purposes. This functionality ultimately enables more effective model training and statistical analysis in the context of Antimicrobial Susceptibility Testing.
    
    Example Usages:
    
        MIMER::transpose_microbioevents(df, 
                                        key_columns, 
                                        required_columns,
                                        transpose_key_column,
                                        transpose_value_column, fill = "N/A") 

These features represent just a portion of MIMER's capabilities, and the project is designed to be scalable, allowing for the addition of more functionalities as needed.

# Acknowledgements

This research was funded in part by the Wellcome Trust [grant ref: 226691/Z/22/Z]. For the purpose of open access, the author has applied a CC BY public copyright licence to any Author Accepted Manuscript version arising from this submission.

# References
