# find the working directory 
getwd()

# is there any duplicated 
any(duplicated(donors_saf$DONOR_ID))


# missing values 

df %>%
group_by(year) %>%
  summarise(
    across(
      .cols = c(col1, col2), 
      .fns = list(
        Count = ~sum(is.na(.)),
        Percent = ~sum(is.na(.)) / n() * 100
      ),
      .names = "{.col}_{.fn}"
    )




# excel files with multile sheets
library(openxlsx)
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


### Filter inside a filter
df %>%
  filter(yr >= '2021') %>%
  group_by(yr) %>%
  summarise(
    total_rows = n(),
    total_distinct_ids = n_distinct(ID),
    distinct_ids_where_dob_na = n_distinct(ID[!is.na(dob)),
    distinct_ids_where_dob_na_state_NJNY = n_distinct(donor_id[!is.na(dob) & state %in% c('NY', 'NJ')]),
    total_rows_where_dob_na_state_NJNY = sum(!is.na(dob)  & state %in% c('NY', 'NJ')),
  )

    
# group by 
# percent and number
df %>%
  summarize(
    count_of_ones = sum(cat_column == 1),
    total_count = n(),
    percent_of_ones = (count_of_ones / total_count) * 100
  )

df %>%
  mutate(year_col = year(date_col)) %>%
  group_by(year_col) %>% 
  summarise(
    NA_Count = sum(is.na(DCD_cat)),
    Empty_String_Count = sum(DCD_cat == "", na.rm = TRUE)) 


# find the column with this name
df %>%
  select(contains("FIRST", ignore.case = FALSE))


# find common columns in 2 datasets
cols_df1 <- names(df1)
cols_df2 <- names(df2)
intersect(cols_df1, cols_df2)

# gtsummary 
df %>% 
  tbl_summary(
    by = era,
    label = list(
      AGE_VAR ~ 'AGE',
      KDPI_VAR ~ 'KDPI')
  )


# Date time manipulation 
# isolate month from date 
mutate(months = format(
  floor_date(recovery_date, unit = "month"), "%Y-%m")
      )

# isolate quater from date
mutate(quater_col = quarter(recovery_date, with_year = TRUE))


## GGPLOT 
# save ggplot 
ggsave("filename.png", plot = my_plot, device = "png", width = 6, height = 4, units = "in")


p1 <- ggplot(
  table_year, aes(x = year_col, y = recovery_date)) +
  geom_line(linewidth = 0.5)+      # width of line 
  geom_point(size = 0.5)+          # the point size 
  labs(
    title = 'Quaterly Trend of recovery rate by years',
    x = 'years'
  )+ 
  theme_minimal()+
  expand_limits(y = 0)          # start with 0 on y axis 
