## Read in RDS data files, storing all data into NEI and SCC objects.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grab all data from Baltimore City (FIPS 24510).
baltmoreEmissions <- NEI[NEI$fips=="24510",]

## Aggregate total emissions by year.
baltimoreAggEmissions <- aggregate(Emissions ~ year, baltmoreEmissions, sum)

## We want to create a png named "plot2.png".
## Set size of plot to 480 pixels by 480 pixels
png("plot2.png",width=640,height=480)

## Create a bar plot (using base plotting system) of total pm2.5 emissions
## for Baltimore City (FIPS 24510) for years 1999, 2002, 2005, and 2008.
barplot(height=baltimoreAggEmissions$Emissions,
        names.arg=baltimoreAggEmissions$year,
        xlab="years", 
        ylab="total PM2.5 emissions (tons)",
        main="Total PM2.5 emissions in Baltimore City, Maryland at various years")

## Kill handle to open file.
dev.off()