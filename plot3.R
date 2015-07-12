if(!exists("EPC.DF")){
  #get the zip file
  if(!file.exists("./data/exdata-data-household_power_consumption.zip")){
    zipUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    tempZipFile <- tempfile();
    download.file(zipUrl,tempZipFile)
    zipFile <- unzip(tempZipFile)
    unlink(tempZipFile)
  }
  EPC.DF <- read.table(zipFile, header=T, sep=";") 
  EPC.DF$Date <- as.Date(EPC.DF$Date, format="%d/%m/%Y")
  #filter only the 02/01 to 02/02 data
  EPC.DF <- EPC.DF[(EPC.DF$Date=="2007-02-01") | (EPC.DF$Date=="2007-02-02"),]
  #add DateTime column
  EPC.DF <- transform(EPC.DF, datetime_stamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
  #coerce the other variables
  EPC.DF$Global_active_power <- as.numeric(as.character(EPC.DF$Global_active_power))
  EPC.DF$Global_reactive_power <- as.numeric(as.character(EPC.DF$Global_reactive_power))
  EPC.DF$Voltage <- as.numeric(as.character(EPC.DF$Voltage))
  EPC.DF$Sub_metering_1 <- as.numeric(as.character(EPC.DF$Sub_metering_1))
  EPC.DF$Sub_metering_2 <- as.numeric(as.character(EPC.DF$Sub_metering_2))
  EPC.DF$Sub_metering_3 <- as.numeric(as.character(EPC.DF$Sub_metering_3))
}


plot(
  EPC.DF$datetime_stamp,
  EPC.DF$Sub_metering_1, 
  type="l", 
  xlab="", 
  ylab="Energy sub metering"
)

lines(EPC.DF$datetime_stamp,EPC.DF$Sub_metering_2,col="red")
lines(EPC.DF$datetime_stamp,EPC.DF$Sub_metering_3,col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),lty=c(1,1), lwd=c(1,1))

dev.copy(png, file="plot3.png", width=580, height=480)
dev.off()


