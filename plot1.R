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
png( file ="plot1.png",width  = 480,height = 480)

hist(data$Global_active_power
     , col="orangered" 
     , main="Global Active Power"
     , xlab="Global Active Power (kilowatts)"
     , ylab="Frequency"
     , xlim=c(0,6)
     , ylim=c(0, 1200))

dev.off()