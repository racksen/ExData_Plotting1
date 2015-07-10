require(dplyr)

EPC.DF <- read.csv("./data/household_power_consumption_1.txt")

#mutate with datetime
EPC.DF$DateTime <- strptime(paste(EPC.DF$Date, EPC.DF$Time), "%d/%m/%Y %H:%M:%S")

#make it as dplyr object
EPC.DDF <- tbl_df(EPC.DF)

#draw histogram 
hist(EPC.DDF$Global_active_power,col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")

#find the currently used device
dev.cur()

#copy the drwan histogram as png with png device and turn it off
dev.copy(png,file="plot1.png")
dev.off()
