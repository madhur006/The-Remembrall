# Longitudinal Data: Longitudinal data involves repeated measurements of the same outcome on the same individual (or unit) over time. 
# This creates correlated data, as measurements from the same person are likely more similar to each other than measurements from different people.
# How GEE Handles It: The id=ID argument is the key. By specifying the subject ID, GEE recognizes that all rows with the same ID belong to the same person and are related. 
# GEE estimates the average relationship between the predictor (era_year) and the outcome (outcome_binary) across the entire population, while correctly adjusting the
# standard errors (and thus the confidence intervals and p-values) to account for the within-subject correlation. This makes the results valid despite the non-independent data.
# Modified Poisson regression - Generalized Estimating Equation (GEE)

library(geepack)
model_1 <- geeglm(outcome_binary ~ era_year, data = df,                                       # Generalized Estimating Equation, outcome risk ratio 
                           family = poisson(link = "log"), id=ID) %>% 
  tidy(exponentiate = TRUE, conf.int = TRUE, conf.type="profile")


# Generalized Linear Model, outcome count of txed, models count per unit time, IRR 

model_2 <- glm(count_of_txed ~ era_years +  offset(log(era_days)),                             
                                 family = poisson,                                             
                                 data = df_summary) %>% 
  tidy(exponentiate = TRUE, conf.int = TRUE, conf.type="profile")
