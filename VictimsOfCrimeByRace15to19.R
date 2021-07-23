## Victims of Crime Based on Rate

## Starting with loading in datasets
library(readxl)
#2015
victims_race_by_offense_category_2015 <- read_excel("victims_race_by_offense_category_2015.xls")
#2016
victims_race_by_offense_category_2016 <- read_excel("victims_race_by_offense_category_2016.xls")
#2017
victims_race_by_offense_category_2017 <- read_excel("victims_race_by_offense_category_2017.xls")
#2018
victims_race_by_offense_category_2018 <- read_excel("victims_race_by_offense_category_2018.xls")
#2019
victims_race_by_offense_category_2019 <- read_excel("victims_race_by_offense_category_2019.xls")

#Wrangling the data

## 2015
VictimByRace2015 <- victims_race_by_offense_category_2015[5:25, 1:8]
#Now lets rename the columns
colnames(VictimByRace2015) <- c("OffenseCategory", "TotalVictims2015", "White2015", 
                                "Black/AfricanAmerican2015", "AmericanIndian/AlaskaNative2015", 
                                "Asian2015", "NativeHawaiian/PacificIslander2015", "Unknown2015")

## 2016
VictimByRace2016 <-victims_race_by_offense_category_2016[5:25, 1:8]
# Rename the columns
colnames(VictimByRace2016) <- c("OffenseCategory", "TotalVictims2016", "White2016", 
                                "Black/AfricanAmerican2016", "AmericanIndian/AlaskaNative2016", 
                                "Asian2016", "NativeHawaiian/PacificIslander2016", "Unknown2016")

## 2017
VictimByRace2017 <- victims_race_by_offense_category_2017[5:25, 1:8]
#Rename the columns
colnames(VictimByRace2017) <- c("OffenseCategory", "TotalVictims2017", "White2017", 
                                "Black/AfricanAmerican2017", "AmericanIndian/AlaskaNative2017", 
                                "Asian2017", "NativeHawaiian/PacificIslander2017", "Unknown2017")

## 2018
VictimByRace2018 <- victims_race_by_offense_category_2018 [5:25, 1:8]
#Rename the columns
colnames(VictimByRace2018) <- c("OffenseCategory", "TotalVictims2018", "White2018", 
                                "Black/AfricanAmerican2018", "AmericanIndian/AlaskaNative2018", 
                                "Asian2018", "NativeHawaiian/PacificIslander2018", "Unknown2018")

## 2019
VictimByRace2019 <- victims_race_by_offense_category_2019[5:25, 1:8]
#Rename the columns
colnames(VictimByRace2019) <- c("OffenseCategory", "TotalVictims2019", "White2019", 
                                "Black/AfricanAmerican2019", "AmericanIndian/AlaskaNative2019", 
                                "Asian2019", "NativeHawaiian/PacificIslander2019", "Unknown2019")

## Load in libraries to work on this
library(ggplot2)
library(tidyr)
library(dplyr)

#Now to flip this data and name the other columns to start comparing the info from different years
## 2015
VictimByRace2015A <- t(VictimByRace2015)
VictimByRace2015B <- VictimByRace2015A [2:8, ]
colnames(VictimByRace2015B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                "Robbery", "StolenPropertyOffenses")

## 2016
VictimByRace2016A <- t(VictimByRace2016)
VictimByRace2016B <- VictimByRace2016A [2:8, ]
colnames(VictimByRace2016B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                "Robbery", "StolenPropertyOffenses")

## 2017
VictimByRace2017A <- t(VictimByRace2017)
VictimByRace2017B <- VictimByRace2017A [2:8, ]
colnames(VictimByRace2017B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                "Robbery", "StolenPropertyOffenses")

## 2018
VictimByRace2018A <- t(VictimByRace2018)
VictimByRace2018B <- VictimByRace2018A [2:8, ]
colnames(VictimByRace2018B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                "Robbery", "StolenPropertyOffenses")

## 2019
VictimByRace2019A <- t(VictimByRace2019)
VictimByRace2019B <- VictimByRace2019A [2:8, ]
colnames(VictimByRace2019B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                "Robbery", "StolenPropertyOffenses")


# Now lets put all of these together so we can start some wrangling
VictimByRace2015to2019 <- rbind(VictimByRace2015B, VictimByRace2016B, VictimByRace2017B, VictimByRace2018B,
                                VictimByRace2019B)

## Now lets check the data format
str(VictimByRace2015to2019)
## Lets change these into numeric

