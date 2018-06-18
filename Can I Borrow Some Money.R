credit = read.csv("cs-train.csv", header = TRUE) # reading in the dataset
str(credit) # View the structure of the data to see the data types
summary(credit) # five number summary
library(corrplot)
credit_miss <- na.omit(credit) # temporarily remove NA's before correlation plot
corrplot(cor(credit_miss), method = "number", tl.cex = 0.5) # correlation matrix
credit_miss$SeriousDlqin2yrs[credit_miss$SeriousDlqin2yrs == 0] <- "No"
credit_miss$SeriousDlqin2yrs[credit_miss$SeriousDlqin2yrs == 1] <- "Yes"
credit_miss$SeriousDlqin2yrs <- as.factor(credit_miss$SeriousDlqin2yrs) #change the outcome variable to categorical(factor)
sum(is.na(credit_miss)) # count the number of NA's in the data
credit_sub <- subset(credit_miss, select = -c(NumberOfTimes90DaysLate,NumberOfTime60.89DaysPastDueNotWorse))
str(credit_sub) # view to make sure both fields are removed
library(ggplot2)
credit_sub$RevolvingUtilizationOfUnsecuredLines[credit_sub$RevolvingUtilizationOfUnsecuredLines > 1] <- NA
boxplot(credit_sub$age, main = "Age Boxplot")
ggplot(credit_sub, aes(age)) + geom_histogram(binwidth = 4) + labs(title="Age Histogram")
credit_sub$age[credit_sub$age < 21] <- NA
credit_sub$age[credit_sub$age > 90] <- NA
boxplot(credit_sub$NumberOfTime30.59DaysPastDueNotWorse, main = "Number Of Times 30 - 59 Days Past Due Not Worse Boxplot")
ggplot(credit_sub, aes(NumberOfTime30.59DaysPastDueNotWorse)) + geom_histogram(binwidth = 2) + labs(title="Number Of Time 30 - 59 Days Past Due Not Worse")
credit_sub$NumberOfTime30.59DaysPastDueNotWorse[credit_sub$NumberOfTime30.59DaysPastDueNotWorse > 10]  <- NA
credit_sub$DebtRatio[credit_sub$DebtRatio > 1] <- NA
boxplot(credit_sub$MonthlyIncome, main = "Monthly Income Boxplot")
ggplot(credit_sub, aes(MonthlyIncome)) + geom_histogram() + labs(title="Monthly Income")
ggplot(credit_sub, aes(MonthlyIncome)) + geom_histogram(bins = 75) + labs(title="Monthly Income")+ xlim(0, 50000)
credit_sub$MonthlyIncome[as.integer(credit_sub$MonthlyIncome) > 14000] <- NA
boxplot(credit_sub$MonthlyIncome, main = "Monthly Income Boxplot")
boxplot(credit_sub$NumberOfOpenCreditLinesAndLoans, main = "Number Of Open Credit Lines And Loans Boxplot")
ggplot(credit_sub, aes(NumberOfOpenCreditLinesAndLoans)) + geom_histogram(bins = 30) + labs(title="Number Of Open Credit Lines And Loans")
credit_sub$NumberOfOpenCreditLinesAndLoans[credit_sub$NumberOfOpenCreditLinesAndLoans > 20] <- NA
boxplot(credit_sub$NumberRealEstateLoansOrLines, main = "Number Real Estate Loan Or Lines Boxplot")
ggplot(credit_sub, aes(NumberRealEstateLoansOrLines)) + geom_histogram(bins = 30) + labs(title="Number Real Estate Loans Or Lines")
credit_sub$NumberRealEstateLoansOrLines[credit_sub$NumberRealEstateLoansOrLines > 7] <- NA
boxplot(credit_sub$NumberOfDependents, main = "Number of Dependents")
ggplot(credit_sub, aes(NumberOfDependents)) + geom_histogram(binwidth = 1) + labs(title= "Number Of Dependents")
credit_sub$NumberOfDependents[credit_sub$NumberOfDependents > 5] <- NA
sum(is.na(credit_sub))
credit_clean <- na.omit(credit_sub)
attach(credit_clean)
ggplot(data=credit_clean, aes(SeriousDlqin2yrs,RevolvingUtilizationOfUnsecuredLines)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = " Revolving Utilization Of Unsecured Lines by Serious Deliquency")
t.test(RevolvingUtilizationOfUnsecuredLines~SeriousDlqin2yrs, var.equal=FALSE) # testing the means of the two groups
ggplot(credit_clean, aes(SeriousDlqin2yrs,age)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = "Age by Serious Deliquency")
t.test(age~SeriousDlqin2yrs, var.equal=FALSE)
ggplot(credit_clean, aes(SeriousDlqin2yrs,NumberOfTime30.59DaysPastDueNotWorse)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = "NumberOfTimes 30 -59 Days Past Due Not Worse by Serious Deliquency")
t.test(NumberOfTime30.59DaysPastDueNotWorse~SeriousDlqin2yrs, var.equal=FALSE)
ggplot(credit_clean, aes(SeriousDlqin2yrs,DebtRatio)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = "Debt Ratio by Serious Deliquency")
t.test(DebtRatio~SeriousDlqin2yrs, var.equal=FALSE)
ggplot(credit_clean, aes(SeriousDlqin2yrs,MonthlyIncome)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = "Monthly Income by Serious Deliquency")
t.test(MonthlyIncome~SeriousDlqin2yrs, var.equal=FALSE)
ggplot(credit_clean, aes(SeriousDlqin2yrs,NumberOfOpenCreditLinesAndLoans)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = "Number Of Open Credit Lines And Loans by Serious Deliquency")
t.test(NumberOfOpenCreditLinesAndLoans~SeriousDlqin2yrs, var.equal=FALSE)
ggplot(credit_clean, aes(SeriousDlqin2yrs,NumberOfDependents)) +
geom_bar(stat="identity", position=position_dodge()) + labs(title = "Number Of Dependents by Serious Deliquency")
t.test(NumberOfDependents~SeriousDlqin2yrs, var.equal=FALSE)
table(credit_clean$SeriousDlqin2yrs) # view the balance of the out
library(caret)
attach(credit_clean)
sample_data <- createDataPartition(SeriousDlqin2yrs, p = 0.7, list = FALSE) # splitting 70/30 train and test
train <- credit_clean[sample_data,] # training set
test <- credit_clean[-sample_data,] # testing set
table(train$SeriousDlqin2yrs) # viewing the train set proportionality of the outcome variable
table(test$SeriousDlqin2yrs) # viewing the test set proportionality of the outcome variable
dim(train)
dim(test)
library(ROCR)
library(ROSE)
logit_model <- glm(SeriousDlqin2yrs ~.-X, data = train, family = "binomial") # binomial for binary classification
summary(logit_model) # summary of the model
logit_pred <- predict(logit_model,newdata = test, type = "response") # predicting the class on unseen data
logit_preds <- ifelse(logit_pred > 0.5, "Yes", "No") # threshold probabilities greater than 0.5
confusionMatrix(table(logit_preds,test$SeriousDlqin2yrs)) # confusion matrix and Kappa Statistic
roc.curve(test$SeriousDlqin2yrs, logit_pred) #
data_oversample_train <- ovun.sample(SeriousDlqin2yrs ~.,data = train, method = "over")$data
table(data_oversample_train$SeriousDlqin2yrs)
data_oversample_test <- ovun.sample(SeriousDlqin2yrs ~.,data = test, method = "over")$data
table(data_oversample_test$SeriousDlqin2yrs)
logit_model2 <- glm(SeriousDlqin2yrs ~ RevolvingUtilizationOfUnsecuredLines + age + NumberOfTime30.59DaysPastDueNotWorse + MonthlyIncome + NumberOfDependents, data = data_oversample_train, family = "binomial")
summary(logit_model2)
os_pred <- predict(logit_model2, newdata = data_oversample_test, type = "response") # predicting the class on unseen data
os_preds <- ifelse(os_pred > 0.5,"Yes", "No") # threshold of probabilities greater than 0.5
confusionMatrix(table(data_oversample_test$SeriousDlqin2yrs,os_preds)) # confusion matrix
roc.curve(data_oversample_test$SeriousDlqin2yrs, os_preds)
data_rose_train <- ROSE(SeriousDlqin2yrs ~., data = train)$data # synthetic training data generated enlarges the features space of minority and majority class examples.
data_rose_test <- ROSE(SeriousDlqin2yrs ~., data = test)$data # synthetic testing data generated enlarges the features space of minority and majority class examples.
table(data_rose_train$SeriousDlqin2yrs)
table(data_rose_test$SeriousDlqin2yrs)
logit_model3 <- glm(SeriousDlqin2yrs~.-X, data = data_rose_train, family = "binomial") # added the new ROSE sampling training data
summary(logit_model3) # summary of the model
os_pred3 <- predict(logit_model3, newdata = data_rose_test, type = "response") # predicting the class using ROSE testing sample
os_preds3 <- ifelse(os_pred3 > 0.5,"Yes", "No")# threshold of probabilities greater than 0.5
confusionMatrix(table(data_rose_test$SeriousDlqin2yrs,os_preds3)) # confusion matrix
roc.curve(data_rose_test$SeriousDlqin2yrs, os_preds3)
library(rpart)
rf_model <- train(SeriousDlqin2yrs ~.-X, data = data_oversample_train, method = "rpart", trControl = trainControl("repeatedcv", number = 10)) # decision tree model with cross-validation
print(rf_model) # Plot the trees
par(xpd = NA) # Avoid clipping the text in some device
plot(rf_model$finalModel)# Plot the final tree model
text(rf_model$finalModel,  digits = 3) # adding the names of the relevant variable names to the trees
dt_y_hat <- predict(rf_model, data_oversample_test)
confusionMatrix(table(dt_y_hat,data_oversample_test$SeriousDlqin2yrs))
roc.curve(data_oversample_test$SeriousDlqin2yrs, dt_y_hat)
knn_model <- train(SeriousDlqin2yrs ~.-X, data = data_oversample_train, method = "knn",trControl = trainControl("repeatedcv", number = 10),preProcess = c("center","scale"), tuneLength = 10) # Set tuneLength to random to a random value to find the best one
print(knn_model) # summary of our model
knn_model$bestTune # optimal value for k
knn_y_hat <- predict(knn_model, data_oversample_test) # predicting the class on unseen data
confusionMatrix(table(knn_y_hat,data_oversample_test$SeriousDlqin2yrs)) # confusion matrix
roc.curve(data_oversample_test$SeriousDlqin2yrs, knn_y_hat)
ctrl <- trainControl(method="repeatedcv",repeats = 3,classProbs=TRUE,summaryFunction = twoClassSummary)
knn_model2 <- train(SeriousDlqin2yrs ~.-X, data = data_oversample_train, method = "knn",trControl = ctrl,preProcess = c("center","scale"), tuneLength = 5)
knn_model2
knn_y_hat2 <- predict(knn_model2, data_oversample_test) # predicting the class on unseen data
confusionMatrix(knn_y_hat2,data_oversample_test$SeriousDlqin2yrs) # confusion matrix
roc.curve(data_oversample_test$SeriousDlqin2yrs, knn_y_hat2) # ROC curve
library(caretEnsemble)
control <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions='final', classProbs=TRUE)
algorithmList <- c('gbm', 'rpart', 'glm', 'knn', 'nb') # stacking 5 modeling techniques
ensemble_learning <- caretList(SeriousDlqin2yrs~.-X, data=data_oversample_train, trControl=control, methodList=algorithmList)
results <- resamples(ensemble_learning)
summary(results) # summary of all the combined models
dotplot(results) # plot to check Kappa and Accuracy differences
stackControl <- trainControl(method="repeatedcv", number=10, repeats=3, savePredictions='final', classProbs=TRUE)
stack.glm <- caretStack(ensemble_learning, method="glm", metric="Accuracy", trControl=stackControl)
print(stack.glm)
stacked_pred <- predict(stack.glm, data_oversample_test)
confusionMatrix(stacked_pred,data_oversample_test$SeriousDlqin2yrs)
submission <- data.frame(ID = data_oversample_test$X, Serious_Deliquency = os_pred)
head(submission)
write.csv(submission, file = "MySubmission.csv", row.names = F)
