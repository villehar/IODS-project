
#Ville Harjunen
#30.01.2017
#Wrangling of the learning2014 data

# Reading the full learning2014 data from the offered link
learning2014 <- read.table("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt", header = T)

# exploring the data dimensions revealed the data farme consists of 60 colums (variables) and 183 rows (observations).
dim(learning2014)

# exploring the data sructure revealed the data farme consists of 59 varibales with numeric data type and one factor variable. 
# Most of the variables represent the raw data, that is participants' ratings to signle questions whereas the "Attitude" variable is most probably a sum variable
str(learning2014)

# Create the sum variables. Here I use attach command in order to avoid writing the dataset name over and over again. 
attach(learning2014)
learning2014$deep <- (D03 + D11 + D19 + D27 + D07 + D14 + D22 + D30 + D06 + D15 + D23 + D31)/12
learning2014$surf <- (SU02 + SU10 + SU18 + SU26 + SU05 + SU13 + SU21 + SU29 + SU08 + SU16 + SU24 + SU32)/12
learning2014$stra <- (ST01 + ST09 + ST17 + ST25 + ST04 + ST12 + ST20 + ST28)/8

# The new variables were succesfully saved to the dataset
str(learning2014)

# creating a new analysis dataset using the subset of variables included in learning2014. Observations with no exam points are excluded. 
data14 <- subset(learning2014, Points != 0, select= Age:stra) 

# The new analysis data has 7 variables and 166 observations 
str(data14)

#Setting the working directory of the R session to my local IODS project folder 
setwd("//home.org.aalto.fi/harjunv1/data/Desktop/GitHub/IODS_project/data")

# Analysis data was saved to comma delimited format to the data folder
write.table(data14, file = "learning2014.csv", sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE)

# Finally, the comma delimited text file was read and inspected with head and str commands to see whether the format was right
Data_new = read.csv(file = "learning2014.csv", header = TRUE)
head(Data_new)
str(Data_new)
