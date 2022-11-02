growth.recent <- window(growth.dom, start=c(2022,1))

# ts.union keeps missing observations
# This won't work if you use ts.combine
combined <- ts.union(growth.recent, fcst)
plot(combined, lty=c(1,2),
     plot.type="single")

# How about a scenario forecast?

# Current monetary policy
# Remember to put the last observation as the
# first forecast
scenario1 <- ts(c(last(growth.recent), -0.05, -0.04, -0.03, -0.02), start=c(2022,8), frequency=12)

# Expansionary
scenario2 <- ts(c(last(growth.recent), -0.05, 0, 0.05, 0.10), start=c(2022,8), frequency=12)

# Contractionary
scenario3 <- ts(c(last(growth.recent), -0.05, -0.10, -0.15, -0.20), start=c(2022,8), frequency=12)

# Remember to use ts.union for this
combined <- ts.union(growth.recent,
                     scenario1,
                     scenario2,
                     scenario3)
plot(combined, lty=c(1,2,3,4),
     plot.type="single")
text(2022.75, 0.08, "Expansionary")
text(2022.8, -0.2, "Contractionary")
text(2022.88, -0.06, "Current")

dom <- import.fred("autos-domestic.csv")
dom
start(dom)
end(dom)
frequency(dom)
# Can we store this metadata?
saveRDS(dom, "domestic-autos.RDS")
# rm removes a variable from the workspace
rm(dom)
dom

# Reload the data
dom <- readRDS("domestic-autos.RDS")
dom

# Add your own metadata
# attributes in R
attr(dom, "source") <- "FRED series DOMESTICAUTOS"
dom
attr(dom, "source")
attr(dom, "downloaded by") <- "Lance Bachmeier"
attr(dom, "downloaded by")
attr(dom, "download date") <- "2022-10-31"
attr(dom, "download date")
saveRDS(dom, "domestic-autos.RDS")
# Since it's a binary file and has attributes,
# you have this information and it can't change

# Reading messy data
# Can we read in the salestax.txt data?
st <- read.csv("salestax.txt")
st

# Specify a different separator
st <- read.csv("salestax.txt", sep="\t")
st
class(st[,3])
# Reading the data as a string

# gsub for regular expression replacements
# g for global:  everywhere in the file
# sub for substitution
# Load the data as a big string
st.text <- readLines("salestax.txt")
st.text
# Remove all $
# \\$ is regex for $
st.text1 <- gsub("\\$", "", st.text)
st.text1

# Now do a repeated replacement
st.text2 <- gsub("\\*", "", st.text1)
st.text2

# Remove double tabs and replace with a comma
st.text3 <- gsub("\t\t", ",", st.text2)
st.text3

# Some had a stray space in between
# \\s is whitespace
st.text3 <- gsub("\t\\s*\t", ",", st.text2)
st.text3

# Save the file and read it
cat(st.text3, file="salestax.csv", sep="\n")
# Not quite done!
