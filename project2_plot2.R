# This script will generate a plot showing the trend of PM2.5 Emissions over
# the decade from 1999 to 2008.

# I use dplyr to use the groupby() and summarise() functions
library(dplyr)

# Import data from the RDS file into a dataframe
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")

# Group the datafiles by year, subsetting at the same time for data relating
# to Baltimore City, MD.
yearsBaltimore <- group_by(sccPM25[which(sccPM25$fips == 24510),], year)

# Summarise the resulting dataset to get the total emissions by year.
ttlEmBalt <- summarise(yearsBaltimore,count = sum(Emissions))

# Simple line plot using the base graphics system.
plot(ttlEmBalt$year,ttlEmBalt$count, type = "l", main="Baltimore City", ylab = "PM25 Emissions (tons)", xlab = "")

# Export the plot to a PNG file.
dev.copy(png,"project2_plot2.png")
dev.off()
