library(tstools)
inf <- import.fred("inflation.csv")
wapop <- import.fred("population-wa.csv")
growth.wa <- pctChange(wapop)

# Direct estimation (h-step ahead projection)
# 1-step model
fit1 <- tsreg(inf, lags(inf %~% growth.wa, 1))
fit1
last(inf)
last(growth.wa, 2)
fit1$end
0.02538 + 0.99078*8.48 + 15.71342*0.00005097

# 2-step model
fit2 <- tsreg(inf, lags(inf %~% growth.wa, 2))
fit2
# Forecast inf(T+2), Sep 2022
0.08633 + 0.97329*8.48 + 24.18716*0.00005097

# 3-step model
fit3 <- tsreg(inf, lags(inf %~% growth.wa, 3))
fit3

# How many lags?
# Use the 1-step model to select lag length
# VAR(1), VAR(2), VAR(3)
# Calculate AIC/SIC for each
# Use the lag length with lowest
# VARselect
# 6 lags is best
# 3-step model
tsreg(inf, lags(inf %~% growth.wa, 3:8))
ffr <- import.fred("ffr.csv")
plot(ffr)
rhs <- lags(inf %~% ffr, 1)
fit.inf <- tsreg(inf, rhs)
fit.ffr <- tsreg(ffr, rhs)
fit.inf
fit.ffr
# 1-step inflation forecast
last(inf)
tsobs(ffr, c(2022,7))
0.033008 + 0.988256*8.48 + 0.004078*1.68
# Aug 2022 inflation forecast was 8.42
# 2-step forecast (Sep 2022)
0.033008 + 0.988256*8.42 + 0.004078*3.0
# 3-step forecast (Oct 2022)
0.033008 + 0.988256*8.37 + 0.004078*3.0
# Forecasts conditional on 3% FFR: 8.42, 8.37, 8.32

# Now do FFR=4% scenario
0.033008 + 0.988256*8.42 + 0.004078*4.0
0.033008 + 0.988256*8.37 + 0.004078*4.0
# Forecasts conditional on 4% FFR: 8.42, 8.37, 8.32

# And FFR=5% scenario
0.033008 + 0.988256*8.42 + 0.004078*5.0
0.033008 + 0.988256*8.37 + 0.004078*5.0
# Forecasts conditional on 5% FFR: 8.42, 8.37, 8.33

u <- import.fred("unrate.csv")
rhs <- lags(inf %~% u, 1)
fit.inf <- tsreg(inf, rhs)
fit.inf
0.11943 + 0.98722*8.48 - 0.01333*3.5
# This doesn't adjust inflation for the changes in the
# economy that deliver different unemployment rates.
# Scenario analysis is not helpful.



