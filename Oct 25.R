library(tstools)
inf <- import.fred("inflation.csv")
u <- import.fred("unrate.csv")

# Estimate the AR model
inf.est <- window(inf, end=c(2018,12))
u.est <- window(u, end=c(2018,12))
fit.ar <- tsreg(inf.est, lags(inf.est, 1))
fit.ar

# Write a function to calculate the forecasts for you
arfcst <- function(x) {
  fcst <- 0.04177 + 0.98531*x
  return(fcst)
}
arfcst(3.2)

# Quality of the forecast
# Define by squared forecast error
fit.var <- tsreg(inf.est, lags(inf.est %~% u.est, 1))
fit.var
varfcst <- function(x) {
  inf.lag <- x[1]
  u.lag <- x[2]
  fcst <- 0.13127 + 0.98623*inf.lag - 0.01608*u.lag
  return(fcst)
}
varfcst(c(4.8, 6.2))

validation <- window(lags(inf %~% u, 1), start=c(2019,1))
validation
dim(validation)
# apply: operate on rows or columns of a matrix
forecasts.var <- apply(validation, MARGIN=1, varfcst)
forecasts.var
# Single columns turn into vectors
# so have to add as.matrix
forecasts.ar <- apply(as.matrix(validation[, "infL1"]),
                      MARGIN=1, arfcst)
forecasts.ar

inflation.actual <- window(inf, start=c(2019,1))
length(inflation.actual)
length(forecasts.ar)
# Calculate mean squared forecast errors
mse.var <- mean((inflation.actual - ts(forecasts.var, frequency=12, start=c(2019,1)))^2)
mse.var
mse.ar <- mean((inflation.actual - ts(forecasts.ar, frequency=12, start=c(2019,1)))^2)
mse.ar
# AR model outperforms the Phillips curve
# Unemployment rate does not have predictive ability for
# inflation after 2019 because the VAR model doesn't predict
# better
# Alternative: unemployment rate does not Granger cause
# inflation








