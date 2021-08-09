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
## There seems to be a problem with a couple of the years, lets fix that really quick

CrimeByNumber81_19[21, 1] <- 2001
CrimeByNumber81_19[38, 1] <- 2018

## The true question through all of this is, what has effected the violent crime rate the most over the years,
### as well as what has had the most impact on property crime. 

# Lets do some stepwise regression with this
  
## Baseline

FitAllViolent = lm(ViolentCrime ~ ., data= CrimeByNumber81_19)

summary(FitAllViolent)

## Now lets run this backward
step(FitAll, direction = "backward")
# the following is the formula that seems to fit best
lm(formula = ViolentCrime ~ `Murder/NonNegligentManslaughter` + 
     Rape + Robbery + AggravatedAssault, data = CrimeByNumber81_19)


## Lets Run some stepwise regression on the other crime rates
FitMurder = lm(`Murder/NonNegligentManslaughter` ~ ., data = CrimeByNumber81_19)
summary(FitMurder)

step(FitMurder, direction = "backward")

# Stepwise on Rape
FitRape = lm(Rape ~ ., data = CrimeByNumber81_19)
summary(FitRape)

step(FitRape, direction = "backward")

## Load in Libraries
library(car)
library(caret)
library(gvlma)
library(predictmeans)
library(e1071)

## Lets see if there is any linearity between some of the columns 
# Violent Crime and Property Crime
scatter.smooth(x= CrimeByNumber81_19$ViolentCrime, y= CrimeByNumber81_19$PropertyCrime, main = "Violent Crime related to Property Crime")
## Creating the Linear Model
ViolentPropertylmMod <- lm(ViolentCrime ~ PropertyCrime, data = CrimeByNumber81_19)
#Test for Homoscedasticity
par(mfrow = c(2,2))
plot(ViolentPropertylmMod)

lmtest::bptest(ViolentPropertylmMod)
## The p-value is under .05 so it does not meet the need for homoscedasticity
### Correcting for Homoscedasticity violations
dcViolentPropertyMod1 <- caret::BoxCoxTrans(CrimeByNumber81_19$ViolentCrime)
print(dcViolentPropertyMod1)

CrimeByNumber81_19 <- cbind(CrimeByNumber81_19, dist_NewM=predict(dcViolentPropertyMod1, CrimeByNumber81_19$ViolentCrime))
ViolentPropertylmMod_bc2 <- lm(dist_NewM~PropertyCrime, data = CrimeByNumber81_19)
lmtest::bptest(ViolentPropertylmMod_bc2)
## The results are no longer significant so I can continue
## Testing for homogeneity of variance
gvlma(ViolentPropertylmMod_bc2)

summary(ViolentPropertylmMod_bc2)
### There is a significant linear relationship between Violent Crime and Property Crime

# Murder/NonNegligentHomicide and Rape
scatter.smooth(x= CrimeByNumber81_19$`Murder/NonNegligentManslaughter`, y= CrimeByNumber81_19$Rape, main= "Murder and NonNegligent Homicide in relation to Rape")

## Creating the Linear Model
MurderRapelmMod <- lm(`Murder/NonNegligentManslaughter` ~ Rape, data = CrimeByNumber81_19)
#Test for Homoscedasticity
par(mfrow = c(2,2))
plot(MurderRapelmMod)

lmtest::bptest(ViolentPropertylmMod)
## The p-value is under .05 so it does not meet the need for homoscedasticity
### Correcting for Homoscedasticity violations
dcMurderRapeMod1 <- caret::BoxCoxTrans(CrimeByNumber81_19$`Murder/NonNegligentManslaughter`)
print(dcMurderRapeMod1)

CrimeByNumber81_19 <- cbind(CrimeByNumber81_19, dist_NewM2=predict(dcMurderRapeMod1, CrimeByNumber81_19$`Murder/NonNegligentManslaughter`))
MurderRapelmMod_bc2 <- lm(dist_NewM2~Rape, data = CrimeByNumber81_19)
lmtest::bptest(ViolentPropertylmMod_bc2)
## The results are no longer significant so I can continue
## Testing for homogeneity of variance
gvlma(MurderRapelmMod_bc2)

summary(MurderRapelmMod_bc2)
### There is a linear relationship between Murder and Rape

# Murder/NonNegligentHomicide and PropertyCrime
scatter.smooth(x= CrimeByNumber81_19$`Murder/NonNegligentManslaughter`, y = CrimeByNumber81_19$PropertyCrime, main= "Murder and NonNegligent Homicide in Relation to Property Crime")

## Creating the Linear Model
MurderPropertylmMod <- lm(`Murder/NonNegligentManslaughter` ~ PropertyCrime, data = CrimeByNumber81_19)
#Test for Homoscedasticity
par(mfrow = c(2,2))
plot(MurderPropertylmMod)

lmtest::bptest(MurderPropertylmMod)
## The p-value is over .05 so it does meet the need for homoscedasticity
### Correcting for Homoscedasticity violations

## Testing for homogeneity of variance
gvlma(MurderPropertylmMod)

summary(ViolentPropertylmMod)
### There is a significant linear relationship between Murder and Property Crime

# Rape and PropertyCrime
scatter.smooth(x= CrimeByNumber81_19$Rape, y = CrimeByNumber81_19$PropertyCrime, main= "Rape in Relation to Property Crime")

## Creating the Linear Model
RapePropertylmMod <- lm(Rape ~ PropertyCrime, data = CrimeByNumber81_19)
#Test for Homoscedasticity
par(mfrow = c(2,2))
plot(RapePropertylmMod)

lmtest::bptest(MurderPropertylmMod)
## The p-value is over .05 so it does meet the need for homoscedasticity
### Correcting for Homoscedasticity violations

## Testing for homogeneity of variance
gvlma(RapePropertylmMod)

summary(RapePropertylmMod)
### There is not a significant linear relationship between Rape and Property Crime
