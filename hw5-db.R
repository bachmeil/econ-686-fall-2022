testdata1 <- read.csv("testdata1.csv", header=TRUE)
testdata2 <- read.csv("testdata2.csv", header=TRUE)
library(sqldf)
db <- dbConnect(SQLite(), dbname="test.sqlite")
dbWriteTable(conn=db, name="test1", testdata1, overwrite=TRUE, row.names=FALSE)
dbWriteTable(conn=db, name="test2", testdata2, overwrite=TRUE, row.names=FALSE)
dbGetQuery(db, "select name from test1 where age > 30")
dbGetQuery(db, "select avg(income) from test1 join test2 on test1.name=test2.name where age > 30")
58400+74000+23400+91000+31500
278300/5
