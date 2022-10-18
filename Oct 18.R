library(tstools)
domestic <- import.fred("autos-domestic.csv")
foreign <- import.fred("autos-foreign.csv")
growth.dom <- pctChange(domestic)
growth.for <- pctChange(foreign)
library(vars)
dataset <- ts.combine(growth.dom, growth.for)
# VAR(1) specified by p=1, 1 lag for each variable
varfit <- VAR(dataset, p=1)
# Estimated equations
varfit
# Forecast two steps after the sample ends
pred <- predict(varfit, n.ahead=2)
pred
# Pull out just the forecasts you want
# Forecast of growth.dom, 1-step by default
var.fcsts(varfit, "growth.dom")
# Same thing specifying variable 1 (but don't do that)
var.fcsts(varfit, 1)
# 12 steps ahead
# Explicitly specify forecasts 1 through 12
var.fcsts(varfit, "growth.dom", 1:12)
# Forecast only T+12
var.fcsts(varfit, "growth.dom", 12)
last(dataset)
# Dataset ends in Aug 2022
f <- var.fcsts(varfit, "growth.dom", 1:12, c(2022,9), 
          c(2023,8))
plot(f)
# Look at some correlations
data1 <- growth.dom %~% lags(growth.for, 1)
cor(data1)
# Correlation is -0.03 at one month horizon
data1.1 <- growth.for %~% lags(growth.dom, 1)
cor(data1.1)
data12 <- growth.dom %~% lags(growth.for, 12)
cor(data12)
data12.1 <- growth.for %~% lags(growth.for, 12)
cor(data12.1)
# Cross-correlation function
ccf(growth.dom, growth.for)
# We care about moving to the right
# If you want the numbers
ccf(growth.dom, growth.for, plot=FALSE)
# Lag length selection
# Different form to account for the full system of
# equations
# That exists (AIC, SIC)
VARselect(dataset)
# Used 10 lags max
VARselect(dataset, lag.max=13)
# If you want this in a programmatic fashion
p.best <- VARselect(dataset, lag.max=13)$selection["AIC(n)"]
varfit <- VAR(dataset, p=p.best)
varfit

# Working age population growth and inflation
inf <- import.fred("inflation.csv")
wapop <- import.fred("population-wa.csv")
plot(wapop)
growth.wa <- pctChange(wapop)
plot(growth.wa)
arma.select(inf, ar=1:6, ma=1:6)
arma66 <- arima(inf, order=c(6,0,6))
arma.pred <- predict(arma66, n.ahead=12)$pred
dataset <- ts.combine(inf, growth.wa)
VARselect(dataset, lag.max=13)
varfit <- VAR(dataset, p=2)
last(dataset)
last(inf)
var.pred <- var.fcsts(varfit, "inf", 1:12, c(2022,8),
                      c(2022,7))
var.pred
ts.combine(arma.pred, var.pred)

