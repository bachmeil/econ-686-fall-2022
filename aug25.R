data.raw <- read.csv("https://raw.githubusercontent.com/bachmeil/econ-686-fall-2022/main/inflation.csv", header=TRUE)
data.raw
dim(data.raw)
class(data.raw)
names(data.raw)
names(data.raw) <- c("date", "dcpi")

# First five observations of inflation
data.raw[1:5, "dcpi"]
data.raw[,"dcpi"]

# Create variable with time series properties of inflation
# Starts in Jan 1948, monthly data
dcpi <- ts(data.raw[,"dcpi"], start=c(1948,1), frequency=12)
# Don't do this
dcpi <- ts(data.raw[,"dcpi"], start=c(1948,1), end=c(2022,7))
dcpi

mean(dcpi)
plot(dcpi)
# window -> select part of the sample
mean(window(dcpi, start=c(1990,1)))
mean(window(dcpi, start=c(1990,1), end=c(2019,12)))
plot(window(dcpi, start=c(2000,1), end=c(2014,12)))
