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


