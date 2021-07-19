# Open Files 
## I edited the title and explanation lines out of the dataset
library(ggplot2)
library(lattice)
barchart(Crime_By_Number_1981_2000$`Violent crime3`)
Crime2000thru2019 <- Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B

ggplot(Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B) +
  geom_bar(mapping = aes(x= Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B$`Violent
crime2` )) 


#Hmm... Lets see a heatmap
Crime_By_Number_1981_2000B <- as.matrix(Crime_By_Number_1981_2000A)
heatmap(Crime_By_Number_1981_2000B)

dfrecode <- df %>%
  mutate(recode = as.numeric(factor(y)))
str(dfrecode)
Crime_By_Number_1981_2000C <- Crime_By_Number_1981_2000(recode = as.numeric(factor(y)))
str(Crime_By_Number_1981_2000C)

str(Crime_By_Number_1981_2000)
str(Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B)
ggplot(data= Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B) +
  geom_bar(mapping = aes(x= Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B$Year, fill = Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B$`Violent
crime2`)) + ggtitle('Murder Over The Years') + xlab("Year") + ylab("Murder Rate")

# Renaming Columns to make this all easier to work with
names(Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B)[names(Table_1_Crime_in_the_United_States_by_Volume_and_Rate_per_100000_Inhabitants_2000_2019B) == "`Murder and
nonnegligent 
manslaughter`"] <- Murder/NonNegligentHomicide

## Went in and renamed all of the columns in the Excel chart so now re downloading it and trying all that again
## library(readxl)
## CrimeRate2000thru2019 <- read_excel("CrimeRate2000thru2019.xls")
## View(CrimeRate2000thru2019)
ggplot(data = Crime2000thru2019) + 
  geom_bar(mapping = aes(x= Year, fill = ViolentCrime))
