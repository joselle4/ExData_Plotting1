# Criteria
# 1. Was a valid GitHub URL containing a git repository submitted?
# 2. Does the GitHub repository contain at least one commit beyond
# the original fork?
# 3. Please examine the plot files in the GitHub repository. Do 
# the plot files appear to be of the correct graphics file format?
# 4. Does each plot appear correct?
# 5. Does each set of R code appear to create the reference plot?

# load required libraries
library(lubridate)

# obtain file path
filePath <- paste0(getwd(), "/coursera/household_power_consumption.txt")

# use only 2007-02-01 and 2007-02-02
# typical data pattern: dd/mm/yyyy;hh:min
rowCount <- 60 * 24 * 2 #minutes*hours*days

# read only a portion of the table: 2007-02-01 thru 2007-02-02
dtHPC <- read.table(filePath, sep = ";", 
                    skip = grep("31/1/2007;23:59", readLines(filePath)), 
                    nrows = rowCount)

# add column names
colnames(dtHPC) <- unlist(strsplit(readLines(filePath, n=1), ";"))

# convert the Date and Time variables to Date/Time classes
dtHPC$Date <- mdy(dtHPC$Date)
dtHPC$Time <- hms(dtHPC$Time)
