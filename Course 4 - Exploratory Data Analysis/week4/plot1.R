## Read in RDS data files, storing all data into NEI and SCC objects.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Aggregate total emissions by year.
aggEmissions <- aggregate(Emissions ~ year, NEI, sum)

## We want to create a png named "plot1.png".
## Set size of plot to 480 pixels by 480 pixels
png("plot1.png",width=640,height=480)

## Create a bar plot (using base plotting system) of total pm2.5 emissions
## for years 1999, 2002, 2005, and 2008.
barplot(height=aggEmissions$Emissions, names.arg=aggEmissions$year, 
        xlab="years", 
        ylab="total PM2.5 emissions (tons)",
        main="Total PM2.5 emissions at various years")

## Kill handle to open file.
dev.off()