train=german_credit_dataset[-1,-1]
train$Good<- factor(train$Good, levels = c("1", "2"), labels = c("0", "1"))

install.packages('caTools')
library(caTools)
set.seed(88)
split <- sample.split(train$Good, SplitRatio = 0.75)

#get training and test data
dresstrain <- subset(train, split == TRUE)
dresstest <- subset(train, split == FALSE)

#logistic regression model
View(dresstrain)
model <- glm (Good ~ ., data = dresstrain, family=binomial(link="logit"))
summary(model)

predict <- predict(model, type = 'response')

#confusion matrix
table(dresstrain$Good, predict > 0.5)

#ROCR Curve
install.packages("ROCR")
library(ROCR)
ROCRpred <- prediction(predict, dresstrain$Good)
ROCRperf <- performance(ROCRpred, 'tpr','fpr')
plot(ROCRperf, colorize = TRUE, text.adj = c(-0.2,1.7))
