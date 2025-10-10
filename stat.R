# survival analysis 
# waitlist morrtality - death or removal for deteriorating condition - among people waiting for liver transplany 
library(survival)
library(survey)

# create cause specific survival object
# transplany censored
df <- df %>% mutate(event_cause = ifelse(death_removal == 1,1,0),
                   time_wait_yrs = time_wait/365.25)

# compute weights to balance groups on age, .....
library(twang)

ps_model <- glm(outcome ~ age + sex+meld_cat+center, data = df, family = binomial)

df$weight <- ifelse(df$outcome == 1,
                   1 / fitted(ps_model),
                   1 / (1-fitted(ps_model))
                    )

# weighted KM curve 
svy_design <- svydesign(ids = !1, data=df. weights = ~weight)

km_weighted <- svykm(Surv(time_wait_yrs, event_cause) ~ hope,
                    design = svy_design)

plot(km_weighted, xlab = 'years since listing', 
    ylab = 'survival probability (no death/removal)',
    lty = 1:2, col = c('blue', 'red'))
legend('bottomleft', legend = c('Non-HOPE', 'HOPE'), col = c('blue', 'red'), lty = 1:2)

# Competing risks analysis of all waitlist outcomes
# if we are no longer looking only at death/removal, but all possible outcomes that a liver transplant candidate may experience while on the waitlist 

# Fine-Gray and cumulative incidence 
library(cmprsk)

# ftime = followup time, fstatus = event code, group = hope
ci <- cuminc(ftime = df$time_wait, 
            fstatus = df$event_type,
            group = df$hope)

plot(ci, lty = 1:2, col = c("blue", "red", "green"))
legend("topleft",
      legend = names(ci),
      col = c("blue", "red", "green"),
      lty = 1:2)

# fine-gray regression (to test statistical difference)

fg_ddlt <- crr(ftime = df$time_wait, 
              fstatus = df$event_tpye, 
              cov1 = data.frame(hope = df$hope),
              failcode = 1, 
              cencode = 0)
summary(fg_ddlt)
