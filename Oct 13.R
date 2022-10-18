library(tstools)
autos <- import.fred("autos-domestic.csv")
trend <- make.trend(autos)
dum <- month.dummy(autos)
rhs <- ts.combine(trend, dum)
fit <- tsreg(autos, rhs)
autos.dt <- fit$resids
# Estimate ARMA(1,1)
arma1.1 <- arima(autos.dt, order=c(1,0,1))
arma1.1
# Predict for the end of the year
predict(arma1.1, n.ahead=4)
# Get just the predictions, get rid of the clutter
predict(arma1.1, n.ahead=4)$pred
# Can use an alternative function to get the model
# AR lags come first, then MA lags
fit1.1 <- armafit(autos.dt, 1, 1)
# Get the actual model coefficients
fit1.1$par
predict(fit1.1, n.ahead=4)$pred
# Selecting lag length (AR and MA terms jointly)
s <- arma.select(autos.dt, ar=1:3, ma=1:3)
s
s$best
# Best is ARMA(2,3)
fit2.3 <- armafit(autos.dt, 2, 3)
fit2.3$par
predict(fit2.3, n.ahead=4)$pred
# These are the predictions of the model the AIC chose as
# the best.

domestic <- import.fred("autos-domestic.csv")
foreign <- import.fred("autos-foreign.csv")
plot(domestic)
plot(foreign)
# Work with growth rates
growth.dom <- pctChange(domestic)
growth.for <- pctChange(foreign)
rhs <- lags(growth.dom %~% growth.for, 1)
tsreg(growth.dom, rhs)
# Make forecast of Sep 2022
last(growth.dom)
last(growth.for)
-0.00656 - 0.14651*(-0.026) + 0.03559*(0.126)
# Basically predicting no growth for Sep 2022
# Now forecast Oct 2022
tsreg(growth.for, rhs)
# Find the forecast of foreign growth for Sep 2022
# So that we can forecast domestic growth for Oct 2022
-0.003386 - 0.036490*(-0.026) - 0.107316*(0.126)
# -0.0160 is foreign growth prediction for Sep 2022
# Now we can plug in to calculate the Oct 2022 domestic
# forecast
-0.00656 - 0.14651*(0.0017336) + 0.03559*(-0.01595908)

# Package to do VAR estimation and forecasting
library(vars)
# Create the vector of data
dataset <- ts.combine(growth.dom, growth.for)
# Estimate VAR(1) -> 1 lag of each variable
varfit <- VAR(dataset, p=1)
varfit
pred <- predict(varfit, n.ahead=2)
# Just domestic growth predictions
pred$fcst$growth.dom[,"fcst"]







