library(tstools)
gdp <- import.fred("gdpc1.csv")

# Random walk with drift
# The usual AR(1) regression
fit <- tsreg(gdp, lags(gdp,1))
summary(fit)
# Coefficient slightly above one
# Cannot conclude beta < 1
# Critical value -2.89
(1.003389 - 1)/0.001547
# Positive so not less than -2.89
# Conclude unit root

# Pure random walk
fit <- tsreg(gdp, lags(gdp,1),
             intercept=FALSE)
summary(fit)
(1.0057007 - 1)/0.0007952
# Critical value is -1.95
# Conclude unit root

# RW with drift and trend
tr <- make.trend(gdp)
fit <- tsreg(gdp, lags(gdp,1) %~% tr)
summary(fit)
(0.985296-1)/0.008396
# Negative but greater than -3.45
# Conclude unit root
# All three give a unit root
# Should difference the data
library(urca)
# Pure random walk ADF test
gdp.adf <- ur.df(y=gdp, type="none",
                 selectlags="AIC")
summary(gdp.adf)
# 7.6 > -1.95 so don't reject
# Conclude unit root

# RW with drift
gdp.adf <- ur.df(y=gdp, type="drift",
                 selectlags="AIC")
summary(gdp.adf)
# 2.56 > -2.87
# Conclude unit root

# RW with drift and trend
gdp.adf <- ur.df(y=gdp, type="trend",
                 selectlags="AIC")
summary(gdp.adf)
# -1.624 > -3.42
# Conclude unit root
# Always find a unit root
# So difference real GDP
# Take percentage change

# Use SIC instead of AIC
gdp.adf <- ur.df(y=gdp, type="trend",
                 selectlags="BIC")
summary(gdp.adf)

# If you know the lag length is 3
gdp.adf <- ur.df(y=gdp, type="trend",
                 selectlags="Fixed",
                 lags=3)
summary(gdp.adf)
# In practice, it probably doesn't matter much
