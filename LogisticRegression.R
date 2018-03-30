train=german_credit_dataset[-1,-1]
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
