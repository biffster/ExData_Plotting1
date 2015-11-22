# This script will generate a plot contrasting the trend of PM2.5 Emissions
# from motor vehicles over the decade from 1999 to 2008 between Baltimore City and 
# Los Angeles County

# I use dplyr to use the groupby() and summarise() functions, and plyr
# to take advanatage of its join() function
library(plyr)
library(dplyr)

# Import data from the RDS files into a dataframe
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")
sourcesPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/Source_Classification_Code.rds")

# Group the datafiles by year, subsetting at the same time for data relating
# to Baltimore City, MD.
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

# Group the datafiles by year, subsetting at the same time for data relating
# to Los Angeles City.
sccPM25lac <- sccPM25[which(sccPM25$fips == "06037"),]

# This line performs two critical functions:
# 1) Build a lookup table/dataframe from the Sources data
# 2) Use grep to subset this lookup table into only the emissions types we
#    are interested in - in this case it's any emissions from motor vehicles
lookuplac <- sourcesPM25[grep("ighway",sourcesPM25$SCC.Level.Two),]

# join() the two data sets by the shared key SCC
coalFulllac <- join(lookuplac, sccPM25lac, by="SCC")

# Now that we have only the measurements generated from motor vehicles, this
# data can be grouped by year and then summarised to get total emissions
coalYearslac <- group_by(coalFulllac, year)
coalTotallac <- dplyr::summarise(coalYearslac, count = sum(Emissions, na.rm = TRUE))

# Set up base plotting system to show two panels
par(mfrow=c(2,1))

# Two simple line plots using the base plotting system.
plot(coalTotalbalt$year, coalTotalbalt$count, type = "l", main = "Vehicle combustion sources in Baltimore City", ylab = "PM25 Emissions (tons)", xlab = "", col = "blue", lwd = 2.5)
plot(coalTotallac$year, coalTotallac$count, type = "l", main = "Vehicle combustion sources in Los Angeles County", ylab = "PM25 Emissions (tons)", xlab = "", col = "red", lwd = 2.5)

dev.copy(png,"project2_plot6.png")
dev.off()
