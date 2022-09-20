library(tstools)
gdp <- import.fred("gdpc1.csv")
plot(gdp)
gdp.trend <- make.trend(gdp)
tsreg(gdp, gdp.trend, end=c(1982,4))
# Growing $37 billion per quarter on average
tsreg(gdp, gdp.trend, start=c(1983,1))
# Growing $80 billion per quarter on average
# Curvature
gdp.trend2 <- gdp.trend^2
gdp.trend2
rhs <- ts.combine(gdp.trend, gdp.trend2)
rhs
tsreg(gdp, rhs)
mean(gdp.trend)
mean(gdp.trend2)
20*151.5
0.13*30552
trends <- make.trend(gdp, 3)
trends
tsreg(gdp, trends)
mean(trends[,3])
# Forecasting
# Fitted value
trend.fitted <- 2314 + 3.126 * gdp.trend +
  0.2741*(gdp.trend^2) +
  -0.0003073*(gdp.trend^3)
plot(trend.fitted)
# Get the next observation number
last(gdp.trend)
# Forecast observation 303
2314 + 3.126 * 303 +
  0.2741*(303^2) +
  -0.0003073*(303^3)
last(gdp)
# Fitted value approach doesn't account for
# latest information
# End of sample approach
# Calculate trend value at 302
# See how it changes for 303
2314 + 3.126 * 302 +
  0.2741*(302^2) +
  -0.0003073*(302^3)
# Trend changes by
19877.51 - 19792.92
# Increasing by 84.59
# Add this to last value of GDP
last(gdp)
19699.47 + 84.59
# Much lower than the fitted value forecast

# Estimate all three models
# Compute AIC for each
linear <- tsreg(gdp, gdp.trend)
quadratic <- tsreg(gdp, make.trend(gdp,2))
quadratic
cubic <- tsreg(gdp, make.trend(gdp,3))
cubic
AIC(linear)
# Don't interpret that
AIC(quadratic)
AIC(cubic)
# AIC says the cubic trend model is the best
# for forecasting
BIC(linear)
BIC(quadratic)
BIC(cubic)
# Both criteria choose the cubic model
plot(gdp)
trends
