library(lubridate)
library(dplyr)

# Reading data ####
# Assuming the data is in the MyDocuments/R folder
power_consumption = read.csv("./data/household_power_consumption.txt", header = TRUE, nrows = 3000, skip = 66600, sep = ';', dec = ".", stringsAsFactors = FALSE)
colnames(power_consumption) = c("Date", "Time", "Global_active_power", "Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
# Converting to date
power_consumption$Date = as.Date(power_consumption$Date, format = "%d/%m/%Y")

# Getting day of the week
power_consumption$Weekday = weekdays(power_consumption$Date)

# Converting to date-time
power_consumption$DateTime = with(power_consumption, 
                                  as.POSIXct(paste(Date, Time), format="%Y-%m-%d %H:%M:%S"))


# Fourth Plot
png(filename = "Plot4.png")
par(mfrow = c(2, 2))

#1
plot(power_consumption$DateTime2, 
     power_consumption$Global_active_power, 
     type = 'l',
     xlab = '',
     ylab = 'Global Active Power (kilowatts)')

#2
plot(power_consumption$DateTime2, 
     power_consumption$Voltage, 
     type = 'l',
     xlab = 'datetime',
     ylab = 'Voltage')

#3
plot(power_consumption$DateTime, 
     power_consumption$Sub_metering_1, 
     type = 'l',
     xlab = '',
     ylab = 'Energy sub metering')
lines(power_consumption$DateTime, 
      power_consumption$Sub_metering_2,
      col = 'red')
lines(power_consumption$DateTime, 
      power_consumption$Sub_metering_3,
      col = 'blue')
legend("topright", 
       lty = 1,
       col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#4
plot(power_consumption$DateTime2, 
     power_consumption$Global_reactive_power, 
     type = 'l',
     xlab = 'datetime',
     ylab = 'Global_reactive_power')
dev.off()
