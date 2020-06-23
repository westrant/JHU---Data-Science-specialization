## Read in .txt file, storing all data into powerUsage object.
powerUsage <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors= FALSE, na.strings = "?")

## Subset out only the usage between February 1st and February 2nd - Format is DD/MM/YYYY
powerUsage <- powerUsage[powerUsage$Date %in% c("1/2/2007", "2/2/2007"),] 

## Create a new field which combines the date and time.
powerUsage$DT <- strptime(paste(powerUsage$Date, powerUsage$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Set size of plot to 480 pixels by 480 pixels
png("plot4.png", width=480, height=480)

## Format to display 2 plots on top, 2 plots on bottom (2x2 square of plots)
par(mfrow=c(2, 2))

## Draw first plot, which plots global active power over time.
plot(powerUsage$DT, powerUsage$Global_active_power, type="l", xlab="", ylab="Global Active Power")

## Draw second plot, which plots voltage over time.
plot(powerUsage$DT, powerUsage$Voltage, type="l", xlab="datetime", ylab="Voltage")

## Draw the third plot, energy sub metering
plot(powerUsage$DT, powerUsage$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

## Add the 2nd submeter data set to the plot
lines(powerUsage$DT, powerUsage$Sub_metering_2, col="red")

## Add the 3rd submeter data set to the plot
lines(powerUsage$DT, powerUsage$Sub_metering_3, col="blue")

## Add the legend to the top right of the plot
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))

## Draw the 4th plot, which shows global reactive power over time
plot(powerUsage$DT, powerUsage$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_Power")

## Kill handle to open file
dev.off()