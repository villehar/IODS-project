
# Ville Harjunen
# Exercise 4: clustering and classification

## data wrangling for the next week

# reading the human development data 
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)

# Reading the gender inequality data
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Structure of human development index data
## The hd  data has 195 observations (representing countries) and 8 variables. There are variables  describin the countries' health related factors and variables related to economic wealth and education. 
## The HDI describes the countries' "average achievement in key dimensions of human development: a long and healthy life, being knowledgeable and have a decent standard of living". 
head(hd)
str(hd)

# Gender inequality data describes gender inequality in 195 countries. There is a one gender inequality index (GII) variable and 8 other variables used to create the index. 
head(gii)
str(gii)

names(hd)

# changin the variable names of the hd data
library(plyr)
names(hd)[1] <- "HDI.rank"
names(hd)[2] <- "Country"
names(hd)[3] <- "HDI"
names(hd)[4] <- "Life.Exp"
names(hd)[5] <- "Edu.Exp"
names(hd)[6] <- "Edu.Mean"
names(hd)[7] <- "GNI"
names(hd)[8] <- "GNI.ratio"

# changin the variable names of the gii data
names(gii)[1] <- "GII.rank"
names(gii)[2] <- "Country"
names(gii)[3] <- "GII"
names(gii)[4] <- "Mat.Mor"
names(gii)[5] <- "Ado.Birth"
names(gii)[6] <- "Parli.F"
names(gii)[7] <- "Edu2.F"
names(gii)[8] <- "Edu2.M"
names(gii)[9] <- "Labo.F"
names(gii)[10] <- "Labo.M"

library(dplyr)
gii <- mutate(gii, Edu2.FM = Edu2.F / Edu2.M, Labo.FM = Labo.F / Labo.M)
str(gii)

# defining the identifier
join_by <- "Country"

# join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by)
str(human)

#
setwd("//home.org.aalto.fi/harjunv1/data/Desktop/GitHub/IODS_project/data")
write.csv(human, file = "human.csv")


library(stringr)
# Transforming the GNI to numeric
human$GNI <- str_replace(human$GNI, pattern=",", replace ="") %>% as.numeric() 

# defining a subset of variables that would be used in later analyses
keep <- c("Country", "Edu2.FM", "Labo.FM", "Life.Exp", "Edu.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F")

# Saving the data of the selected variables as "human" data set
human <- select(human, one_of(keep))
str(human)

# filtering out missing values and saving the data as a new "human_" data set
human_ <- filter(human, complete.cases(human) == TRUE)

# the last 7 observations (regions) are removed
last <- nrow(human_) - 7
human_ <- human_[1:last, ]


# defining rownames by countries and deleting the country variable
rownames(human_) <- human_$Country
human_ <- select(human_, -Country)

#the final data set has 155 rows and 8 variable names
str(human_)
head(human_)


write.csv(human_, "human.csv", row.names = TRUE)
human2<- read.csv("human.csv", header = TRUE, row.names = 1)
head(human2)
str(human2)
