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
