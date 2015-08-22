NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

#Subset the data for Coal Combustion
Coal_Comb <- grep("coal",SRC$EI.Sector,value=T,ignore.case=T)
SRC_Coal_Comb <- subset(SRC, SRC$EI.Sector %in% Coal_Comb, select=SCC)
NEI_Coal_Comb <- subset(NEI, NEI$SCC %in%  SRC_Coal_Comb$SCC)

#Aggregate the data for Coal Combustion
Agg_Coal_Comb <- aggregate(NEI_Coal_Comb[c("Emissions")], list(year = NEI_Coal_Comb$year), sum)

#Create plot 4
library("ggplot2")
png('plot4.png')
p <- ggplot(Agg_Coal_Comb, aes(x=year, y=Emissions)) +
  geom_bar(stat="identity",fill="grey",width=0.75) +
  theme_bw() +  guides(fill=FALSE) +
  labs(x="year", y=expression(" Emissions")) + 
  labs(title=expression("Total PM2.5 Coal Combustion Emissions in the US"))

print(p)

dev.off()
