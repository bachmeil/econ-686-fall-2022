# Download the zip from Github
#   (Check Canvas if you need the link)
# Upload
# Restart R
# import.fred function
# Default csv format
# Monthly, Quarterly, Annual
library(tstools)
dom <- import.fred("autos-domestic.csv")
dom
ecom <- import.fred("ecommerce.csv")
plot(ecom, main="Online Sales")
frequency(ecom)
pop65 <- import.fred("population-65-plus.csv")
frequency(pop65)
# Sales of domestic autos
plot(dom, main="Sales of Domestic Autos")
# Why are they declining?
dom86 <- window(dom, start=c(1986,1))
plot(dom86, main="Sales of Domestic Autos After 1986")
dom86.trend <- make.trend(dom86)
dom86.trend
fit <- tsreg(dom86, dom86.trend)
fit
# Losing 10,000 sales per month on average
# 35*12*10,000=4,200,000
# Movement to foreign autos?
foreign <- import.fred("autos-foreign.csv")
mean(dom)
mean(foreign)
plot(foreign, main="Foreign Auto Sales")
foreign88 <- window(foreign, start=c(1988,1))
plot(foreign88, main="Foreign Auto Sales After 1988")
foreign88.trend <- make.trend(foreign88)
tsreg(foreign88, foreign88.trend)
# Falling 2000 per month
# Can't explain the decline of domestic auto sales
# Total vehicle sales
vehicles <- import.fred("vehicles.csv")
plot(vehicles, main="Total US Vehicle Sales")
vehicles.trend <- make.trend(vehicles)
tsreg(vehicles, vehicles.trend)
# +5000 sales per month
# Truck sales
trucks <- import.fred("trucks-domestic.csv")
plot(trucks, main="US Sales of Domestic Trucks")
# Could be an answer
# Check if big enough magnitude
trucks.trend <- make.trend(trucks)
tsreg(trucks, trucks.trend)
# 12,000 units more sold per month
# Story about preferences

# Online sales
# Sales taxes
# Percentage of sales online
mean(ecom)
last(ecom)
ecom.trend <- make.trend(ecom)
tsreg(ecom, ecom.trend)
# +0.15
# Each quarter, on average, 0.15 percentage points
# more sales take place online
# 3.00% -> 3.15% -> 3.30%
# 14.5% most recent
# In 2032
14.5 + 0.15*40
14.5 + 0.15*400
# Labor market trends
wapop <- import.fred("population-wa.csv")
plot(wapop, main="WA Population")
wapop.trend <- make.trend(wapop)
tsreg(wapop, wapop.trend)
wapop17 <- window(wapop, start=c(2017,1))
wapop17.trend <- make.trend(wapop17)
tsreg(wapop17, wapop17.trend)

college <- import.fred("lf-college.csv")
plot(college, main="College Educated Labor Force")
college.trend <- make.trend(college)
tsreg(college, college.trend)

plot(pop65, main="Share of Population Over 65")
pop65.trend <- make.trend(pop65)
tsreg(pop65, pop65.trend)
# +0.1 percentage points each year
# 60*0.1 = 6 percentage points
# 20 more years
# 20*0.1 = 2 percentage points
last(pop65)
# 100*0.1 = 10
pop65.2008 <- window(pop65, start=2008)
pop65.2008.trend <- make.trend(pop65.2008)
tsreg(pop65.2008, pop65.2008.trend)
# 20*0.35 = 7 percentage points
# 24% of population over 65







