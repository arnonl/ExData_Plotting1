## Defines the working directory for the project and the compressed data file 
folder <- "/Users/arnon/Documents/Arnon/Data scientist/Exploratory Analysis/exData1"
fileName <- "exdata-data-household_power_consumption.zip"

# Saves the full path to the compressed data file
fullPath <- file.path(folder,fileName)
# Unzip the file
unzip(fullPath,exdir=folder)

# Reads the whole file
allData <- read.table("/Users/arnon/Documents/Arnon/Data scientist/Exploratory Analysis/exData1/household_power_consumption.txt", sep=";", header=T, na.strings="?")

# Extracts data subset, using the required dates
# [It is possible to transform the date to %Y-%m-%d mode before that, but it doesn't really matter]
# subData$Date <- as.Date(subData$Date,format="%d/%m/%Y")
subData <- allData[allData$Date == "1/2/2007" | allData$Date == "2/2/2007",]

# If needed, writes the subseted data to a new file, for faster reading later
# write.csv(subData,"/Users/arnon/Documents/Arnon/Data scientist/Exploratory Analysis/exData1/subset_household_power_consumption.csv")

## Generates plot1
# Creates a new graphics device with the desired dimensions
dev.new(width=480, height=480)
with(subData,
     hist(Global_active_power, col="red", main = "Global Active Power", xlab="Global Active Power (kilowatts)"))

# Copies the plot from the screen device to PNG file-device and then close the device
dev.copy(png, file=file.path(folder, "plot1.png"))
dev.off()
