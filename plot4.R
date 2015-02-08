#setting "LC_TIME" to "English"
user_lang <- Sys.getlocale("LC_TIME")
Sys.setlocale("LC_TIME", "C")

#creating "sample.txt" file with data from 2007-02-01 and 2007-02-02
system('head -n1 household_power_consumption.txt > sample.txt')
system('grep "^[1-2]/2/2007" household_power_consumption.txt  >> sample.txt')

#reading data from "sample.txt" file
dat  <-read.csv("./sample.txt",
                na.strings=c("?"), 
                header=TRUE,
                sep = ";")

#adding "datatime" column that contains information about date and time to dataframe "dat"
dat$datatime <- with(dat,
                     as.POSIXct(strptime(paste(Date,Time),"%d/%m/%Y %H:%M:%S")))

#setting device
png("plot4.png")

par(mfrow=c(2,2))

#Plot on upper-left corner (Global active power)

with(dat,plot(datatime,
              Global_active_power, 
              type="l", 
              xlab="",
              ylab="Global Active Power"))

#Plot on upper-right corner (Voltage)

with(dat,plot(datatime,
              Voltage, 
              type="l"))

#Plot on bottom-left corner (Energy sub metering)

with(dat,plot(datatime,Sub_metering_1,type="n", ylab="Energy sub metering", xlab=""))

with(dat,lines(datatime,Sub_metering_1))
with(dat,lines(datatime,Sub_metering_2, col="red"))
with(dat,lines(datatime,Sub_metering_3, col="blue"))

legend("topright",
       lwd=1,
       bty="n",
       col=c("black","red","blue"), 
       legend=paste(c("Sub_metering_"),1:3,sep=""))

#Plot on bottom-right corner (Global reactive power)

with(dat,plot(datatime,
              Global_reactive_power, 
              type="l"))

#closing device
dev.off()

#restoring defaults
Sys.setlocale("LC_TIME", user_lang)