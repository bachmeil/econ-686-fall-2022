library(tstools)
autos <- import.fred("autos-domestic.csv")
dautos <- pctChange(autos, 12)
plot(dautos)
mean(dautos)

# Estimate an AR(p) model
# Use AIC to choose p
one.aic <- function(p) {
  fit <- tsreg(dautos, lags(dautos, 1:p))
  return(AIC(fit))
}
one.aic(1)
one.aic(2)
# 1:13 is a vector with 1 2 3 ... 13
lapply(1:13, one.aic)
# Equivalent to one.aic(1) one.aic(2) ... one.aic(13)
# Lag 13 gives lowest AIC value
# So use AR(13) model

fit <- tsreg(dautos, lags(dautos,1:13))
fit
last(dautos,13)
# Can we automate the prediction?
coef(fit)
as.numeric(last(dautos,13))
# Drop intercept
betas <- coef(fit)[-1]
# Reverse data so most recent is first
olddata <- rev(as.numeric(last(dautos,13)))
# Do element-by-element multiplication
sum(betas * olddata) - 0.009
fcst <- function(betas, olddata, intercept) {
  return(sum(betas*rev(olddata)) + intercept)
}
fcst(coef(fit)[-1], last(dautos,13), -0.009)
