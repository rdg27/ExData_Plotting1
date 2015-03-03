#Download and unzip the data (if required)

if (!file.exists("household_power_consumption.zip")) {
   download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                 destfile="household_power_consumption.zip")
   
}

if (!file.exists("household_power_consumption.txt")) {
   unzip("household_power_consumption.zip")
}


data <- read.table("household_power_consumption.txt",nrows=2075259,
                   header=TRUE,sep=";",na.strings=c("?"),comment.char="",
                   colClasses=c("character","character","numeric",
                                   "numeric","numeric","numeric",
                                   "numeric","numeric","numeric"))
   
#Just keep the rows we are intested in
data <- data[data$Date %in% c("1/2/2007","2/2/2007"),]


#Timestamp
data$datetime <- strptime(paste0(data$Date," ",data$Time),
                              format="%d/%m/%Y %H:%M:%S")
      

png(file="plot4.png")

par(mfrow=c(2,2))

#Top Left

with(data,plot(datetime,Global_active_power,
               type="l",
               xlab="",
               ylab="Global Active Power"))

#Top Right

with(data,plot(datetime,Voltage,
               type="l"))

#Bottom Left

with(data,plot(datetime,Sub_metering_1,
               type="l",
               xlab="",
               ylab="Energy sub metering"))

with(data,lines(datetime,Sub_metering_2,col="red"))

with(data,lines(datetime,Sub_metering_3,col="blue"))

legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       lty=1,col=c("black","red","blue"),bty="n")

#Bottom Right

with(data,plot(datetime,Global_reactive_power,
               type="l"))

dev.off()