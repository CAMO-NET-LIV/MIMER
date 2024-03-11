#Importing required modules
library(dplyr)
library(tidyr)
library(stringr)
library(furrr)


clean_dataframe_column <- function(data, column, strings_to_remove= c("POSITIVE FOR","PRESUMPTIVELY","PRESUMPTIVE", "PROBABLE", "IDENTIFICATION", "RESEMBLING", "SEEN",
                                                                      "MODERATE", "FEW", "BETA", "METHICILLIN RESISTANT", "NUTRITIONALLY VARIANT",
                                                                      "NOT C. PERFRINGENS OR C. SEPTICUM", "-LACTAMASE POSITIVE", "-LACTAMASE NEGATIVE",
                                                                      "VIRAL ANTIGEN", "CANDIDA INCONSPICUA", "/POSADASII", "NOT FUMIGATUS, FLAVUS OR NIGER",
                                                                      "MRSA POSITIVE", "MRSA NEGATIVE","HISTOLYTICA/DISPAR")){
  stopifnot(is.data.frame(data))

  df <- data %>% mutate(!!{column} = str_remove(org_name,"POSITIVE FOR"),#---------------------------------------------------Cleaning
                      org_name = str_remove(org_name,"PRESUMPTIVELY"


}


plan(multisession, workers = 4)

clean_microbiology_org <- function(data, strings_to_remove = c("POSITIVE FOR","PRESUMPTIVELY","PRESUMPTIVE", "PROBABLE", "IDENTIFICATION", "RESEMBLING", "SEEN",
                                                        "MODERATE", "FEW", "BETA", "METHICILLIN RESISTANT", "NUTRITIONALLY VARIANT",
                                                        "NOT C. PERFRINGENS OR C. SEPTICUM", "-LACTAMASE POSITIVE", "-LACTAMASE NEGATIVE",
                                                        "VIRAL ANTIGEN", "CANDIDA INCONSPICUA", "/POSADASII", "NOT FUMIGATUS, FLAVUS OR NIGER",
                                                        "MRSA POSITIVE", "MRSA NEGATIVE","HISTOLYTICA/DISPAR"),
                            standard_mapping =c("NON-FERMENTER" = "STREPTOCOCCUS","ABIOTROPHIA/GRANULICATELLA" = "STREPTOCOCCUS", "S. AUREUS POSITIVE" = "STAPHYLOCOCCUS AUREUS",
                                                "ASPERGILLUS FUMIGATUS COMPLEX" = "ASPERGILLUS FUMIGATUS","(CRYPTOSPORIDIUM PARVUM OOCYSTS|CUNNINGHAMELLA BERTHOLLETIAE|EPIDERMOPHYTON FLOCCOSUM|EXOPHIALA JEANSELMEI COMPLEX|SCEDOSPORIUM|NEOASCOCHYTA DESMAZIERI|NEOSCYTALIDIUM DIMIDIATUM|LOMENTOSPORA|NEUROSPORA|PERONEUTYPA SCOPARIA|SPOROTHRIX SCHENCKII COMPLEX|ZYGOSACCHAROMYCES FERMENTATI)"= "UNKNOWN FUNGUS")) {
  stopifnot(is.data.frame(data))
  filter_values =c('CANCELLED|VIRUS|SIMPLEX|PARAINFLUENZA|INFLUENZA A|INFLUENZA B|TICK|AFB GROWN|GRAM VARIABLE RODS|HYMENOLEPIS')
  filter(!grepl("(CANCELLED|VIRUS|SIMPLEX|PARAINFLUENZA|INFLUENZA A|INFLUENZA B|TICK|AFB GROWN|GRAM VARIABLE RODS|HYMENOLEPIS)",org_name)) %>%
    stopifnot(nrow(data) > 0)

  org_name_vector <- data$org_name

  data$org_name <- future_map(org_name_vector, function(x) {

    for (rmstring in names(strings_to_remove)) {
      x <- str_remove(x, rmstring)
    }
    return(x)
  })
  org_name_vector <- data$org_name
  data$org_name <- future_map(org_name_vector, function(x) {
    for (mapping_key in names(standard_mapping)) {
      x <-  case_when(grepl(names(standard_mapping[mapping_key]),x)~unname(standard_mapping[mapping_key]),
                      TRUE~x)
      return(x)
    })
  return(data)
  }
