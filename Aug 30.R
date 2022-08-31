# Loss function
# Best possible forecast
# Better forecast
# forecast -> decision -> outcome -> loss
# Loss of your forecast vs best forecast
# Best forecast: zero loss
# Better forecast: lower loss

# Hot dog vendor
# Forecast: sales
# Too many: Ruin inventory
# Too few: Lost sales
vendor.loss <- function(M, F) {
  M*0.50 + F*1.50
}
# M and F: Arguments
# M and F: Local to the function (can have those variable names)
#   elsewhere in your program
# M: Number of excess hot dogs
# F: Too few hot dogs
# 50 cents cost for extra hot dog
# $1.50 lost profit from too few hot dogs
vendor.loss(0, 0)
vendor.loss(100, 0)
vendor.loss(0, 100)
# Asymmetric loss function
# Same size error, different sign => different loss
# Loss function specific to the problem

# Have to repay loan shark $5000
vendor2.loss <- function(s) {
  if (s < 5000) {
    return(Inf)
  } else {
    return(5000 - s)
  }
}
vendor2.loss(1500)
vendor2.loss(4999)
vendor2.loss(5000)
vendor2.loss(6500)
# s: sales for the day
# Prior to $5000 -> doesn't matter what sales are cause you can't
# repay the loan
# Above $5000 -> More sales better => lower loss
# Real world -> bankruptcy, lost employment

# Asymmetric loss -> how relevant?
# Degree profits are high
# Degree profits are low
# Somewhere in the middle
# Capturing asymmetry probably not that important
# Symmetric loss usually good enough
# Easier to work with symmetric loss functions
vendor3.loss <- function(s, f) {
  (s - f)^2
}
# Quadratic loss
# s: Hot dogs sold
# f: Forecast
# Rainy weather: Sales very bad
# School event: Sales really good
vendor3.loss(100, 100)
vendor3.loss(100, 120)
vendor3.loss(100, 80)
vendor3.loss(100, 140)
# Penalize forecast error of +20 and -20 the same
# Penalize forecasts error of +40 four times +20
# Why? Because this is convenient
# And: Might be hard to figure out a mathematical loss function


# Information set
# Naive: Most recent value
# Seasonal average: Value of average first quarter growth
# More data: Don't rely on oddball values
# Small data: Irrelevant variables *look like* they 
# provide information
# And avoid different environment.
# Cable TV
# Data on car sales or data on truck sales

# R data structures
# vector
v <- c(1.7, 8.4, 9.2, 1.1)
v
# Indexing
# Starts at 1
v[1]
v[4]
# number of observations
length(v)
# Slicing
v[2:3]
v[2:5]
mean(v[2:5])
# Set elements
v[2] <- 1.7
v
# Set all elements
v[] <- 1.7
v
# Redefine v rather than changing all the elements
v <- 1.7
v

# Matrix
# ncol is number of columns to create
# Fills by column
m <- matrix(1:9, ncol=3)
m
# Indexing
m[1,1]
m[1, 2:3]
# Changes to a vector
is.vector(m[1, 2:3])
is.matrix(m[1, 2:3])
# To change all elements of the matrix
m[,] <- 4.2
m

# List
# Heterogenous data structure
# Don't always have one type of data
# time series
# m is monthly data starting in Jan 2010
ll <- list(m, 12, c(2010,1))
ll
names(ll)
# Give the variables names
names(ll) <- c("m", "frequency", "start")
ll
ll$m
ll[["m"]]
names(ll) <- c("m", "f+^%$", "start")
ll
ll$`f+^%$`
names(ll) <- c("m", "f[2010,1]", "start")
ll$`f[2010,1]`
ll[["f[2010,1]"]]
