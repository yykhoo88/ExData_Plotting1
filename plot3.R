#cleanup, change local working directory
rm(list=ls())
getwd()
setwd("/Dropbox/Dropbox/Codes/Rstudio")


#file handling: downloading dataset and unzip if not yet!
filename <- "dataset.zip"
filenameUnzipped <- "household_power_consumption.txt"
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileURL, filename)
}  
if (!file.exists(filenameUnzipped)) { 
  unzip(filename) 
}

#read data (may take a while)
dataFull <- read.table(filenameUnzipped, header=TRUE, na.strings="?", sep=";")
data <- dataFull[(dataFull$Date=="1/2/2007" | dataFull$Date=="2/2/2007" ), ]

#need to clean up date/time data
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
dateTime <- paste(data$Date, data$Time)
data$DateTime <- as.POSIXct(dateTime)

## plot 3
with(data, {
  plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab="", cex=0.8)
  lines(Sub_metering_2~DateTime, col='Red')
  lines(Sub_metering_3~DateTime, col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=1, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), cex=0.8)

## export image
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
