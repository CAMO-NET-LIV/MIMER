
clean_medication <- function(df,column_name) {
   filtered_df <- df |>
              dplyr::distinct({{column_name}}, .keep_all = FALSE) |>
              dplyr::filter({{column_name}} != "") |>
              dplyr::filter(! stringr::str_detect({{column_name}},"(?!)Desensitization"))

    temp_df_1 = filtered_df |>
                dplyr::mutate(medication_cleaned = trimws({{column_name}}))

    temp_df_2 <-  filtered_df |>
                dplyr::mutate(medication_cleaned = sapply(strsplit({{column_name}}, " "),`[`,1))

    rbind(temp_df_1, temp_df_2 )
}

populate_amr_antibiotics <- function(){
  #Loading Anti-Biotics Data from AMR Package
  df_amr_antibiotics <- as.data.frame(AMR::antibiotics)

  df_amr_antibiotics_lookup <- df_amr_antibiotics |>
    dplyr::select(name, synonyms) |>
    tidyr::unnest(synonyms)

  df_amr_antibiotics_lookup_copy <-  data.frame(name  = dplyr::distinct(df_amr_antibiotics,name, .keep_all = FALSE),
                                                synonyms = dplyr::distinct(df_amr_antibiotics,name, .keep_all = FALSE) )|>
    dplyr::rename("synonyms" =name.1) |>
    dplyr::mutate(synonyms = stringr::str_replace(synonyms," acid",""))

  df_amr_antibiotics_lookup_final <- rbind(df_amr_antibiotics_lookup_copy,df_amr_antibiotics_lookup) |> dplyr::filter(! synonyms=='aminox')

  df_amr_antibiotics_lookup_final

}


add_new_synonyms <- function(amr_df, new_synonyms){
  new_df <- data.frame(name  = names(new_synonyms),
                       synonyms = unname(new_synonyms))

  rbind(amr_df,new_df)
}

get_antibiotics_in_medications <- function (df_medications_cleaned,df_amr_antibiotics_lookup,fuzzy_matching_method){
  df_antibiotics_in_df <- fuzzyjoin::stringdist_inner_join(
    df_medications_cleaned,
    df_amr_antibiotics_lookup,
    by = c("medication_cleaned" = "synonyms"),
    ignore_case = TRUE,
    method=fuzzy_matching_method,
    distance_col = "distance_column"
  ) |>
    dplyr::filter(synonyms != "")

  df_antibiotics_in_df
}

