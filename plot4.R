##before running the code it is necessary to install package "data.table"
##and run libraries data.table and datasets
##install.packages("data.table")
##library(data.table)
##library(datasets)

##the datafile was downloaded to the working directory
    d_time<-difftime(as.POSIXct("2007-02-03"),as.POSIXct("2007-02-01"),units="mins")
    n_rows_to_read<-as.numeric(d_time)

##reading file without column titles
    my_data<-fread("household_power_consumption.txt",skip="1/2/2007",nrows = n_rows_to_read, na.string = c("?",""))

##reading column titles
    col_titles<-fread("household_power_consumption.txt",nrows = 0)
    setnames(my_data,colnames(col_titles))

##converting Date and Time variables into Date/Time classes
    my_data$Date<-as.Date(my_data$Date,format="%d/%m/%Y")
    my_data$DateTime<-as.POSIXct(paste(as.character(my_data$Date),as.character(my_data$Time)),format="%Y-%m-%d %H:%M:%S")
    my_data$Time<-my_data$DateTime

##deleting temporary column
    my_data$DateTime<-NULL

##creating plot # 4

    png("plot4.png")
    par(mfrow=c(2,2),mar=c(4,4,2,1),oma=c(0,0,2,0))

##---first--------------
    with(my_data,plot(Time,Global_active_power,xlab="",ylab = "Global Active Power",type="n"))
    with(my_data,lines(Time,Global_active_power))
##---second-------------
    with(my_data,plot(Time,Voltage,xlab="datetime",ylab = "Voltage",type="n"))
    with(my_data,lines(Time,Voltage))
##---third--------------
    with(my_data,plot(Time,Sub_metering_1,xlab="",ylab = "Energy sub metering",type="n"))
    with(my_data,lines(Time,Sub_metering_1,col="black"))
    with(my_data,lines(Time,Sub_metering_2,col="red"))
    with(my_data,lines(Time,Sub_metering_3,col="blue"))
    legend("topright",col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=1,lwd=2)
##---fourth-------------
    with(my_data,plot(Time,Global_reactive_power,xlab="datetime",ylab = "Global_reactive_power",type="n"))
    with(my_data,lines(Time,Global_reactive_power))
    
    dev.off()