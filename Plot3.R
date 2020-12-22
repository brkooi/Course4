# Data science Course 4 - Exploratory Data Analysis
# Final assignment
# Script Plot3.R


#load packages
packages <- c("data.table","dplyr", "ggplot2")
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
plot3<-NEI%>%filter(fips=="24510")%>%select(year,type, Emissions)%>%group_by(year, type)%>%summarize(total_emm=sum(Emissions))
plot3$type<-as.factor(plot3$type)

#initialize device
png(filename = "Plot3.png",
    width = 480, height = 480, units = "px", pointsize = 12)

#make plot with base plotting-system
#plot(plot3$year,log(plot3$total_emm),pch=19,cex=3,xlab="Year",ylab="Total Emission",main = "Total Emission per year for Baltimore")

ggplot( plot3 , aes(x=year, y=total_emm, color=as.factor(type) )) + 
  geom_point(size=3) +  
  facet_wrap(~type) +
  theme(legend.position="none") +
  labs(title="Total emission per year by type", x = "Year", y="Total Emission")

#close device
dev.off()