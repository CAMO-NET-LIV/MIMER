product <- read.csv("databases/ndcxls/product.csv")
package <- read.csv("databases/ndcxls/package.csv")

mimic_prescriptions_path <- ""

ndc_get_format <- function(s) {
  ifelse(nchar(s[[3]]) == 1,
         "541",
         ifelse(nchar(s[[2]]) == 3,
                "532",
                "442"))
}

convert_split_ndc <- function(split_code, format) {
  if (format == "541") {
    part1 <- split_code[[1]]
    part2 <- split_code[[2]]
    part3 <- paste0("0", split_code[[3]])
    return(paste0(part1, part2, part3, collapse = ""))
  }

  if (format == "442") {
    part1 <- paste0("0", split_code[[1]])
    part2 <- split_code[[2]]
    part3 <- split_code[[3]]
    return(paste0(part1, part2, part3, collapse = ""))
  }

  if (format == "532") {
    part1 <- split_code[[1]]
    part2 <- paste0("0", split_code[[2]])
    part3 <- split_code[[3]]
    return(paste0(part1, part2, part3, collapse = ""))
  }
}

convert_ndc_10_to_11 <- function(code) {
  split_code <- strsplit(code, "-")[[1]]
  code_nchar <- nchar(paste(split_code, collapse = ""))
  if (code_nchar != 10) return(NA)
  format <- ndc_get_format(split_code)
  return(convert_split_ndc(split_code, format))
}

convert_ndc_10_to_11 <- Vectorize(convert_ndc_10_to_11, USE.NAMES = F)

package$NDC_11 <- convert_ndc_10_to_11(package$NDCPACKAGECODE)

combined_key <- package[,c("PRODUCTNDC", "NDC_11", "NDCPACKAGECODE")]
combined_key <- merge(combined_key, product, by = "PRODUCTNDC",
                      all.x = TRUE)

data <- data.table::fread(mimic_prescriptions_path,
                          colClasses = c(ndc = "character"))
names(data)[names(data) == "ndc"] <- "NDC_11"

data2 <- merge(data, combined_key[c("NDC_11", "NONPROPRIETARYNAME")],
               by = "NDC_11", all.x = TRUE,
               allow.cartesian = TRUE)
