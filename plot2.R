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

##creating plot # 2
    png("plot2.png")
    with(my_data,plot(Time,Global_active_power,xlab="",ylab = "Global Active Power (kilowatts)",type="n"))
    with(my_data,lines(Time,Global_active_power))
    dev.off()