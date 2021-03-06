dir <- "./Module 4 Course Proj 1"
if(!file.exists(dir)) {
	dir.create(dir)
}


fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
filezip <- "household_power_consumption.zip"
aFile <- paste(dir,filezip,sep="/")

if(!file.exists(aFile)) {
	download.file(fileUrl, destfile = aFile)
	unzip(aFile, exdir = dir)
}

colc<- c(Global_active_power="numeric",Global_reactive_power="numeric", Voltage="numeric",Global_intensity="numeric",Sub_metering_1="numeric",Sub_metering_2="numeric",Sub_metering_3="numeric")
file="household_power_consumption.txt"
masterdata<- read.table(paste(dir,file,sep="/"), header=TRUE, sep=";",dec=".", stringsAsFactors=FALSE, na.strings = "?",colClasses=colc)
powerdata <- subset(masterdata,masterdata$Date=="1/2/2007" | masterdata$Date =="2/2/2007")

powerdata$Date <- as.Date(powerdata$Date, format = '%d/%m/%Y')
powerdata$DateTime <- as.POSIXct(paste(powerdata$Date, powerdata$Time))

#Plot the data (Plot 4)
par(mfrow = c(2, 2)) 

##1st plot
with(powerdata,plot(Global_active_power~DateTime, xlab = '', ylab = 'Global Active Power (kilowatt)', type = 'l'))
##2nd plot
with(powerdata,plot(Voltage~DateTime, xlab = 'datetime', ylab = 'Voltage', type = 'l'))
##3rd plot
with(powerdata,plot(Sub_metering_1~DateTime, xlab = '', ylab = 'Energy sub metering', type = 'l'))
##Annotate on the 3rd plot
with(powerdata,lines(Sub_metering_2~DateTime,col="red"))
with(powerdata,lines(Sub_metering_3~DateTime,col="blue"))
legend("topright", lty=1, lwd=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.70,bty="n")
##4th plot
with(powerdata,plot(Global_reactive_power~DateTime, xlab = 'datetime', ylab = 'Global_reactive_power', type = 'l'))
 
dev.copy(png, file="Plot4.png", height=480, width=480)
dev.off()