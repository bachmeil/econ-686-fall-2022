# Read in the csv data
# Doesn't know anything about ts properties
# Just a bunch of numbers
st <- read.csv("salestax.csv")
st
class(st[,2])
# In luck, it's reading as numbers
# Stack the data so 1983 is first, 1984 below, ...
# Remove first and last columns
# Then reshape to a vector
# Then give it ts properties
# Drop missing observations if needed
dim(st)
# Need columns 2..33
class(st[, 2:33])
# Data frame prints like a matrix, but it's not a matrix
# It's a list with same number of observations
# as.matrix
st.mat <- as.matrix(st[, 2:33])
st.mat

# Now stack the columns
m <- matrix(1:9, ncol=3)
m
as.vector(m)
# as.vector stacks matrix elements into a vector by column
t(m)
as.vector(t(m))
# But that's not for this data
st.vector <- as.vector(st.mat)
st.vector
# Definitely want to confirm it did things correctly.
st.data <- ts(st.vector, start=c(1983,1), frequency=12)
st.data
plot(st.data)

# Chopping data
library(tstools)
first(1:9, 2)
drop_first(1:9, 2)
last(1:9, 4)
drop_last(1:9, 3)

# Get rid of the two missing values at the end
salestax <- drop_last(st.data, 2)
salestax
plot(salestax)

attr(salestax, "raw data source") <- "salestax.txt from George Smith's email to Lance Bachmeier on Dec 15 2020"
attr(salestax, "data cleaned by") <- "Lance Bachmeier"
saveRDS(salestax, "salestax.RDS")

rm(salestax)
salestax
salestax <- readRDS("salestax.RDS")
salestax
plot(salestax)
attributes(salestax)

1.34 == 1.34
1.24 == 1.19 + 0.05
1.324 == 1.319 + 0.005
1.319 + 0.005
# The 1.324 that is printed is an approximation of what is in
# the computer
all.equal(1.324, 1.319+0.005)
a <- 1000000000000
all.equal(a*1.324, a*(1.319+0.005))

pop65 <- import.fred("population-65-plus.csv")
popwa <- import.fred("population-wa.csv")
college <- import.fred("lf-college.csv")
college.pct <- 1000*college/popwa
plot(college.pct)
# Did this work correctly?
# Have to convert ts to a number
all.equal(as.numeric(tsobs(college.pct, c(2000,1))),
          23625*1000/178282552.324166,
          check.attributes=FALSE)
college.pct



