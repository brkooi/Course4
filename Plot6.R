# Data science Course 4 - Exploratory Data Analysis
# Final assignment
# Script Plot6.R


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
SCC <- readRDS("Source_Classification_Code.rds")

#left join on SCC
nei_scc<-merge(x=NEI,y=SCC,by="SCC",all.x = TRUE)

# summarize emission per year 
# for vehicle-related sources 
# for Baltimore City (fips==24510) and Los Angeles County (fips=="06037")
plot6<-nei_scc%>%
  filter(fips=="24510" | fips=="06037" & grepl('vehicle',Short.Name,ignore.case = TRUE)) %>%
  select(year, fips, Emissions) %>%
  group_by(year, fips) %>%
  summarize(total_emm=sum(Emissions))

#initialize device
png(filename = "Plot6.png",
    width = 480, height = 480, units = "px", pointsize = 12)

#make plot with ggplot2
ggplot( plot6 , aes(x=year, y=total_emm, color=as.factor(fips))) + 
  geom_line() +  
  labs(title="Total emission per year by vehicle-related source", x = "Year", y="Emission") +
  theme(legend.position="right") +
  scale_color_manual(name="City",
                     labels=c("Baltimore City","Los Angeles County"),
                     values=c("red","green"))


#close device
dev.off()