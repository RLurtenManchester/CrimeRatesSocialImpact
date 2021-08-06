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
keeps<- c("Year", "ViolentCrime", "Murder/NonNegligentManslaughter", "Rape", "Robbery", "AggravatedAssault", "PropertyCrime","Burglary", "Larceny/Theft", "MotorVehicleTheft")

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

## The true question through all of this is, what has effected the violent crime rate the most over the years,
### as well as what has had the most impact on property crime. 

# Lets do some stepwise regression with this

## Baseline
FitAll = lm(ViolentCrime ~ ., data= CrimeByNumber81_19)
summary(FitAll)

## Now lets run this backward
step(FitAll, direction = "backward")
# the following is the formula that seems to fit best
lm(formula = ViolentCrime ~ `Murder/NonNegligentManslaughter` + 
     Rape + Robbery + AggravatedAssault, data = CrimeByNumber81_19)


## Lets Run some stepwise regression on the other crime rates
FitMurder = lm(`Murder/NonNegligentManslaughter` ~ ., data = CrimeByNumber81_19)
summary(FitMurder)

step(FitMurder, direction = "backward")

## Load in Libraries
library(car)
library(caret)
library(gvlma)
library(predictmeans)
library(e1071)

## Lets see if there is any linearity between some of the columns 
# Violent Crime and Property Crime
scatter.smooth(x= CrimeByNumber81_19$ViolentCrime, y= CrimeByNumber81_19$PropertyCrime, main = "Violent Crime related to Property Crime")
## That does look pretty linear, I'll come back to that.

# Murder/NonNegligentHomicide and Rape
scatter.smooth(x= CrimeByNumber81_19$`Murder/NonNegligentManslaughter`, y= CrimeByNumber81_19$Rape, main= "Murder and NonNegligent Homicide in relation to Rape")

# Murder/NonNegligentHomicide and PropertyCrime
scatter.smooth(x= CrimeByNumber81_19$`Murder/NonNegligentManslaughter`, y = CrimeByNumber81_19$PropertyCrime, main= "Murder and NonNegligent Homicide in Relation to Property Crime")
## I didn't think that would be as linear as it is, but that is nearly linear as well


# Lets check for Normal Distribution so we can get into some interpretation of the data. 
plotNormalHistogram(CrimeByNumber81_19$ViolentCrime)
### This is slightly positively skewed
plotNormalHistogram(CrimeByNumber81_19$`Murder/NonNegligentManslaughter`)
### This is positively skewed
plotNormalHistogram(CrimeByNumber81_19$Rape)
# This is normally distributed
plotNormalHistogram(CrimeByNumber81_19$Robbery)
## This is fairly flat but it is normally distributed
plotNormalHistogram(CrimeByNumber81_19$AggravatedAssault)
# This is normally distributed
plotNormalHistogram(CrimeByNumber81_19$PropertyCrime)
### This is negatively skewed
plotNormalHistogram(CrimeByNumber81_19$Burglary)
# This is normally distributed
plotNormalHistogram(CrimeByNumber81_19$`Larceny/Theft`)
### This is negatively skewed
plotNormalHistogram(CrimeByNumber81_19$MotorVehicleTheft)
# This is flat but normally distributed

#Now using SQRT to normalize the distribution of the Violent Crime Data, because it was positively skewed
CrimeByNumber81_19$ViolentCrime_SQRT <- sqrt(CrimeByNumber81_19$ViolentCrime)
plotNormalHistogram(CrimeByNumber81_19$ViolentCrime_SQRT)
#That worked to normalize the curve

#Now SQ to normalize the distribution of the Property Crime data, because it is negatively skewed
CrimeByNumber81_19$PropertyCrime_SQ <- CrimeByNumber81_19$PropertyCrime * CrimeByNumber81_19$PropertyCrime
plotNormalHistogram(CrimeByNumber81_19$PropertyCrime_SQ)
#That worked to normalize the curve

## Lets test for homogeneity of variance
bartlett.test(CrimeByNumber81_19$`Murder/NonNegligentManslaughter` ~ CrimeByNumber81_19$Rape)
fligner.test(CrimeByNumber81_19$`Murder/NonNegligentManslaughter` ~ CrimeByNumber81_19$Rape)
scatter.smooth(x = CrimeByNumber81_19$Year, y = CrimeByNumber81_19$ViolentCrime, main = "Violent Crime over the Years")
