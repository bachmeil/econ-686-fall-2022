# Continuing on with our example from Dec 6
# VAR equation for UK prices
# Account for cointegration
rhs.ecm <- lags(duk %~% dforeign %~% z, 1)
uk.ecm <- tsreg(duk, rhs.ecm)
uk.ecm
world.ecm <- tsreg(dforeign, rhs.ecm)
world.ecm

# Don't know the equilibrium
oil <- import.fred("oilprice.csv")/42
gas <- import.fred("gasprice.csv")
oil
fit <- tsreg(gas, oil)
fit
gas.star <- fit$fitted
plot(gas.star)
plot(gas)
# Compare equilibrium gas price with actual gas price
# for 2022
gas.star.2022 <- window(gas.star, start=c(2022,1))
gas.actual.2022 <- window(gas, start=c(2022,1))
plot(gas.star.2022 %~% gas.actual.2022,
     plot.type="single",
     xaxt="n")


