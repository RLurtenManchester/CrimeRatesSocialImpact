library(dplyr)
library(tidyr)
## Load in the Dataset Crime By Number 1981-2000

### Lets trim this down to the data that we need
CrimeByNumber81_00 <- Crime_By_Number_1981_2000[9:28, 1:12]

## Now lets rename all the columns 
colnames(CrimeByNumber81_00) = c("Year/Population", "CrimeIndexTotal", "", "ViolentCrime", "PropertyCrime", "Murder/NonNegligentManslaughter", "Rape", "Robbery", "AggravatedAssault", "Burglary", "Larceny/Theft", "MotorVehicleTheft")

#Separating the Year from the Population
CrimeByNumber81_00A <- separate(CrimeByNumber81_00, "Year/Population", c("Year", "Population"), sep= "-")


## Load in the Dataset Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019
### Lets trim this one down also to the data that we need