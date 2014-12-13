## Examine the change of PCM25 yearly totals from 1999 - 2008

## Read in the data
SCC <- readRDS("Source_Classification_Code.rds")
NEI <- readRDS("summarySCC_PM25.rds")

## flag all data from Baltimore
baltimoreData <- NEI$fips == 24510

## create data frame for emissions by year from baltimore and group by year
baltimoreEmissions <- data.frame(NEI$Emissions[baltimoreData], NEI$year[baltimoreData])
names(baltimoreEmissions) <- c("Emissions", "year")
baltEmissionsByYears <- split(baltimoreEmissions, baltimoreEmissions$year)

## create year labels
years <- unique(NEI$year)

## take sum of emissions for each year
yearData <- sapply(baltEmissionsByYears, function (year) sum(year))

## create plot
dev <- png("plot2.png")
plot(years, yearData, pch = 7, main = "Total PCM25 in Baltimore Maryland for years 1999 - 2008", xlab = "Year", ylab = "Total PCM25 Baltimore")
lines(years, yearData, col = "red")
dev.off()

