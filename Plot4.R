# Data science Course 4 - Exploratory Data Analysis
# Final assignment
# Script Plot4.R


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
plot4<-nei_scc%>%
        filter(grepl('coal',Short.Name,ignore.case = TRUE)) %>%
        select(year, Emissions)%>%
        group_by(year)%>%
        summarize(total_emm=sum(Emissions))


#initialize device
png(filename = "Plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12)

#make plot with ggplot2
ggplot( plot4 , aes(x=year, y=total_emm)) + 
  geom_point(size=3) +  
  theme(legend.position="none") +
  labs(title="Total emission per year by coal-related source", x = "Year", y="Total Emission")

#close device
dev.off()