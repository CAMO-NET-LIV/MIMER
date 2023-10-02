<<<<<<< HEAD
# library(data.table)
#
# product <- read.csv("databases/ndcxls/product.csv")
# package <- read.csv("databases/ndcxls/package.csv")
#
# mimic_prescriptions_path <- "~/data/mimiciv/2.2/hosp/prescriptions.csv.gz"
#
# ndc_get_format <- function(s) {
#   ifelse(nchar(s[[3]]) == 1,
#          "541",
#          ifelse(nchar(s[[2]]) == 3,
#                 "532",
#                 "442"))
# }
#
# convert_split_ndc <- function(split_code, format) {
#   if (format == "541") {
#     part1 <- split_code[[1]]
#     part2 <- split_code[[2]]
#     part3 <- paste0("0", split_code[[3]])
#     return(paste0(part1, part2, part3, collapse = ""))
#   }
#
#   if (format == "442") {
#     part1 <- paste0("0", split_code[[1]])
#     part2 <- split_code[[2]]
#     part3 <- split_code[[3]]
#     return(paste0(part1, part2, part3, collapse = ""))
#   }
#
#   if (format == "532") {
#     part1 <- split_code[[1]]
#     part2 <- paste0("0", split_code[[2]])
#     part3 <- split_code[[3]]
#     return(paste0(part1, part2, part3, collapse = ""))
#   }
# }
#
# convert_ndc_10_to_11 <- function(code) {
#   split_code <- strsplit(code, "-")[[1]]
#   code_nchar <- nchar(paste(split_code, collapse = ""))
#   if (code_nchar != 10) return(NA)
#   format <- ndc_get_format(split_code)
#   return(convert_split_ndc(split_code, format))
# }
#
# convert_ndc_10_to_11 <- Vectorize(convert_ndc_10_to_11, USE.NAMES = F)
#
# package$NDC_11 <- convert_ndc_10_to_11(package$NDCPACKAGECODE)
#
# combined_key <- package[,c("PRODUCTNDC", "NDC_11", "NDCPACKAGECODE")]
# combined_key <- merge(combined_key, product, by = "PRODUCTNDC",
#                       all.x = TRUE)
# combined_key <- combined_key[!duplicated(combined_key$NDC_11),]
# combined_key <- data.table(combined_key)
#
# data <- data.table::fread(mimic_prescriptions_path,
#                           colClasses = c(ndc = "character"))
# setnames(data, "ndc", "NDC_11")
# names(data)[names(data) == "ndc"] <- "NDC_11"
#
# data2 <- merge(data, combined_key, by = "NDC_11", all.x = TRUE, sort = FALSE)
#
#
# # all classes in NDC
# classes <- strsplit(paste(combined_key$PHARM_CLASSES, collapse = ","), ",")
# classes <- unlist(classes)
# classes <- subset(classes, grepl("anti", classes, ignore.case = TRUE))
# classes <- unique(classes)
# classes <- sort(classes)
# all_relevant_classes <- c("antimicrobial",
#                           "antibacterial",
#                           "antifungal",
#                           "antiviral",
#                           "antimalarial",
#                           "antiprotozoal")
# antibacterial_classes <- c("antimicrobial",
#                            "antibacterial")
# relevant_routes_administration <- c("PO/NG",
#                                     "IV",
#                                     "NG",
#                                     "IM",
#                                     "IV DRIP",
#                                     "PR",
#                                     "ORAL",
#                                     "IVPCA",
#                                     "IV BOLUS",
#                                     "DIALYS")
#
# abx names added
# data2$abx_names <- ifelse(grepl(paste(antibacterial_classes, collapse = "|"),
#                                 data2$PHARM_CLASSES,
#                                 ignore.case=TRUE),
#                           AMR::as.ab(data2$SUBSTANCENAME),
#                           NA)
#
# # keep antibiotics only
# data2 <- subset(data2, grepl(paste(antibacterial_classes, collapse = "|"),
#                              data2$PHARM_CLASSES,
#                              ignore.case=TRUE))
#
# # keep only systemic routs
# data2 <- subset(data2, grepl(paste(relevant_routes_administration, collapse = "|"),
#                              data2$route,
#                              ignore.case=TRUE))
#

# functions needed
# ndc_to_antimicrobial <- function(x, class_names) {return("Antibiotic name")}
# class names has default of antibacterial classes above

# ndc_is_antimicrobial <- function(x, class_names) {return(TRUE)}

# is_systemic_route <- function(x, routes) {return(TRUE)}
# x = route vector
# routes = default relevant_routes_administration from above
