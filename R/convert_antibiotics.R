product <- read.csv("databases/ndcxls/product.csv")
package <- read.csv("databases/ndcxls/package.csv")

ndc_codes <- package$NDCPACKAGECODE
ndc_codes_split <- strsplit(ndc_codes, "-")

ndc_get_format <- function(s) {
  ifelse(nchar(s[[3]]) == 1,
         "541",
         ifelse(nchar(s[[2]]) == 3,
                "532",
                "442"))
}

ndc_formats <- sapply(ndc_codes_split,
                      ndc_get_format)

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
  print(split_code)
  format <- ndc_get_format(split_code)
  print(format)
  return(convert_split_ndc(split_code, format))
}
