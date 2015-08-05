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

## Generates plot3
# Creates a new PNG graphics device with the desired dimensions
png(file=file.path(folder,"plot3.png"),width=480, height=480)
# Plots three parameter sets on the same plot with different color
with(subData, {
    plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxp=c(0,2,2), xaxt="n")
    points(Time, Sub_metering_2, type="l", col="red")
    points(Time, Sub_metering_3, type="l", col="blue")
})
axis(1,0:2,labels=c("Thu","Fri","Sat"))
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=2, bty="o", x.intersp=0.5, y.intersp=0.8, xjust = 0, yjust = 0)

# Closes the PNG file-device
dev.off()
