library(tstools)
inf <- import.fred("inflation.csv")
# First difference
dinf <- inf - lags(inf, 1)
# Inflation is a rate, so normally take the first difference
plot(dinf)

# Log difference
gdp <- import.fred("gdpc1.csv")
dgdp <- pctChange(gdp)
plot(dgdp)
# What if we took the first difference?
gdp.diff <- gdp - lags(gdp, 1)
plot(window(gdp.diff, end=c(2007,4)))
log(5) - log(4)
5/4 - 1

# Seasonal first difference
dgdp.seasonal <- gdp - lags(gdp, 4)
# Seasonal log difference
dgdp.seasonal2 <- pctChange(gdp, 4)
plot(dgdp.seasonal2)
plot(dgdp.seasonal)

# Basic Dickey-Fuller test
fit <- tsreg(gdp, lags(gdp, 1))
fit
# Calculate the DF statistic
summary(fit)
(1.003389 - 1)/0.001547
# Not less than the critical value of -2.89, so don't reject
# Conclude that GDP has a unit root
# Should take the percentage change
# Redo with inflation
summary(tsreg(inf, lags(inf, 1)))
(0.986704 - 1)/0.005153
# Don't reject because it is not less than -2.89
# Take first difference of inflation
