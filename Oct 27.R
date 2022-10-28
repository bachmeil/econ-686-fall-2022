rgdp <- c(31447, 33181, 30505, 33615, 34319)
labels <- c("France", "Germany", "Italy", "Spain", "UK")
# Matches first value with first label, etc.
pie(rgdp, labels=labels, main="Real GDP per Capita, 2007")
labels <- c("France 31,447", "Germany 33,181", "Italy 30,505", "Spain 33,615", "UK 34,319")
pie(rgdp, labels=labels, main="Real GDP per Capita, 2007")

# Make a table
# Stacked bar chart - don't do this!
dat <- read.table(text="2018 2019 2020 2021 2022
70 68 65 62 60
30 32 35 38 40", header=TRUE)
barplot(as.matrix(dat),
        main="Market Share Over Time")
cars
plot(cars)
plot(cars[, c("dist", "speed")])
lm(cars$dist ~ cars$speed)
abline(a=-17.579, b=3.932)
plot(cars, main="Relationship between car speed and distance to full stop")
plot(cars, main="Relationship between car speed and distance to full stop", sub="Source: Ezekiel (1930)")

# Remove the y axis using yaxt
plot(cars, main="Relationship between car speed and distance to full stop", sub="Source: Ezekiel (1930)", yaxt="n")

# Remove the y axis label
plot(cars, main="Relationship between car speed and distance to full stop", sub="Source: Ezekiel (1930)", yaxt="n", ylab="")

library(tstools)
dom <- import.fred("autos-domestic.csv")
plot(dom)
# Year-over-year change in domestic auto sales
growth.dom <- pctChange(dom, 12)
growth.recent <- window(growth.dom, start=c(2020,1))
plot(growth.recent)
time(growth.recent)
clearDates(time(growth.recent))

# Make a plot with a better x-axis
plot(growth.recent, xaxt="n")
# Label every fourth observation
length(growth.recent)
index <- seq(1, 32, by=4)
index
label.location <- time(growth.recent)[index]
label.location
label.values <- clearDates(label.location)
label.values
# Get rid of useless time label
plot(growth.recent, xaxt="n", xlab="")
axis(1, at=label.location, labels=label.values)
# Make the dates perpendicular
axis(1, at=label.location, labels=label.values,
     las=2)
# Add an informative title
plot(growth.recent, xaxt="n", xlab="",
     main="Year-Over-Year Domestic Auto Sales Growth (%)", ylab="")
axis(1, at=label.location, labels=label.values,
     las=2)
# Set line width 40% larger than the default
plot(growth.recent, xaxt="n", xlab="",
     main="Year-Over-Year Domestic Auto Sales Growth (%)", ylab="", lwd=1.4)
axis(1, at=label.location, labels=label.values,
     las=2)
# Add forecast to the plot
fcst <- ts(c(last(growth.recent), -0.05, -0.04, -0.03, -0.02),
           start=c(2022,8), frequency=12)
growth.mod <- ts(
  c(growth.recent, fcst), start=c(2020,1),
  frequency=12)
plot(growth.mod)
# Make the forecast dashed
# Hack: Plot two lines that show up as one
combined <- ts.union(growth.recent, fcst)
combined
plot(combined, lty=c(1,2),
     plot.type="single")

