cubic.trend <- function(obs) {
  return(48.8 - 41.7*obs + 24.05*(obs^2) - 3.65*(obs^3))
}
cubic.trend(1)
cubic.trend(2)
cubic.trend(3)
cubic.trend(4)
cubic.trend(5)
cubic.trend(6)

library(tstools)
# Load GDP data
gdp <- import.fred("gdpc1.csv")
# Create trend terms
trends <- make.trend(gdp, 3)
trends
# Estimate cubic trend model
tsreg(gdp, trends)
# Get last date in our sample
end(gdp)

# Estimate cubic trend model through 2021Q4
tsreg(gdp, trends, end=c(2021,4))
# Predict 2022Q1 and 2022Q2
# Predicting observation numbers 301 and 302
2.313 + 3.18*301 + 0.2736*(301^2) - 0.0003059*(301^3)
2.313 + 3.18*302 + 0.2736*(302^2) - 0.0003059*(302^3)
last(gdp,2)
# Decide if that model looks dangerous to use
# Compare with linear and quadratic models

wapop <- import.fred("population-wa.csv")
frequency(wapop)
plot(wapop)
plot(window(wapop, start=c(2016,1)))
plot(window(wapop, start=c(2010,1), end=c(2016,1)))

# Why would we have a change in the trend?
# Real GDP grows 3% per year
# Starts at 100
100*(1.03^20)
100*(1.03^40)
100*(1.03^60)
100*(1.03^80)
100*(1.03^100)
1921 - 1064
180 - 100
# Much larger base for technology to increase
log(100*(1.03^20))
log(100*(1.03^40))
log(100*(1.03^60))
log(100*(1.03^80))
log(100*(1.03^100))
7.56 - 6.97
5.79 - 5.20
gdp <- import.fred("gdpc1.csv")
plot(gdp)
plot(log(gdp))
# Solution: Take the natural log of the variable

# Detrend GDP series
fit <- tsreg(gdp, trends)
fit
# Trend series is the predicted component
plot(fit$fitted)
bc <- gdp - fit$fitted
plot(bc)
plot(fit$resids)
# Detrending: Get the residuals of a time trend model

autos <- import.fred("autos-domestic.csv")
plot(autos)
# Dog tooth shape in plot
plot(window(autos, start=c(2010,1), end=c(2019,12)))
autos17 <- window(autos, start=c(2017,1), end=c(2017,12))
# Deviation from mean
m <- mean(autos17)
m
autos17 - m

