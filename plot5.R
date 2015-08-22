
#  Read Data 
NEI <- readRDS("summarySCC_PM25.rds")
SRC <- readRDS("Source_Classification_Code.rds")

#  Create Data
Vehicles <- grep("vehicle",SRC$EI.Sector,value=T,ignore.case=T)
SRC_Vehicles <- subset(SRC, SRC$EI.Sector %in% Vehicles, select=SCC)
Baltimore_Vehicles <- subset(NEI, fips == "24510")
Baltimore_Vehicle_Emissions <- subset(Baltimore_Vehicles, Baltimore_Vehicles$SCC %in%  SRC_Vehicles$SCC)

#Aggregate Baltimore Emissions Data by year
Agg_data <- aggregate(Baltimore_Vehicle_Emissions[c("Emissions")], list(year = Baltimore_Vehicle_Emissions$year), sum)


#  Create Plot
png('plot5.png')
plot(Agg_data$year, Agg_data$Emissions, type = "l", 
     main = "Total Vehicle Emissions in Baltimore",xlab = "Year", ylab = "Emissions")

dev.off()