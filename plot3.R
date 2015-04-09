#Read table from txt
data<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", colClasses = "character" )

#Convert data character to data
data$Date<-as.Date(data$Date, "%d/%m/%Y")

#Subset data for selected date range
range<-data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")
data<-data[range,]

#Create DateTime variable
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S", tz="EST")

#Output graph to png
png( file ="plot3.png",width  = 480,height = 480)

with(data, plot(DateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", main = ""))
with(data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, col = c("black", "red", "blue"))

dev.off()