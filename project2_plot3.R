# This script will generate a plot showing the trend of PM2.5 Emissions for
# four major types of measurements, plotted indvidually, over
# the decade from 1999 to 2008.

# I use dplyr to use the groupby() and summarise() functions, and ggplot2
# to take advanatage of its plotting capabilities
library(dplyr)
library(ggplot2)

# Import data from the RDS file into a dataframe
sccPM25 <- readRDS("/home/biffster/Dropbox/Work/Training/Data science/Coursera/Exploratory Data Analysis/summarySCC_PM25.rds")

# Group the datafiles by year, subsetting at the same time for data relating
# to Baltimore City, MD.
yearsBaltimore <- group_by(sccPM25[which(sccPM25$fips == 24510),], year)

# Group that resultant dataset by measurement type
yearsTypeBaltimore <- group_by(sccPM25[which(sccPM25$fips == 24510),], year, type)

# Create the plotting dataset
plotthis <- summarise(yearsTypeBaltimore, count=sum(Emissions))

# Create the canvas and the datapoints for the plot
g <- ggplot(plotthis, aes(year,count), color=type)

# Add in the plot panels and a trend line
g <- g + geom_point() + facet_grid(. ~ type) + geom_smooth(method="lm")

# Set up titles
g <- g + ylab("PM 2.5 Emissions (tons)") + ggtitle("Measurements for Baltimore City")

# Print the plot to the screen and export it to a png file.
print(g)
dev.copy(png,"project2_plot3.png")
dev.off()
