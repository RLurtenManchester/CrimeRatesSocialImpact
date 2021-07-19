## Import Dataset
CrimeRate2000thru2019A <- CrimeRate2000thru2019[, 1:20]

#Load ggplot
library(ggplot2)
# Narrowing down the Data
## Lets Subset this
keeps <- c("Year", "ViolentCrimeRate", "Murder/NonNegligentManslaughterRate", "Rape(LegacyDefinition)Rate", "RobberyRate", "AggravatedAssaultRate")
CrimeRate2000thru2019Rate <- CrimeRate2000thru2019A[keeps]

CrimeRate2000thru2019B <- as.matrix(CrimeRate2000thru2019Rate)
heatmap(CrimeRate2000thru2019B)

barchart(CrimeRate2000thru2019Rate$ViolentCrimeRate)
# Converting everything into factors

Crime <- c(1:6, )
CrimeRate2000thru2019Rate[,Crime] <- lapply(CrimeRate2000thru2019Rate[,Crime] , factor)
str(CrimeRate2000thru2019Rate)

CrimeRate2000thru2019RateA <- as.factor(CrimeRate2000thru2019Rate)

ggplot(CrimeRate2000thru2019A, aes(`Murder/NonNegligentManslaughter`)) + geom_bar()
### This isnt seeming to do what i want and Tableau created the graphs I wanted

library(dplyr)
library(rcompanion)
library(ggplot2)
library(car)
library(IDPmisc)
plotNormalHistogram(CrimeRate2000thru2019A$`Murder/NonNegligentManslaughter`)
plotNormalHistogram(CrimeRate2000thru2019A$`Rape(LegacyDefinition)`)
plotNormalHistogram(CrimeRate2000thru2019A$ViolentCrime)
