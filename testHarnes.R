#' Author : Senthil Ramalingam

# rough memory estimate for "Electric Power Consumption" dataset
# records = 2,075,259; cols = 9 (datetime*1 + numeric*8)
EPC.Size.oneRecord <- object.size(date()) + object.size(numeric())*8
EPC.Size.totalMB <- format(2075259 * EPC.Size.oneRecord,units="Mb")
EPC.Size.totalMB

#Read specific rows 
EPC.DF.Columns <- read.csv("./data/household_power_consumption.txt", header=TRUE, nrow=1, sep = ";")
EPC.DF <- read.csv("./data/household_power_consumption.txt", skip=66636, nrows= (2 * 24 * 60), col.names = names(EPC.DF.Columns),sep = ";")

#Write the csv file for future reference
write.csv2(EPC.DF,file = "./data/household_power_consumption_1.txt",row.names=FALSE )

#add new datetime column with date format
EPC.DF$DateTime <- strptime(paste(EPC.DF$Date, EPC.DF$Time), "%d/%m/%Y %H:%M:%S")

#verify the fetch
head(EPC.DF);tail(EPC.DF);dim(EPC.DF)

#verify the structure
str(EPC.DF)

# head(within(EPC.DF, { datetime= format(as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")}))
# head(strptime(paste(EPC.DF$Date, EPC.DF$Time), "%d/%m/%Y %H:%M:%S"))
# head(paste(EPC.DF$Date, EPC.DF$Time))
