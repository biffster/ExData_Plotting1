# This script will generate a plot showing the trend of PM2.5 Emissions
# from Coal combustion over the decade from 1999 to 2008.

# I use dplyr to use the groupby() and summarise() functions, and plyr
# to take advanatage of its join() function
library(dplyr)
library(plyr)

# Import data from the RDS files into a dataframe
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")
sourcesPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/Source_Classification_Code.rds")

# This line performs two critical functions:
# 1) Build a lookup table/dataframe from the Sources data
# 2) Use grep to subset this lookup table into only the emissions types we
#    are interested in - in this case it's Coal emissions
lookup <- sourcesPM25[grep("Coal", sourcesPM25$SCC.Level.Three),]

# join() the two data sets by the shared key SCC
coalFull <- join(lookup, sccPM25, by="SCC")

# Now that we have only the measurements generated from Coal emissions, this
# data can be grouped by year and then summarised to get total emissions
coalYears <- group_by(coalFull, year)
coalTotal <- dplyr::summarise(coalYears, count = sum(Emissions, na.rm = TRUE))

# Simple line plot using the base plotting system. Note: I use log(tons)
# to highlight the Y scale of the trend
plot(coalTotal$year, log(coalTotal$count), type = "l", main = "Emissions from coal combustion sources", ylab = "PM25 Emissions (log(tons))", xlab = "")

# Export that plot to a PNG file
dev.copy(png,"project2_plot4.png")
dev.off()
