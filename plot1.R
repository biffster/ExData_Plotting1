fulltable <- read.csv("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE, header = TRUE, na.strings = "?")
febDataRows <- grep("^[1|2]{1}/2/2007", fulltable$Date)
febData <- fulltable[febDataRows,]
hist(as.numeric(febData$Global_active_power), xlab = "Global Active Power (kilowatts)", col="red", main = "Global Active Power")
dev.copy(png,"plot1.png")
dev.off()
