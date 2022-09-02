data(mtcars)
mtcars
# Why mtcars$
# Designed for multiple datasets
# Have to specify which dataset
plot(mtcars$mpg, mtcars$cyl)
plot(mtcars$cyl, mtcars$mpg)
# Fix the deceptive range on MPG
plot(mtcars$cyl, mtcars$mpg, ylim=c(0, 40))
# Add a title
plot(mtcars$cyl, mtcars$mpg, ylim=c(0, 40),
     main="Number of cylinders and gas mileage")
# Better labels
plot(mtcars$cyl, mtcars$mpg, ylim=c(0, 40),
     main="Number of cylinders and gas mileage",
     ylab="Miles Per Gallon",
     xlab="Number of Cylinders")
# Bigger labels
plot(mtcars$cyl, mtcars$mpg, ylim=c(0, 40),
     main="Number of cylinders and gas mileage",
     ylab="Miles Per Gallon",
     xlab="Number of Cylinders", cex.lab=1.4)
# Bigger axis tick labels
plot(mtcars$cyl, mtcars$mpg, ylim=c(0, 40),
     main="Number of cylinders and gas mileage",
     ylab="Miles Per Gallon",
     xlab="Number of Cylinders", cex.lab=1.4,
     cex.axis=1.4)
# Bigger title
plot(mtcars$cyl, mtcars$mpg, ylim=c(0, 40),
     main="Number of cylinders and gas mileage",
     ylab="Miles Per Gallon",
     xlab="Number of Cylinders", cex.lab=1.4,
     cex.axis=1.4, cex.main=1.6)
# Read in the data
data.raw <- read.csv("inflation.csv", header=TRUE)
data.raw
# Convert to time series
dcpi <- ts(data.raw[,2], start=c(1948,1), frequency=12)
# Check that it read in correctly
plot(dcpi)
# x-axis is time
# year is the integer value
# Month, quarter, etc. is the decimal part of the x-axis
# Line 1.4 times as thick
plot(dcpi, main="CPI Inflation", lwd=1.4)
# Too thick
plot(dcpi, main="CPI Inflation", lwd=6.4)
# Too thin
plot(dcpi, main="CPI Inflation", lwd=0.1)
# Line type set with lty
plot(dcpi, main="CPI Inflation", lwd=1.4, lty=2)
# Subset of the data
plot(window(dcpi, start=c(2005,1), end=c(2014,12)), 
            main="CPI Inflation", lwd=1.4, lty=2)

# Plot the data
rain <- c(30, 32, 18, 24, 38, 32)
harvest <- c(150, 145, 55, 70, 180, 150)
plot(rain, harvest)
# Set ylim and xlim to a better value
plot(rain, harvest, ylim=c(0, 200), xlim=c(0, 50))
abline(a=0, b=10)
abline(a=-120, b=10)
abline(a=-75, b=7)
lm(harvest ~ rain)







