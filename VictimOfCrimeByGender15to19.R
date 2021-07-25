# Victim of Crime By Gender 2015 to 2019

# Load in datasets
library(readxl)
## 2015
victims_sex_by_offense_category_2015 <- read_excel("victims_sex_by_offense_category_2015.xls")
## 2016
victims_sex_by_offense_category_2016 <- read_excel("victims_sex_by_offense_category_2016.xls")
## 2017
victims_sex_by_offense_category_2017 <- read_excel("victims_sex_by_offense_category_2017.xls")
## 2018
victims_sex_by_offense_category_2018 <- read_excel("victims_sex_by_offense_category_2018.xls")
## 2019
victims_sex_by_offense_category_2019 <- read_excel("victims_sex_by_offense_category_2019.xls")


## Wrangling the data

## 2015
VictimByGender2015 <- victims_sex_by_offense_category_2015 [5:25, 1:5]
# Rename the columns
colnames(VictimByGender2015) <- c("Total", "TotalVictims2015", "Male2015", "Female2015", 
                                  "unknown2015")

## 2016
VictimByGender2016 <- victims_sex_by_offense_category_2016 [5:25, 1:5]
# Rename the columns
colnames(VictimByGender2016) <- c("Total", "TotalVictims2016", "Male2016", "Female2016", 
                                  "unknown2016")

## 2017
VictimByGender2017 <- victims_sex_by_offense_category_2017 [5:25, 1:5]
# Rename the columns
colnames(VictimByGender2017) <- c("Total", "TotalVictims2017", "Male2017", "Female2017", 
                                  "unknown2017")

## 2018
VictimByGender2018 <- victims_sex_by_offense_category_2018 [5:25, 1:5]
# Rename the columns
colnames(VictimByGender2018) <- c("Total", "TotalVictims2018", "Male2018", "Female2018", 
                                  "unknown2018")

## 2019
VictimByGender2019 <- victims_sex_by_offense_category_2019 [5:25, 1:5]
# Rename the columns
colnames(VictimByGender2019) <- c("Total", "TotalVictims2019", "Male2019", "Female2019", 
                                  "unknown2019")

### Load in libraries to keep working on this
library(ggplot2)
library(tidyr)
library(dplyr)

## 2015
VictimByGender2015A <- t(VictimByGender2015)
VictimByGender2015B <- VictimByGender2015A [2:5, ]
colnames(VictimByGender2015B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                  "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                  "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                  "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                  "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                  "Robbery", "StolenPropertyOffenses")

## 2016
VictimByGender2016A <- t(VictimByGender2016)
VictimByGender2016B <- VictimByGender2016A [2:5, ]
colnames(VictimByGender2016B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                  "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                  "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                  "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                  "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                  "Robbery", "StolenPropertyOffenses")

## 2017
VictimByGender2017A <- t(VictimByGender2017)
VictimByGender2017B <- VictimByGender2017A [2:5, ]
colnames(VictimByGender2017B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                  "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                  "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                  "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                  "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                  "Robbery", "StolenPropertyOffenses")

## 2018
VictimByGender2018A <- t(VictimByGender2018)
VictimByGender2018B <- VictimByGender2018A [2:5, ]
colnames(VictimByGender2018B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                  "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                  "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                  "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                  "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                  "Robbery", "StolenPropertyOffenses")

## 2019
VictimByGender2019A <- t(VictimByGender2019)
VictimByGender2019B <- VictimByGender2019A [2:5, ]
colnames(VictimByGender2019B)<- c("Total", "CrimesAgainstPersons", "AssaultOffenses", "HomicideOffenses",
                                  "HumanTraffickingOffenses", "Kidnapping/Abduction", "SexOffenses", 
                                  "SexOffenses/NonForcible", "CrimesAgainstProperty", "Arson", "Bribery", 
                                  "Burglary/BrakingEntering", "Counterfeiting/Forgery", "Destruction/Damage/Vandalism", 
                                  "Embezzelment", "Extortion/Blackmail", "FraudOffenses", "Larceny/Theft","MotorVehicleTheft",
                                  "Robbery", "StolenPropertyOffenses")

# Now lets put all of them together and see how it looks
VictimByGender2015to2019 <- rbind(VictimByGender2015B, VictimByGender2016B, VictimByGender2017B,
                                  VictimByGender2018B, VictimByGender2019B)

FitAll1 = lm(Male2015 ~ ., data = VictimByGender2015)
summary(FitAll1)

