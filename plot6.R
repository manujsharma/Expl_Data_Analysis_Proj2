
#  Read Data 
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

#  Create Data
Vehicles <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)
SRC_Vehicles <- subset(SRC, SRC$EI.Sector %in% Vehicles, select=SCC)
BLT_LAX_Vehicles <- subset(NEI, fips == "24510"|fips == "06037")
BLT_LAX_Vehicle_Emissions <- subset(BLT_LAX_Vehicles, BLT_LAX_Vehicles$SCC %in%  SRC_Vehicles$SCC)

#Aggregate Baltimore and LA Emissions Data by year
Agg_data <- aggregate(BLT_LAX_Vehicle_Emissions[c("Emissions")], list(fips = BLT_LAX_Vehicle_Emissions$fips, year = BLT_LAX_Vehicle_Emissions$year), sum)

Agg_data$city <- rep(NA, nrow(Agg_data))

Agg_data[Agg_data$fips == "06037", ][, "city"] <- "Los Angeles"
Agg_data[Agg_data$fips == "24510", ][, "city"] <- "Baltimore"

#  Create Plot
library("ggplot2")
png('plot6.png')
p <- ggplot(Agg_data, aes(x=year, y=Emissions, colour=city)) +
  geom_point(alpha=.3) +
  geom_smooth(alpha=.2, size=1, method="loess") +
  ggtitle("Vehicle Emissions in Baltimore vs. LA")

print(p)

dev.off()