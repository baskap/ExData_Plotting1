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
png("plot3.png")

#creating plot without points and lines (only axes and titles)
with(dat,plot(datatime,Sub_metering_1,type="n", ylab="Energy sub metering", xlab=""))

#adding three lines to plot
with(dat,lines(datatime,Sub_metering_1))
with(dat,lines(datatime,Sub_metering_2, col="red"))
with(dat,lines(datatime,Sub_metering_3, col="blue"))

#adding legend to plot
legend("topright",
       lwd=1,
       col=c("black","red","blue"), 
       legend=paste(c("Sub_metering_"),1:3,sep=""))

#closing device
dev.off()

#restoring defaults
Sys.setlocale("LC_TIME", user_lang)