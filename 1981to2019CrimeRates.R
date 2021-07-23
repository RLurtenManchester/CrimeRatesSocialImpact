library(dplyr)
library(tidyr)
## Load in the Dataset Crime By Number 1981-2000

### Lets trim this down to the data that we need
CrimeByNumber81_99 <- Crime_By_Number_1981_2000[8:26, 1:12]

## Now lets rename all the columns 
colnames(CrimeByNumber81_99) = c("Year/Population", "CrimeIndexTotal", "", "ViolentCrime", "PropertyCrime", "Murder/NonNegligentManslaughter", "Rape", "Robbery", "AggravatedAssault", "Burglary", "Larceny/Theft", "MotorVehicleTheft")

#Separating the Year from the Population
CrimeByNumber81_99A <- separate(CrimeByNumber81_99, "Year/Population", c("Year", "Population"), sep= "-")


## Load in the Dataset Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019
### Lets trim this one down also to the data that we need
CrimeByNumber00_19 <- Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019[4:23, 1:22]

##Now to rename these columns
colnames(CrimeByNumber00_19) = c("Year", "Population", "ViolentCrime", "ViolentCrimeRate", "Murder/NonNegligentManslaughter",
                                 "Murder/NonNegligentManslaughterRate", "Rape/Revised", "Rape/RevisedRate", "Rape", "RapeRate", 
                                 "Robbery", "RobberyRate", "AggravatedAssault", "AggravatedAssaultRate", "PropertyCrime", "PropertyCrimeRate", 
                                 "Burglary", "BurglaryRate", "Larceny/Theft", "Larceny/TheftRate", "MotorVehicleTheft", "MotorVehicleTheftRate")

#Lets subset 00_19 to only have the same info as 81_00
keeps<- c("Year", "Population", "ViolentCrime", "Murder/NonNegligentManslaughter", "Rape", "Robbery", "AggravatedAssault", "PropertyCrime","Burglary", "Larceny/Theft", "MotorVehicleTheft")

CrimeByNumber00_19A <- CrimeByNumber00_19[keeps]
CrimeByNumber81_99B <- CrimeByNumber81_99A[keeps]

## Lets Combine all this into one
CrimeByNumber81_19 <-rbind(CrimeByNumber81_99B, CrimeByNumber00_19A)

library(rcompanion)
str(CrimeByNumber81_19)
## All of the data seems to be in chr format, let me turn that in to num
CrimeByNumber81_19$Year <- as.numeric(CrimeByNumber81_19$Year)
CrimeByNumber81_19$ViolentCrime <- as.numeric(CrimeByNumber81_19$ViolentCrime)
CrimeByNumber81_19$`Murder/NonNegligentManslaughter` <- as.numeric(CrimeByNumber81_19$`Murder/NonNegligentManslaughter`)
CrimeByNumber81_19$Rape <- as.numeric(CrimeByNumber81_19$Rape)
CrimeByNumber81_19$Robbery <- as.numeric(CrimeByNumber81_19$Robbery)
CrimeByNumber81_19$AggravatedAssault <- as.numeric(CrimeByNumber81_19$AggravatedAssault)
CrimeByNumber81_19$PropertyCrime <- as.numeric(CrimeByNumber81_19$PropertyCrime)
CrimeByNumber81_19$Burglary <- as.numeric(CrimeByNumber81_19$Burglary)
CrimeByNumber81_19$`Larceny/Theft` <- as.numeric(CrimeByNumber81_19$`Larceny/Theft`)
CrimeByNumber81_19$MotorVehicleTheft <- as.numeric(CrimeByNumber81_19$MotorVehicleTheft)

str(CrimeByNumber81_19)
##The population column seems to go crazy when I try to change it into numeric, so we aren't doing that.
## There seems to be a problem with a couple of the years, lets fix that really quick

CrimeByNumber81_19[21, 1] <- 2001
CrimeByNumber81_19[38, 1] <- 2018

