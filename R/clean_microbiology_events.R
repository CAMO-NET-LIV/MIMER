#Importing required modules
library(dplyr)
library(tidyr)
library(stringr)


clean_dataframe_column <- function(data, column_name, strings_to_remove= c("POSITIVE FOR","PRESUMPTIVELY","PRESUMPTIVE", "PROBABLE", "IDENTIFICATION", "RESEMBLING", "SEEN",
                                                                      "MODERATE", "FEW", "BETA", "METHICILLIN RESISTANT", "NUTRITIONALLY VARIANT",
                                                                      "NOT C. PERFRINGENS OR C. SEPTICUM", "-LACTAMASE POSITIVE", "-LACTAMASE NEGATIVE",
                                                                      "VIRAL ANTIGEN", "CANDIDA INCONSPICUA", "/POSADASII", "NOT FUMIGATUS, FLAVUS OR NIGER",
                                                                      "MRSA POSITIVE", "MRSA NEGATIVE","HISTOLYTICA/DISPAR"),
                                                      standard_mapping =c("NON-FERMENTER" = "STREPTOCOCCUS","ABIOTROPHIA/GRANULICATELLA" = "STREPTOCOCCUS", "S. AUREUS POSITIVE" = "STAPHYLOCOCCUS AUREUS",
                                                       "ASPERGILLUS FUMIGATUS COMPLEX" = "ASPERGILLUS FUMIGATUS","(CRYPTOSPORIDIUM PARVUM OOCYSTS|CUNNINGHAMELLA BERTHOLLETIAE|EPIDERMOPHYTON FLOCCOSUM|EXOPHIALA JEANSELMEI COMPLEX|SCEDOSPORIUM|NEOASCOCHYTA DESMAZIERI|NEOSCYTALIDIUM DIMIDIATUM|LOMENTOSPORA|NEUROSPORA|PERONEUTYPA SCOPARIA|SPOROTHRIX SCHENCKII COMPLEX|ZYGOSACCHAROMYCES FERMENTATI)"= "UNKNOWN FUNGUS"),
                                                      filter_values =c('CANCELLED|VIRUS|SIMPLEX|PARAINFLUENZA|INFLUENZA A|INFLUENZA B|TICK|AFB GROWN|GRAM VARIABLE RODS|HYMENOLEPIS')
                                   ){
  stopifnot(is.data.frame(data))

  if(length(strings_to_remove) > 0){
    data[[column_name]] <- str_replace_all(data[[column_name]], paste(strings_to_remove, collapse = "|"), "")
  }

  if(length(standard_mapping) > 0){
    for (mapping_key in names(standard_mapping)) {
      data[[column_name]] <- ifelse(grepl(names(standard_mapping[mapping_key]),data[[column_name]]),
                                    unname(standard_mapping[mapping_key]) ,data[[column_name]] )
    }
  }

  if(length(filter_values) > 0){
    data <- data %>% dplyr::filter(!grepl("(CANCELLED|VIRUS|SIMPLEX|PARAINFLUENZA|INFLUENZA A|INFLUENZA B|TICK|AFB GROWN|GRAM VARIABLE RODS|HYMENOLEPIS)", data[[column_name]]))
  }

  return(data)
}
