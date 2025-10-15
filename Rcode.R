# find the working directory 
getwd()

# excel files with multile sheets

excel_data_list <- list(
  "sheetname1" = df1,
  "sheetname2" = df2,
  "sheetname3" = df3
)

write.xlsx(
  x = excel_data_list,
  file = "file.xlsx",
  colNames = TRUE, 
  rowNames = FALSE 
)

# percent and number
df %>%
  summarize(
    count_of_ones = sum(cat_column == 1),
    total_count = n(),
    percent_of_ones = (count_of_ones / total_count) * 100
  )
