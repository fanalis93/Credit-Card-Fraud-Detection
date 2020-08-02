#load library
library(tidyverse)
library(dplyr)
library(lubridate)
library(e1071)
library(caret)
library(ggplot2)
library(caTools)

#reading the dataset
svmdata = read.csv('final_model_data.csv')
svmdata$Risk_user <- as.factor(svmdata$Risk_user)
#split data into 8.5:1.5
sm <- floor(0.85 * nrow(svmdata))
set.seed(123)
ti <- sample(seq_len(nrow(svmdata)), size = sm)
train <- svmdata[ti,]
test <- svmdata[-ti,]

#creating train and test set for modeling 
trainset <-train%>%select(Gender, Income,
                     Marital_status, Own_car,No_children, Risk_user)
testset <-test%>%select(Gender, Income,
                   Marital_status, Own_car, No_children, Risk_user)

#creating the classifier for SVM
classifier = svm(formula=Risk_user~.,data = trainset,type = 'C-classification',kernel = 'polynomial')
#predict on test data
y_pred = predict(classifier, newdata = testset)
y_pred

#creating confusion matrix
cm <- table(y_pred,testset$Risk_user)
confusionMatrix(cm)

#calculating accuracy
accuracy <- function(x){
  sum(diag(x) / (sum(rowSums(x)))) *100
}
accuracy(cm)
# 93.98038

tuneResult <- svm(formula=Risk_user~.,data = trainset,type = 'nu-classification',kernel = 'polynomial',
                  ranges=list(cost=c(0.1,1,10,100,1000), gamma=c(0.1,1,10,100)))
print (tuneResult)

svm_model_after_tune = svm(formula=Risk_user~.,data = trainset,type = 'nu-classification',kernel = 'polynomial',
                           degree=3,gamma=0.2,nu=0.5)

tuned_pred = predict(svm_model_after_tune, newdata = testset)
tuned_conf = table(tuned_pred,testset$Risk_user)
confusionMatrix(tuned_conf)
accuracy(tuned_conf)

#####
library(MlBayesOpt)

set.seed(71)
res0 <- svm_cv_opt(data = trainset,
                   label = Risk_user,
                   n_folds = 3,
                   init_points = 10,
                   n_iter = 1)



