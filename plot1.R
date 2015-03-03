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

png(file="plot1.png")

with(data,hist(Global_active_power,
               col="red",
               main="Global Active Power",
               xlab="Global Active Power (kilowatts)",
               ylab="Frequency"))

dev.off()