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

#Plot the data (Plot 3)
with(powerdata, plot(Sub_metering_1~DateTime, type="l", ylab="Energy sub metering", xlab=""))

#Annotate
with(powerdata,lines(Sub_metering_2~DateTime,col="red"))
with(powerdata,lines(Sub_metering_3~DateTime,col="blue"))
legend("topright", lty=1, lwd=2, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),cex=0.75)
 
dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()