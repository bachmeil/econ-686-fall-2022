# Get all July sales
# Impose condition limiting to just that month
july.sales <- dbGetQuery(db.sales, "select * from salesdb1 where month='201807'")
# This is an R data frame
july.sales

# Multiple conditions
# June and July sales
jun_jul <- dbGetQuery(db.sales, "select * from salesdb1 where month='201806' OR month='201807'")
jun_jul
jun_jul <- dbGetQuery(db.sales, "select * from salesdb1 where month<='201807'")
jun_jul

# Problem: Databases have many variables
dbGetQuery(db.sales, "select month, customer, amount from salesdb1")
# as to change report name
dbGetQuery(db.sales, "select month as 'Month', customer as Customer, amount as 'Sales Units (Not $)' from salesdb1")

# Sort by sales
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by amount")
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by amount DESC")
# Multiple sorting criteria
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by customer, amount DESC")

# Limit number in report
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 order by amount DESC LIMIT 4")

# That's limited: total sales identify the best customers
# Not largest individual sales
# Need a method for aggregating data in some way
dbGetQuery(db.sales, "select month, customer, amount from salesdb1 group by customer")
# Have to tell it how to group the data
dbGetQuery(db.sales, "select month, customer, sum(amount) from salesdb1 group by customer")
# sum is an aggregation function
# Without an aggregation function, group by reports the first observation

# Now sort the data
dbGetQuery(db.sales, "select customer, sum(amount) from salesdb1 group by customer order by sum(amount) DESC")

# Joins
# Flat 6% commission on all sales
# Price changed June -> July
revenue <- dbGetQuery(db.sales, "select * from salesdb1 join salesdb2 on salesdb1.month=salesdb2.month")
revenue
# Revenue is a data frame in R
# We need to put it in the SQLite database for further queries
# Create a new table to store the joined data
# name: Name of table inside the database
dbWriteTable(conn=db.sales, name="salesdb3", revenue,
             overwrite=TRUE, row.names=FALSE)
# Gives error - can't have two columns with same name
# Get rid of the duplicate
rev <- revenue[, -5]
rev
dbWriteTable(conn=db.sales, name="salesdb3", rev,
             overwrite=TRUE, row.names=FALSE)
dbGetQuery(db.sales, "select * from salesdb3")
# 1. Calculate revenue per sale
# 2. Total commission per employee over all three months
# sum is an aggregation function, so need a group by
# Can do the commission calculation for each
comm <- dbGetQuery(db.sales, "select employee, sum(0.06*amount*price) as commission from salesdb3 group by employee")
comm
salestax <- dbGetQuery(db.sales, "select sum(amount*price*salestax) from salesdb3")
salestax
# No group by, so do the aggregation (sum) for all rows
tasks <- c('{"desc":"Homework 1","due":"2022-11-22"}',
           '{"desc":"Homework 2","due":"2022-12-02"}')
tasks
# Create a table holding task information
dbWriteTable(conn=db.sales, name="tasksdb", data.frame(tasks), overwrite=TRUE, row.names=FALSE)
dbGetQuery(db.sales, "select * from tasksdb")
dbGetQuery(db.sales, "select tasksdb.tasks->>'$.desc' from tasksdb where tasksdb.tasks->>'$.due' <= '2022-11-30'")
