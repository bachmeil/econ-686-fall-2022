library(tstools)
library(urca)
data(UKpppuip)
attach(UKpppuip)
# UK price index
p1 <- ts(p1)
# World price index
p2 <- ts(p2)
# Multilateral exchange rate
e12 <- ts(e12)
plot(p1)
plot(p2)
plot(e12)
prices.uk <- p1*e12
# These should be equal if you believe in PPP
z <- p2 - prices.uk
# z > 0 => Foreign prices are above equilibrium
# foreign prices should fall
# UK prices should rise
# or both
duk <- diff(prices.uk)
dforeign <- diff(p2)
rhs <- lags(duk %~% dforeign, 1)
fit.uk <- tsreg(duk, rhs)
fit.uk
# VAR equation for UK prices
# Account for cointegration
rhs <- lags(duk %~% dforeign, 1)
