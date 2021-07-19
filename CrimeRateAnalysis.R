## Import Dataset
CrimeRate2000thru2019A <- CrimeRate2000thru2019[, 1:20]

# Narrowing down the Data
## Lets Subset this
keeps <- c("Year", "ViolentCrimeRate", "Murder/NonNegligentManslaughterRate", "Rape(LegacyDefinition)Rate", "RobberyRate", "AggravatedAssaultRate")
CrimeRate2000thru2019Rate <- CrimeRate2000thru2019A[keeps]

CrimeRate2000thru2019B <- as.matrix(CrimeRate2000thru2019Rate)
heatmap(CrimeRate2000thru2019B)
