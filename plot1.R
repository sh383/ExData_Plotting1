library(dplyr)
library(data.table)

temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")
con <- unz(temp, "household_power_consumption.txt")
data <- read.table(con, sep=";", header = TRUE, nrows = 70000)
unlink(temp)

data$newdate <- strptime(as.character(data$Date), "%d/%m/%Y")
data$Date <- format(data$newdate, "%Y-%m-%d")

data_2 <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
data_2 <- select(data_2, -newdate)
data_2$Global_active_power <- as.numeric(as.character(data_2$Global_active_power))

par("ps" = 11)
hist(data_2$Global_active_power, main = "Global Active Power", col = "red", xlab = "Global Active Power (kilowatts)")