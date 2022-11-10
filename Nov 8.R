inf <- import.fred("inflation.csv")
# Check that start and end dates are what you expect
start(inf) == c(1948,1)
end(inf) == c(2022,7)
ts.check(inf, list(c(1948,1), c(2022,7),
                   c(1980,1), c(2000,1)),
         c(10.24209, 8.48213, 13.86861, 2.79296))
# Catch most small errors with this plus plotting

# Query database
tasks <- read.csv("tasks.csv")
# Overdue tasks
query <- tasks[, "date"] < "11-08"
tasks[query,]
# Create a new sqlite database
# Using sqlite from within R
library(sqldf)

# Create a schema
# Name of table (equivalent of one csv file)
# variable name
# variable type
# Querying: select
# select [what you want] from [table name]
# select [item, date] from [tasks] where class='536';
# select item, date from tasks where class='536' and date > '2018-10-16';
# How many items remain this semester in 536?
# select count(item) from tasks where class='536' and date > '2018-10-16';
# R library to interact with sqlite
library(sqldf)
# Load the data into R
sales1 <- read.csv("sales1.csv")
sales2 <- read.csv("sales2.csv")

# Create a database connection
db.sales <- dbConnect(SQLite(), dbname="sales.sqlite")

# Add a new table
# dbWriteTable is a function to make changes
# Name of new database table is salesdb1
# sales1 is R data
# overwrite means to force changes to make it work
dbWriteTable(conn=db.sales, name="salesdb1", sales1, overwrite=TRUE, row.names=FALSE)
dbWriteTable(conn=db.sales, name="salesdb2", sales2, overwrite=TRUE, row.names=FALSE)

# select
# dbGetQuery to do that
dbGetQuery(db.sales, "select * from salesdb1")
# Salespeople, customer, amount of sale
dbGetQuery(db.sales, "select * from salesdb2")
# Hold the data in an R variable
s2 <- dbGetQuery(db.sales, "select * from salesdb2")
class(s2)
s2
# Can use s2 like any other dataset








