## Read in .txt file, storing all data into powerUsage object.
powerUsage <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors= FALSE, na.strings = "?")

## Subset out only the usage between February 1st and February 2nd - Format is DD/MM/YYYY
powerUsage <- powerUsage[powerUsage$Date %in% c("1/2/2007", "2/2/2007"),] 

## Set size of plot to 480 pixels by 480 pixels
png("plot1.png", width=480, height=480)

## Create a histogram of global active power
hist(powerUsage$Global_active_power, main="Global Active Power",
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Kill handle to open file
dev.off()