# Criteria
# 1. Was a valid GitHub URL containing a git repository submitted?
# 2. Does the GitHub repository contain at least one commit beyond
# the original fork?
# 3. Please examine the plot files in the GitHub repository. Do 
# the plot files appear to be of the correct graphics file format?
# 4. Does each plot appear correct?
# 5. Does each set of R code appear to create the reference plot?

# For each plot you should
# Construct the plot and save it to a PNG file with a width of 480 
# pixels and a height of 480 pixels.
# Name each of the plot files as plot1.png, plot2.png, etc.
# Create a separate R code file (plot1.R, plot2.R, etc.) that 
# constructs the corresponding plot, i.e. code in plot1.R constructs 
# the plot1.png plot. Your code file should include code for reading 
# the data so that the plot can be fully reproduced. You should also 
# include the code that creates the PNG file.
# Add the PNG file and R code file to your git repository

# load required libraries
library(lubridate)

# obtain file path
filePath <- paste0(getwd(), "/coursera/household_power_consumption.txt")

# use only 2007-02-01 and 2007-02-02
# typical data pattern: dd/mm/yyyy;hh:min
rowCount <- 60 * 24 * 2 #minutes*hours*days

# read only a portion of the table: 2007-02-01 thru 2007-02-02
dtHPC <- read.table(filePath, sep = ";", na.strings = "?",
                    skip = grep("31/1/2007;23:59", readLines(filePath)), 
                    nrows = rowCount)

# add column names
colnames(dtHPC) <- unlist(strsplit(readLines(filePath, n=1), ";"))

# convert the Date and Time variables to Date/Time classes
dtHPC$Date <- dmy(dtHPC$Date)
dtHPC$DateTime <- strptime(paste(as.Date(dtHPC$Date), dtHPC$Time),
                           format = "%Y-%m-%d %H:%M:%S")

# create plot and save as png
filePath <- paste0(getwd(), "/coursera/ExData_Plotting1/plot3.png")
png(filePath, width = 480, height = 480, units = "px")
with(dtHPC, plot(DateTime, Sub_metering_1, type = "l", xlab = "",
                 ylab = "Energy sub metering"))
# add two other sub metering lines and legend
with(dtHPC, lines(DateTime, Sub_metering_2, col = "red"))
with(dtHPC, lines(DateTime, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()