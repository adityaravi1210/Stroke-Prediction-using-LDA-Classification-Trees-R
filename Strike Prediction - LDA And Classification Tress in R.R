#Loading all essential packages & Libraries
library(funModeling) 
library(tidyverse) 
library(Hmisc)
install.packages("caTools")
install.packages("partykit")
install.packages("pscl",dependencies = TRUE)
library(MASS)
library(stats)
library(pscl)
library(rms)
library(plyr)
library(caTools)
library(partykit)
library(MASS)
library(stats)
library(pscl)
library(rms)
library(plyr)

install.packages("randomForest",dependencies = TRUE)
library(randomForest)

#Importing the dataset
df.raw1 <- read.csv(file ='healthcare-dataset-stroke-data.csv')
str(df.raw1)
summary(df.raw1)

#Data Cleaning and Preprocessing
count(df.raw1$bmi=="N/A")
#deleting rows where BMI is not available
df.raw1<-subset(df.raw1, bmi!="N/A")
head(df.raw1)
df.raw1$bmi<-as.numeric(df.raw1$bmi)
#Converting charachter to factor variables
df.raw1$gender<-as.factor(df.raw1$gender)
df.raw1$ever_married<-as.factor(df.raw1$ever_married)
df.raw1$work_type<-as.factor(df.raw1$work_type)
df.raw1$Residence_type<-as.factor(df.raw1$Residence_type)
df.raw1$smoking_status<-as.factor(df.raw1$smoking_status)

#Checks and Data Visulaiation
basic_eda <- function(data)
{
  glimpse(data)
  print(status(data))
  freq(data) 
  print(profiling_num(data))
  plot_num(data)
  describe(data)
}

basic_eda(df.raw1)

freq(df.raw1)

#Reading csv file

frame<-read.csv("healthcare-dataset-stroke-data.csv")
head(frame)
frame<-data.frame(frame)
#Identifying number of rows where BMI is not available
count(frame$bmi=="N/A")
#deleting rows where BMI is not available
cleanedframe<-subset(frame, bmi!="N/A")
head(cleanedframe)


frame<-cleanedframe
frame$bmi<-as.numeric(frame$bmi)

#standardize continuous variables before performing LDA
frame$StandardizeAge<-(frame$age-mean(frame$age))/sd(frame$age)
frame$StandardizeAvgGlucoseLevel<-(frame$avg_glucose_level-mean(frame$avg_glucose_level))/sd(frame$avg_glucose_level)
frame$StandardizeBMI<-(frame$bmi-mean(frame$bmi))/sd(frame$bmi)
head(frame) 

#Create training and testing data sets
ind<-sample(1:nrow(frame), 3400)
print(ind)
train_data<-frame[ind,]
test_data<-frame[-ind,]
head(test_data)

head(train_data)

#Using Linear Regression to understand statistical significance of variables and compare coefficients
fit=lm(train_data$stroke ~ StandardizeAge + StandardizeAvgGlucoseLevel + StandardizeBMI, data=train_data)
print(fit)
summary(fit) 

#Fitting lda model using training data set
fit3 = lda(stroke ~ StandardizeAge + StandardizeAvgGlucoseLevel + StandardizeBMI, data=train_data)
print(fit3)
summary(fit3)
plot(fit3)


#Predict using training data set and evaluate accuracy
pred<-predict(fit3, newdata=train_data)
print(pred)
print(pred$class)
CT<-table(train_data$stroke, pred$class)
print(CT)
mean(train_data$stroke == pred$class) 


#Predict using test data set and evaluate accuracy
pred<-predict(fit3, newdata=test_data)
print(pred)
print(pred$class)
CT<-table(test_data$stroke, pred$class)
print(CT)
mean(test_data$stroke == pred$class)

#Utilizing classification trees

#Reading csv file
frame<-read.csv(file ='healthcare-dataset-stroke-data.csv')
head(frame)
frame<-data.frame(frame)

#Identifying number of rows where BMI is not available
count(frame$bmi=="N/A")
#deleting rows where BMI is not available
cleanedframe<-subset(frame, bmi!="N/A")
head(cleanedframe)
frame<-cleanedframe
frame$bmi<-as.numeric(frame$bmi)
head(frame)

#categorizing Stoke as Yes/No
frame$stroke<-ifelse(frame$stroke==1,"Yes","No")
head(frame)

#Creating Train-Test Split
smp_size <- floor(0.7 * nrow(frame))
train_size <- sample(seq_len(nrow(frame)), size = smp_size)
train <- frame[train_size,]
test <- frame[-train_size,]

#Creating Model for Training
rf <- randomForest(as.factor(stroke) ~ gender+age+hypertension+heart_disease+ever_married+work_type+Residence_type+avg_glucose_level+bmi+smoking_status,data=train)
rfpred <- predict(rf, newdata = test)

#validation
ct<-table(test$stroke, rfpred)
print(ct)
mean(test$stroke == rfpred)
plot(rf)
importance((rf))

