## Examine the change of PCM25 yearly totals from 1999 - 2008

## Read in the data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## group data by year
dataByYear <- split(NEI, NEI$year)

## create year labels
years <- unique(NEI$year)

## take sum of emissions for each year
yearData <- sapply(dataByYear, function(data) sum(data$Emissions))

## create plot
dev <- png("plot1.png")
plot(years, yearData, pch = 7, main = "Total PCM25 for years 1999 - 2008", xlab = "Year", ylab = "Total PCM25")
lines(years, yearData, col = "red")
dev.off()

