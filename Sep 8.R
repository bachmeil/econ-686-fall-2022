data.raw <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/gdpc1.csv",
                     header=TRUE)
rgdp <- ts(data.raw[,2], start=c(1947,1), frequency=4)
plot(rgdp)
library(tstools)
# make.trend creates a ts trend with the right time
# period and frequency
rgdp.trend <- make.trend(rgdp)
rgdp.trend
fit <- tsreg(rgdp, rgdp.trend)
fit
length(rgdp)
# 302 observations in the dataset
# Predict observation 303
# Predict Q3 2022
# Fitted value approach
# Doesn't consider latest information
-181 + 60.8*303
# 18.2 Trillion dollars
last(rgdp)
# Our forecast appears to be bad
# Can we account for the recent information?
# Just add 60.8 Billion to Q2 2022 observation
# End of sample approach
# Use this for linear time trend models
19700 + 60.8
# What about Q2 2027?
19700 + 20*60.8
# 20.9 Trillion is our prediction

# Let's plot the fitted and actual values of rgdp
# ts.combine groups the series, matches dates, and removes
# missing observations
plot.data <- ts.combine(fit$fitted, rgdp)
# fit$fitted calculates the prediction for every data point
# in our sample
# plot.type="single" means put them in one plot
# lty=c(2,1) says variable 1 (fitted value) is line type 2
# (dashed) variable 2 (actual rgdp) is line type 1 (solid)
plot(plot.data, plot.type="single", lty=c(2,1))
# Fit at the ends is pretty awful
plot(rgdp)
rgdp1 <- window(rgdp, end=c(1982,4))
rgdp2 <- window(rgdp, start=c(1983,1))
plot(rgdp1)
plot(rgdp2)
tt1 <- make.trend(rgdp1)
fit1 <- tsreg(rgdp1, tt1)
fit1
# In earlier part of sample, avg growth was $37.2 B per quarter
tt2 <- make.trend(rgdp2)
fit2 <- tsreg(rgdp2, tt2)
fit2
# Later part of the sample, avg growth was $80.5B per quarter
# ts.union keeps missing observations
plot2.data <- ts.union(rgdp, fit1$fitted, fit2$fitted)
View(plot2.data)
plot(plot2.data, plot.type="single", lty=c(1,2,2))




