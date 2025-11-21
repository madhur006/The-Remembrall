# find the working directory 
getwd()
df1 <- readxl::read_excel("file1.xlsx", sheet=1, guess_max=500000) 


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



  df %>%
  summarise(
    across(
      .cols = c(col1),
      .fns = list(
        NA_Percent = ~sum(is.na(.))/n() * 100,
        Mean = ~mean(., na.rm = TRUE),
        Median = ~median(., na.rm = TRUE),
        SD = ~sd(., na.rm = TRUE),
        Min = ~min(., na.rm = TRUE),
        Max = ~max(., na.rm = TRUE)
      )
    )
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


  # filter rows where TEST is not in first name 
  df1 <- df %>%
  filter(!(
    (grepl("TEST", toupper(firstname)))))

    

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
    percent_of_ones = (count_of_ones / total_count) * 100,
    yes_dcd_txed = sum(col1[!is.na(dob) & state %in% c("NJ", "NY")] == '1', na.rm = TRUE)
  )

df %>%
  summarize(
    age_25 = quantile(age, probs = 0.25, na.rm = TRUE), 
    age_50 = quantile(age, probs = 0.50, na.rm =  TRUE),
    age_75 = quantile(age, probs = 0.75, na.rm = TRUE), 
  )
                                              

                                              
df %>%
  mutate(year_col = year(date_col)) %>%
  group_by(year_col) %>% 
  summarise(
    NA_Count = sum(is.na(col1)),
    Empty_String_Count = sum(col1 == "", na.rm = TRUE)) 


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



# gt summary 
                                              

table_1 <- df %>% 
  tbl_summary(
    by = era,
    type = list(BMI ~ "continuous"),
    statistic = list(
      all_continuous() ~ '{median} ({p25}, {p75})',
      all_categorical() ~ '{n} ({p}%)'
    ),
    label = list(
      AGE_ ~ "AGE",
      AGE_CATEGORY ~ "AGE CATEGORY",
      BMI ~ "BMI",
      GENDER ~ "GENDER",
      Hypertension_h ~ "HYPERTENSION",
      high_risk ~ 'HIGH RISK',
      high_risk_sum ~ 'HIGH RISK SUM'
    )
    #   missing = 'no'
  ) %>% 
  add_overall() %>% 
  #modify_header(label ~ '**Variables**') %>% 
  bold_labels() %>% 
  modify_caption("**Title of the Table**") %>% 
  as_gt()


                                              

# Date time manipulation 
# isolate month from date 
mutate(months = format(
  floor_date(recovery_date, unit = "month"), "%Y-%m")
      )

# isolate quater from date
mutate(quater_col = quarter(recovery_date, with_year = TRUE))

# MUTATE - case when : new variable based on old one 
# convert not sure into NA by using case when 
df1 <- df %>% 
  mutate(col_new = 
           case_when(
             col == 'Not sure' ~ NA_character_,
             TRUE ~ col
           ))
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


# add rows 
df <- df %>% 
  add_row(ID = 20, Name = "MN") %>% 
  add_row(ID = 25, Name = "TX") %>% 
  add_row(ID = 35, Name = "NY")

# convert to wider df
df %>%
  group_by(city) %>% 
  count(steps) %>% 
  pivot_wider(
    names_from = city, 
    values_from = n
  ) 


                                              
