NEI <- readRDS("summarySCC_PM25.rds")

# Subset Data for Baltimore
NEI_Baltimore <- subset(NEI, fips == "24510")

# Summarize Data by year
Agg_by_year <- aggregate(NEI_Baltimore[c("Emissions")], list(year = NEI_Baltimore$year), sum)

#  Create Plot 2
png('plot2.png')

plot(Agg_by_year$year, Agg_by_year$Emissions/10^3, type = "l", 
     main = "Total PM2.5 Emissions in Baltimore",
     xlab = "Year", ylab = "Emissions(10^3)")


dev.off()