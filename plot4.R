temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", temp, method="curl")
con <- unz(temp, "household_power_consumption.txt")
data <- read.table(con, sep=";", header = TRUE, nrows = 70000)
unlink(temp)

data$newdate <- strptime(as.character(data$Date), "%d/%m/%Y")
data$Date <- format(data$newdate, "%Y-%m-%d")

data_2 <- subset(data, Date == as.Date("2007-02-01") | Date == as.Date("2007-02-02"))
data_2 <- select(data_2, -newdate)
data_2$newtime <- as.POSIXct(paste(data_2$Date, data_2$Time), format="%Y-%m-%d %H:%M:%S")

for(i in 7:9){
        data_2[,i] <- as.numeric(as.character(data_2[,i]))
}
data_2$Global_active_power <- as.numeric(as.character(data_2$Global_active_power))
data_2$Global_reactive_power <- as.numeric(as.character(data_2$Global_reactive_power))
data_2$Voltage <- as.numeric(as.character(data_2$Voltage))

par(mfrow = c(2,2),ps = 14, mar=c(4,4,2,1),mgp = c(2.5,1,0))

## first plot
plot(data_2$newtime, data_2$Global_active_power, type = "n", xlab="", ylab="Global Active Power")
axis(1, at = c(data_2$newtime[1], data_2$newtime[1440], data_2$newtime[2880]), labels = c("Thu","Fri","Sat"))
lines(data_2$newtime, data_2$Global_active_power)
## second plot
plot(data_2$newtime, data_2$Voltage, type = "n", xlab="datetime", ylab="Voltage")
axis(1, at = c(data_2$newtime[1], data_2$newtime[1440], data_2$newtime[2880]), labels = c("Thu","Fri","Sat"))
lines(data_2$newtime, data_2$Voltage)
## third plot
plot(data_2$newtime, data_2$Sub_metering_1, type = "n", xlab="", ylab="Energy sub metering")
axis(1, at = c(data_2$newtime[1], data_2$newtime[1440], data_2$newtime[2880]), labels = c("Thu","Fri","Sat"))
lines(data_2$newtime, data_2$Sub_metering_1)
lines(data_2$newtime, data_2$Sub_metering_2, col = "red")
lines(data_2$newtime, data_2$Sub_metering_3, col = "blue")
legend("topright",bty = "n" ,lty = c(1,1,1), col = c("black","red","blue"), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), cex = 0.75)
## fourth plot
plot(data_2$newtime, data_2$Global_reactive_power, type = "n", xlab="datetime", ylab="Global_reactive_power")
axis(1, at = c(data_2$newtime[1], data_2$newtime[1440], data_2$newtime[2880]), labels = c("Thu","Fri","Sat"))
lines(data_2$newtime, data_2$Global_reactive_power)