#Read table from txt
data<-read.table("household_power_consumption.txt", header=TRUE, sep = ";", colClasses = "character" )

#Convert data character to data
data$Date<-as.Date(data$Date, "%d/%m/%Y")

#Subset data for selected date range
range<-data$Date >= as.Date("2007-02-01") & data$Date <= as.Date("2007-02-02")
data<-data[range,]

#Create DateTime variable
data$DateTime <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S", tz="EST")

#Convert Global_active_power to numeric
data$Global_active_power<-as.numeric(data$Global_active_power)

#Output graph to png
png( file ="plot4.png",width  = 480,height = 480)

par(mfrow=c(2,2))

#plot1
plot(x=data$DateTime, y=data$Global_active_power
     , xlab=""
     , ylab="Global Active Power"     
     ,type="l")

#plot2
plot(y=data$Voltage, x=data$DateTime, ylab="Voltage", xlab="datetime",type="l")

#plot3
with(data, plot(DateTime, Sub_metering_1, type = "l", col = "black", xlab = "", ylab = "Energy sub metering", main = ""))
with(data, points(DateTime, Sub_metering_2, type = "l", col = "red"))
with(data, points(DateTime, Sub_metering_3, type = "l", col = "blue"))
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = 1, bty="n", col = c("black", "red", "blue"))

#plot4
plot(y=data$Global_reactive_power, x=data$DateTime, ylab="Global_reactive_power", xlab="datetime",type="l")

dev.off()