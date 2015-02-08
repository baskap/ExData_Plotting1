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
png("plot2.png")

#plotting chart
with(dat,plot(datatime,
              Global_active_power, 
              type="l", 
              xlab="",
              ylab="Global Active Power (kilowatts)"))

#closing device
dev.off()

#restoring defaults
Sys.setlocale("LC_TIME", user_lang)