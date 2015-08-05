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

# Creates a vector from 0 to 2 with uniqe value for each minute (2days*24hours*60min)
subData$Time <- seq(from=0, to=2, length.out=2*24*60)

## Generates plot2
# Creates a new graphics device with the desired dimensions
dev.new(width=480, height=480)
with(subData, plot(Time, Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xaxp=c(0,2,2), xaxt="n"))
# Creates an axis with labels of the day name instead of numbers 
axis(1,0:2,labels=c("Thu","Fri","Sat"))

# Copies the plot from the screen device to PNG file-device and then close the device
dev.copy(png, file=file.path(folder, "plot2.png"))
dev.off()