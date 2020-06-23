## Read in .txt file, storing all data into powerUsage object.
powerUsage <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors= FALSE, na.strings = "?")

## Subset out only the usage between February 1st and February 2nd - Format is DD/MM/YYYY
powerUsage <- powerUsage[powerUsage$Date %in% c("1/2/2007", "2/2/2007"),] 

## Create a new field which combines the date and time.
powerUsage$DT <- strptime(paste(powerUsage$Date, powerUsage$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Set size of plot to 480 pixels by 480 pixels
png("plot3.png", width=480, height=480)

## Create a plot of energy sub metering
plot(powerUsage$DT, powerUsage$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")

## Add the 2nd submeter data set to the plot
lines(powerUsage$DT, powerUsage$Sub_metering_2, col="red")

## Add the 3rd submeter data set to the plot
lines(powerUsage$DT, powerUsage$Sub_metering_3, col="blue")

## Add the legend to the top right of the plot
legend("topright", col=c("black", "red", "blue"), 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1), lwd=c(1,1))

## Kill handle to open file
dev.off()