
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
names(hd)[1] <- "hdi.rank"
names(hd)[2] <- "country"
names(hd)[3] <- "hdi"
names(hd)[4] <- "lifexp"
names(hd)[5] <- "eduexp"
names(hd)[6] <- "edumean"
names(hd)[7] <- "gni"
names(hd)[8] <- "gnhdR"

# changin the variable names of the gii data
names(gii)[1] <- "gii.rank"
names(gii)[2] <- "country"
names(gii)[3] <- "gii"
names(gii)[4] <- "mortal"
names(gii)[5] <- "adole"
names(gii)[6] <- "parlia"
names(gii)[7] <- "eduF"
names(gii)[8] <- "eduM"
names(gii)[9] <- "workF"
names(gii)[10] <- "workM"

library(dplyr)
gii <- mutate(gii, eduFM_ratio = eduF / eduM, workFMratio = workF / workM)
str(gii)

# defining the identifier
join_by <- "country"

# join the two datasets by the selected identifiers
human <- inner_join(hd, gii, by = join_by)
str(human)

#
setwd("//home.org.aalto.fi/harjunv1/data/Desktop/GitHub/IODS_project/data")
write.csv(human, file = "human.csv")
