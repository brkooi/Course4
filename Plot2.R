# Data science Course 4 - Exploratory Data Analysis
# Final assignment
# Script Plot2.R


#load packages
packages <- c("data.table","dplyr",)
sapply(packages, require, character.only=TRUE, quietly=TRUE)

# download file and unzip datafiles
path_files<-getwd()
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url, "dataFiles.zip")
unzip(zipfile = "dataFiles.zip")

# read datafiles
NEI <- readRDS("summarySCC_PM25.rds")
#SCC <- readRDS("Source_Classification_Code.rds")

# summarize emission per year for Baltimore (fips==24510)
plot2<-NEI%>%filter(fips=="24510")%>%select(year,Emissions)%>%group_by(year)%>%summarize(total_emm=sum(Emissions))

#initialize device
png(filename = "Plot2.png",
    width = 480, height = 480, units = "px", pointsize = 12)

#make plot with base plotting-system
plot(plot2$year,log(plot2$total_emm),pch=19,cex=3,xlab="Year",ylab="Total Emission",main = "Total Emission per year for Baltimore")

#close device
dev.off()