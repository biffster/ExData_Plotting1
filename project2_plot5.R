# This script will generate a plot showing the trend of PM2.5 Emissions from
# from motor vehicles in Baltimore City over the decade from 1999 to 2008.

# I use dplyr to use the groupby() and summarise() functions, and plyr
# to take advanatage of its join() function
library(dplyr)
library(plyr)

# Import data from the RDS files into a dataframe
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")
sourcesPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/Source_Classification_Code.rds")

# Group the datafiles by year, subsetting at the same time for data relating
# to Baltimore City, MD.
yearsBaltimore <- group_by(sccPM25[which(sccPM25$fips == 24510),], year)
sccPM25balt <- sccPM25[which(sccPM25$fips == 24510),]

# This line performs two critical functions:
# 1) Build a lookup table/dataframe from the Sources data
# 2) Use grep to subset this lookup table into only the emissions types we
#    are interested in - in this case it's any emissions from motor vehicles
lookupbalt <- sourcesPM25[grep("ighway",sourcesPM25$SCC.Level.Two),]

# join() the two data sets by the shared key SCC
coalFullbalt <- join(lookupbalt, sccPM25balt, by="SCC")

# Now that we have only the measurements generated from motor vehicles, this
# data can be grouped by year and then summarised to get total emissions
coalYearsbalt <- group_by(coalFullbalt, year)
coalTotalbalt <- dplyr::summarise(coalYearsbalt, count = sum(Emissions, na.rm = TRUE))

# Simple line plot using the base plotting system.
plot(coalTotalbalt$year, coalTotalbalt$count, type = "l", main = "Vehicle combustion sources in Baltimore City", ylab = "PM25 Emissions (tons)", xlab = "")

# Export that plot to a PNG file
dev.copy(png,"project2_plot5.png")
dev.off()
