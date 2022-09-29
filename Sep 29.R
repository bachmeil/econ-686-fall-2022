library(tstools)
autos <- import.fred("autos-domestic.csv")
start(autos)
end(autos)
dum <- month.dummy(autos, "Jan")
dum
fit <- tsreg(autos, dum)
fit
# one.month: All observations for one month
mean(one.month(autos,1))
mean(one.month(autos,2))
6.39862 + 0.03764
# With only seasonal dummies, returns the average for
# each month
# Detrend and deseasonalize the autos series
rhs <- ts.combine(make.trend(autos), dum)
# Don't combine polynomial time trend and seasonal dummies!

fit <- tsreg(autos, rhs)
fit
autos.filtered <- fit$resids
plot(autos.filtered, main="Detrended and deseasonalized auto sales")

# Upward model selection
gdp <- import.fred("gdpc1.csv")
trend <- make.trend(gdp)
dum <- quarter.dummy(gdp, omit=4)
dum
# Step 1
fit1 <- tsreg(gdp, trend)
fit2 <- tsreg(gdp, dum[, "Q1"])
fit3 <- tsreg(gdp, dum[, "Q2"])
fit4 <- tsreg(gdp, dum[, "Q3"])
AIC(fit1)
AIC(fit2)
AIC(fit3)
AIC(fit4)
# Model 1 is the foundation for step 2
# Step 2
fit5 <- tsreg(gdp, ts.combine(trend, dum[, "Q1"]))
fit6 <- tsreg(gdp, ts.combine(trend, dum[, "Q2"]))
fit7 <- tsreg(gdp, ts.combine(trend, dum[, "Q3"]))
AIC(fit5)
AIC(fit6)
AIC(fit7)
# Model 5 is the foundation for step 3
# Step 3
fit8 <- tsreg(gdp, ts.combine(trend, dum[, c("Q1","Q2")]))
fit9 <- tsreg(gdp, ts.combine(trend, dum[, c("Q1","Q3")]))
AIC(fit8)
AIC(fit9)
# Model 8 is the best
# Step 4
fit10 <- tsreg(gdp, ts.combine(trend, dum))
# Now decide how many predictors
# Model 1, 5, 8, or 10
AIC(fit1)
AIC(fit5)
AIC(fit8)
AIC(fit10)
# Model 1 chosen by upward model selection
# Include only a linear time trend


