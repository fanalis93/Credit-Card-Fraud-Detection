'''ggwp <- new_merged
library(vegan)
library(dummies)
num <- ggwp[sapply(ggwp, is.numeric)]
cat <- ggwp[sapply(ggwp, is.factor)]
num_std <- decostand(num,method = "standardize")
cat_dummy <- dummy.data.frame(cat)'''

library(e1071)
library(caTools)
dataset = final

att = c('Gender','Own_car','Own_realty','No_children','Income','Marital_status','No_family_members','Risk_user')
ggwp = subset(dataset,select = c('Marital_status','Income','Risk_user'))

#ggwp$Gender <- as.numeric(ggwp$Gender)
#ggwp$Own_car <- as.numeric(ggwp$Own_car)
#ggwp$Own_realty <- as.numeric(ggwp$Own_realty)
ggwp$Marital_status <- as.numeric(ggwp$Marital_status)

dataset=ggwp

#splitting into training and test set
set.seed(123)
split = sample.split(dataset$Risk_user, SplitRatio=0.75)
training_set = subset(dataset, split==TRUE)
test_set = subset(dataset, split==FALSE)

#feature scaling
training_set[-3] = scale(training_set[-3])
test_set[-3] = scale(test_set[-3])

#fitting  svm to the training set
classifier = svm(formula = Risk_user ~ .,
                 data = training_set,
                 type = 'C-classification',
                 kernel  = 'linear')

#predicting the test results
y_pred = predict(classifier, newdata = test_set[-3])

#making the confusion matrix
confm =  table(test_set[, 3],y_pred)
confm

accuracy <- function(x){
  sum(diag(x) / (sum(rowSums(x)))) *100
}
accuracy(confm)

# Visualising the Training set results
library(ElemStatLearn)
set = training_set
X1 = seq(min(set[, 1]) - 1, max(set[, 1]) + 1, by = 0.01)
X2 = seq(min(set[, 2]) - 1, max(set[, 2]) + 1, by = 0.01)
grid_set = expand.grid(X1, X2)
colnames(grid_set) = c('Own_realty', 'Gender')
y_grid = predict(classifier, newdata = grid_set)
plot(set[, -3],
     main = 'SVM (Training set)',
     xlab = 'Age', ylab = 'Estimated Salary',
     xlim = range(X1), ylim = range(X2))
contour(X1, X2, matrix(as.numeric(y_grid), length(X1), length(X2)), add = TRUE)
points(grid_set, pch = '.', col = ifelse(y_grid == 1, 'springgreen3', 'tomato'))
points(set, pch = 21, bg = ifelse(set[, 3] == 1, 'green4', 'red3'))

