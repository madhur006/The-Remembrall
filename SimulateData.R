library(survival)
library(tidyverse)

# constraint and trends 
years <- 2011:2024
n_donors_per_year <- 5000
n_total <- n_donors_per_year * length(years)
n_total

# create a mapping dataframe for trends over time 

trend_map <- data.frame(
  Year = years,
  kdri_trend = c(rep(1.18, 10), seq(1.18, 1.39, length.out = 4)),
  dcd_prob = seq(0.10, 0.60, length.out = length(years))
)

# create the base dataframe 

dd_data <- data.frame(
  Year = rep(years, each = n_donors_per_year),
  DonorID = paste0("D", rep(years, each = n_donors_per_year), "-", 1:n_donors_per_year)
) %>% 
  left_join(trend_map, by = "Year") 

# generate varaibles and outcomes - vectorized 

dd_data <- dd_data %>% 
  # recipeint characteristics - fixed acrsoss years 
  mutate(
    Recipeint_age = round(rnorm(n_total, mean = 55, sd = 8)),
    ReTx = rbinom(n_total, 1, 0.15),
    Diabetes = rbinom(n_total, 1, 0.25),
    DiaysisVintage = round(rnorm(n_total, mean = 2, sd = 1.5)),
    DiaysisVintage = ifelse(DiaysisVintage < 0, 0, DiaysisVintage)
  ) %>%
  # donor characteristics - based on year/trend 
  mutate(
    # donor age : mean increases by 1.5 year after 2011
    DonorAge_Mean = 40 + (Year - 2011) * 1.5,
    DonorAge = round(rnorm(n_total, mean = DonorAge_Mean, sd = 15)),
    # kdri - generated based on the year's trend, ensure min is 0.8 
    meanlog_var = log(kdri_trend/1.1),
    KDRI = rlnorm(n_total, meanlog = meanlog_var, sdlog = 0.3),
    KDRI = ifelse(KDRI < 0.8, 0.8, KDRI),
    
    # DCD status : generated baserd on year's trend prob
    DCD = rbinom(n_total, 1, dcd_prob)
  ) %>% 
  # outcome similation (graft failure)
  mutate(
    base_hazard = 0.05, 
    # calculate hazard ratio for entire 70,000 observations
    hazard_ratio = exp(0.5 * log(KDRI) +
                       0.01 * Recipeint_age+
                         0.4 * ReTx + 
                         0.5 * Diabetes+
                         0.05 * DiaysisVintage),
    SurvivalTime_Uncensored = rexp(n_total, rate=base_hazard*hazard_ratio),
    # censor at 10 years
    GraftSurvivalTime = pmin(SurvivalTime_Uncensored, 10),
    GraftFailure = ifelse(SurvivalTime_Uncensored <= 10, 1, 0)
  ) %>%
  select(DonorID, Year, KDRI, DonorAge, DCD, Recipeint_age, ReTx, Diabetes, DiaysisVintage, 
         ProcurementYear = Year, GraftSurvivalTime, GraftFailure) 





