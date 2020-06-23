## Make sure the ggplot2 library is loaded.
library(ggplot2)

## Read in RDS data files, storing all data into NEI and SCC objects.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Grab all vehicle emissions data from Baltimore City (FIPS 24510).
baltmoreEmissions <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

## Aggregate total Baltimore City emissions by year.
baltimoreAggEmissions <- aggregate(Emissions ~ year, data=baltmoreEmissions, FUN=sum)

## Grab all vehicle emissions data from Los Angeles (FIPS 06037).
losAngelesEmissions <- NEI[(NEI$fips=="06037") & (NEI$type=="ON-ROAD"),]

## Aggregate total LA emissions by year.
losAngelesAggEmissions <- aggregate(Emissions ~ year, data=losAngelesEmissions, FUN=sum)

## Add county labels to aggregated data set.
baltimoreAggEmissions$County <- "Baltimore City"
losAngelesAggEmissions$County <- "Los Angeles"

## Create new object holding both Baltimore County and LA vehicle emissions.
combinedEmissions <- rbind(baltimoreAggEmissions, losAngelesAggEmissions)

## We want to create a png named "plot5.png".
png("plot6.png",width=640,height=480)

## Create bar plots (using ggplot2) of total cooal pm2.5 emissions
## for years 1999, 2002, 2005, and 2008.
##combinedEmissionsPlot <- ggplot(combinedEmissions, aes(x=factor(year), y=Emissions, fill=County)) +
##  geom_bar(stat="identity", lwd=2) + guides(fill=FALSE) + 
##  facet_grid(County ~ ., scales="free", space = "free") +
##  xlab("year") +
##  ylab("total PM2.5 emissions (tons)") +
##  ggtitle("Emissions from motor vehicle sources in Baltimore City and Los Angeles")

combinedEmissionsPlot <- ggplot(combinedEmissions, aes(x=factor(year), y=Emissions, fill=County)) +
  geom_bar(aes(fill=year),stat="identity", lwd=2) +
  facet_grid(scales="free", space="free", .~County) +
  xlab("year") +
  ylab("total PM2.5 emissions (tons)") +
  ggtitle("Emissions from motor vehicle sources in Baltimore City and Los Angeles")

## Write output of the ggplot function to plot3.png file.
print(combinedEmissionsPlot)

## Kill handle to open file.
dev.off()