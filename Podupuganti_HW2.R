headers <- c('Class','Specimen_Number','Eccentricity', 'Aspect_Ratio', 'Elongation', 'Solidity', 'Stochastic_Convexity','Isoperimetric_Factor','Maximal_Indentation_Depth','Lobedness','Average_Intensity','Average_Contrast','Smoothness','Third_moment','Uniformity','Entropy')
data <- read.csv('~/Desktop/SEM2/DM/HW2/leaf/leaf.csv',header=FALSE)
names(data) <- headers # setting headers


boxplot(data$Aspect_Ratio,data$Elongation, data$Solidity,main="boxplots for AspectRatio, Elongation, Solidity",names = c("AspectRatio","Elongation","Solidity"))


data<-data[!(data$Aspect_Ratio >= 5 | data$Solidity <= 0.9),]
data

boxplot(data$Aspect_Ratio,data$Elongation, data$Solidity,main="boxplots for AspectRatio, Elongation, Solidity after removing outliers",names = c("AspectRatio","Elongation","Solidity"))

library(C50)
tree_C50 <- C50::C5.0(x = data[, -c(1)], y = as.factor(data$Class)) # as.factor to give input in factors since c5.0 is only accepting that
tree_C50
summary(tree_C50) # printing in textual format
plot(tree_C50) # printing in graphical format

# old method of validation 
c50.prediction <- predict(tree_C50, newdata=data, type="class")
confusion.matrix <- table(data$Class, c50.prediction)
print(confusion.matrix)
accuracy.percent <- 100*sum(diag(confusion.matrix))/sum(confusion.matrix)
print(paste("accuracy:",accuracy.percent,"%"))

set.seed(1) # preventing changes every time we run k fold
#http://inferate.blogspot.com/2015/05/k-fold-cross-validation-with-decision.html
# corss validation for c50
library(caret)
library(plyr)
folds<-createFolds(as.factor(data$Class), k=3)
str(folds)
errs.c50 <- rep(NA, length(folds)) # to store all the folds error. 
form <- "as.factor(Class) ~ ."
for (i in 1:length(folds)) {
  test <- data[unlist(folds[i]),]
  train <- data[unlist(folds[-i]),]
  tmp.model <- C50::C5.0(as.formula(form),train)
  tmp.predict <- predict(tmp.model, newdata=test)
  conf.mat <- table(test$Class, tmp.predict)
  print(conf.mat)
  errs.c50[i] <- 1 - sum(diag(conf.mat))/sum(conf.mat)
  print(sprintf("error using k-fold cross validation %.0f and C5.0 decision tree algorithm: %.3f percent", i,100*(errs.c50[i])))
}

# --------- CART
library(rpart)
tree_CART <- rpart(as.factor(Class) ~ ., data = data, method="class") # as.factor to give input in factors since c5.0 is only accepting that
tree_CART
summary(tree_CART) # printing in textual format
plot(tree_CART)
text(tree_CART, use.n=TRUE, all=TRUE, cex=.8)

# old method of validation 
cart.prediction <- predict(tree_CART, newdata=data, type="class")
confusion.matrix <- table(data$Class, cart.prediction)
print(confusion.matrix)
accuracy.percent <- 100*sum(diag(confusion.matrix))/sum(confusion.matrix)
print(paste("accuracy:",accuracy.percent,"%"))


# corss validation for cart
errs.cart <- rep(NA, length(folds)) # to store all the folds error. 
for (i in 1:length(folds)) {
  test <- data[unlist(folds[i]),]
  train <- data[unlist(folds[-i]),]
  tmp.model <- rpart(form , train, method = "class")
  tmp.predict <- predict(tmp.model, newdata=test, type = 'class')
  conf.mat <- table(test$Class, tmp.predict)
  print(conf.mat)
  #print(caret::confusionMatrix(data=tmp.predict, reference=as.factor(test$Class)))
  errs.cart[i] <- 1 - sum(diag(conf.mat))/sum(conf.mat)
  print(sprintf("error using k-fold cross validation %.0f and CART decision tree algorithm: %.3f percent", i,100*(errs.cart[i])))
}

#--------------------- hypothesis tetsing
h <- t.test(errs.cart, errs.c50, alternative = 'two.sided',conf.level = 0.98,conf.int = TRUE, paired = TRUE)
h
#A small p-value (here typically ≤ 0.02) indicates strong evidence against the null hypothesis, so you reject it.
message <- if(h["p.value"] <= 0.02) 'reject null hypothesis' else 'accept null hypothsis'
message


#------------ predicting for new data from the choosen model
#newtuple <- c(NA,1,0.72694,1.4742,0.32396,0.98535,1,0.83592,0.0046566,0.0039465,0.04779,0.12795,0.016108,0.0052323,0.00027477,1.1756)
lev <- c(1,2,3,4,7,9,10,12,13,14,22,23,24,25,26,27,28,29,30,32,33,35)
newtuple <- as.numeric(as.vector(data[150,])) # taking from exisitng data only
df <- data.frame(matrix(newtuple, nrow=1))
names(df) <- headers
pre <- predict(tree_C50, newdata=df[,-1])
cat("the predicted class for given data is ",lev[pre])


