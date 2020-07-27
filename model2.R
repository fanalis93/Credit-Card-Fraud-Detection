library(e1071)
library(caTools)
dataset = final

att = c('Gender','Own_car','Own_realty','No_children','Income','Marital_status','No_family_members','Risk_user')
ggwp = subset(dataset,select = c('Gender','Own_car','Own_realty','No_children','Income','Marital_status','No_family_members','Risk_user'))

ggwp$Gender <- as.numeric(ggwp$Gender)
ggwp$Own_car <- as.numeric(ggwp$Own_car)
ggwp$Own_realty <- as.numeric(ggwp$Own_realty)
ggwp$Marital_status <- as.numeric(ggwp$Marital_status)
dataset=ggwp

dataset
#splitting into training and test set
set.seed(123)
split = sample.split(dataset$Risk_user, SplitRatio=0.50)
new_train = subset(dataset, split==TRUE)
new_test = subset(dataset, split==FALSE)

#feature scaling
new_train[-8] = scale(new_train[-8])
new_test[-8] = scale(new_test[-8])
test_num <- new_train[sapply(new_train,is.numeric)]
test_cat = new_test[sapply(new_test,is.factor)]
test_cat_dummy = dummy.data.frame(test_cat)
final_test_sd  = cbind(test_num,test_cat_dummy)



#build svm
x_sd <- subset(new_train,select=-8)
y_sd <- (new_train$Risk_user)

a_sd <- subset(new_test, select=-8)
b_sd <- new_test$Risk_user

model_svm <- svm(x_sd,y_sd, kernal="linear")
pred_svm <- predict(model_svm, a_sd)

library(rpart)
library(dummies)
library(vegan)
library(caret)
acc_svm <- confusionMatrix(b_sd, pred_svm)$overall[1]
acc_svm
cm =  table(b_sd,pred_svm)
cm

#tuning svm to get best results
# <- tune(svm, train.x = x_sd, train.y = y_sd, ranges = list(gamma = 10^(-6:-1), cost = 2^(2:3)))
#print(tuneResult)

pred_svm_test = predict(model_svm,as.matrix())


