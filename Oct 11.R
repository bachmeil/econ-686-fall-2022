# Estimate an MA model
library(tstools)
autos <- import.fred("autos-domestic.csv")
# Remove the trend and seasonal components
trend <- make.trend(autos)
dum <- month.dummy(autos)
rhs <- ts.combine(trend, dum)
# Regress and take the residuals
fit <- tsreg(autos, rhs)
autos.dt <- fit$resids
# autos.dt is the autos series after removing the trend and
# seasonal component (cyclical component)
# arima estimates models with AR and MA components
# Third element of order is MA lags
ma1 <- arima(autos.dt, order=c(0,0,1))
ma1
# How to get the Aug 2022 forecast error?
# It's the last residual
last(ma1$residuals)
# Sales came in quite low in Aug relative to forecast
# Downgrade our Sep forecast
0.6848*(-1.14)
# Then add the mean in
-0.781 - 0.0015
# Cyclical forecast for Sep 2022
# Haven't accounted for trend or seasonal terms
# Luckily: There's an easier way
predict(ma1, n.ahead=1)
# Drop the clutter
# Grab just the predictions
predict(ma1, n.ahead=1)$pred
# Forecast for the rest of the year
predict(ma1, n.ahead=4)$pred
# MA(1) model says shocks after one period have no effect
# The forecast is the mean for time 2 and higher
ma2 <- arima(autos.dt, order=c(0,0,2))
ma2
predict(ma2, n.ahead=4)$pred
# Lag length selection
one.aic <- function(q) {
  fit <- arima(autos.dt, order=c(0,0,q))
  return(AIC(fit))
}
lapply(1:24, one.aic)
ma13 <- arima(autos.dt, order=c(0,0,13))
# Use this for predicting the cyclical component
predict(ma13, n.ahead=4)$pred
# Car forecasts are not great the rest of the year
# Can estimate AR models too
ar4 <- arima(autos.dt, order=c(4,0,0))
predict(ar4, n.ahead=4)$pred
# AR forecasts are somewhat more pessimistic than the MA
