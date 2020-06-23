## Read in .txt file, storing all data into powerUsage object.
powerUsage <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors= FALSE, na.strings = "?")

## Subset out only the usage between February 1st and February 2nd - Format is DD/MM/YYYY
powerUsage <- powerUsage[powerUsage$Date %in% c("1/2/2007", "2/2/2007"),] 

## Create a new field which combines the date and time.
powerUsage$DT <- strptime(paste(powerUsage$Date, powerUsage$Time, sep=" "), format="%d/%m/%Y %H:%M:%S")

## Set size of plot to 480 pixels by 480 pixels
png("plot2.png", width=480, height=480)

## Create a plot of global active power by hour
plot(powerUsage$DT, powerUsage$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")

## Kill handle to open file
dev.off()