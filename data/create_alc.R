
#Ville Harjunen, 9.02.2017
##Exercise 3: Logistic regression, IODS-project

### The data used in this excercise (STUDENT ALCOHOL CONSUMPTION Data Set) was uploaded from the UCI Machine Learning Repository




# Reading the student-mat and student-por files

student_mat = read.csv(file = "student-mat.csv", header = TRUE, sep = ";")

student_por = read.csv(file = "student-por.csv", header = TRUE, sep = ";")

# exploring student_por structure reveales that the data set consists of 649 observations and 33 variables and that most of the variables are either factors or integers
str(student_por)

# student_mat data frame has fewer observations (395) but same variables
str(student_mat)

# loading the plyr package for merging the two data sets
library(dplyr)

# defining the join_by vector
join_by <- c("school","sex","age","address","famsize","Pstatus","Medu","Fedu","Mjob","Fjob","reason","nursery","internet")

# Joining the mat and por using inner_join function and join_by as the identifier 
math_por <- inner_join(student_mat, student_por, by = join_by, suffix = c(".mat", ".por"))

# Exploring the structure and dimensions of the new math_por data revealed that it contains 382 observations and 53 variables
str(math_por)

# Because many of the variables were dublicated as a result of merging, the duplicated answers were next combined

# printing out the column names of the joined math_por data set
column_name = colnames(math_por)

# creating a new data frame with only the joined columns
alc <- select(math_por, one_of(join_by))

# definin the columns in the datasets which were not used for joining the data
notjoined_columns <- colnames(student_mat)[!colnames(student_mat) %in% join_by]
print(notjoined_columns)

# the following for -loop selects two columns 
# from the math-por with the same original name and if the first column
# is numeric, it calculates a rounded average of the two columns.
# If, in turn, the first colunm vector is not numeric, only the first
# vector of the two is included in the joined data frame every column name not used for joining

for(column_name in notjoined_columns) {
  two_columns <- select(math_por, starts_with(column_name))
  first_column <- select(two_columns, 1)[[1]]
  
  if(is.numeric(first_column)) {
    alc[column_name] <- round(rowMeans(two_columns))
  } else {
    alc[column_name] <- first_column
  }
}

#checking the modified joined data set
str(alc)

# Adding a new variable of average alcohol use from the whole week use
alc <- mutate(alc, alc_use = (Dalc + Walc) / 2)

# Using the new alc_use to create a logical variable of high use
alc <- mutate(alc, high_use = alc_use > 2)

# Taking a look into the new data set
glimpse(alc)

# saving the data set to the "data" folder
write.table(alc, file = "student_alc.csv", sep = ",",
            eol = "\n", na = "NA", dec = ".", row.names = TRUE,
            col.names = TRUE)
