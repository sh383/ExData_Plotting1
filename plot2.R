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

data_2$newtime <- as.POSIXct(paste(data_2$Date, data_2$Time), format="%Y-%m-%d %H:%M:%S")

par("ps" = 11)

plot(data_2$newtime, data_2$Global_active_power, type = "n", xlab="", ylab="Global Active Power (kilowatts)")
axis(1, at = c(data_2$newtime[1], data_2$newtime[1440], data_2$newtime[2880]), labels = c("Thu","Fri","Sat"))
lines(data_2$newtime, data_2$Global_active_power)