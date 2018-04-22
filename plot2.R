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

## plot 2
plot(data$Global_active_power~data$DateTime, type="l", ylab="Global Active Power (kilowatts)", xlab="")

## export image
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
