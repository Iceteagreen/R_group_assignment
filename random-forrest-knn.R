# Cleaning memory
rm(list = ls())

# Loading dataset
crypto_prices <- read.csv("input/crypto_prices.csv", 
                          header = T, 
                          stringsAsFactors = F)

# Loading libraries
library(ggplot2)
library(plotly)
library(dplyr)
library(caret)

# Top 5 coins ------------------------------------------------------------------
prices <- subset(crypto_prices, coin == "BTC" | 
                   coin == "ETH" | 
                   coin == "XRP" | 
                   coin == "BCH")

## Saving
write.csv(prices, file = 'plotdata/prices.csv', row.names = FALSE)



# Creating months --------------------------------------------------------------
prices$Months <- substr(prices$Date, 6, 7)
prices$Year <- substr(prices$Date, 1, 4)
prices$Day <- substr(prices$Date, 9, 10)
prices$Month_Year <- paste(prices$Year, prices$Months, sep = "-")

# Cleaning variables -----------------------------------------------------------
prices$Volume <- as.numeric(gsub(",", "", prices$Volume))
prices$Market.Cap <- as.numeric(gsub(",", "", prices$Market.Cap))
prices$coin <- as.factor(prices$coin)

# Removing NA ----------------------------------------------------------------
index_na <- which(is.na(prices$Volume))
prices$Volume[index_na] <- mean(prices$Volume, na.rm = T)

index_na <- which(is.na(prices$Market.Cap))
prices$Market.Cap[index_na] <- mean(prices$Market.Cap, na.rm = T)

# Creating up / down method ----------------------------------------------------
prices$market_direction <- "None"
prices$market_direction <- as.factor(ifelse(prices$Delta < 0, "Down", "Up"))

# Creating lag variabel --------------------------------------------------------
prices$earlier_price_1 <- 0
prices$earlier_price_1 <- lag(prices$Delta, k = 1)


# Train/ Test set --------------------------------------------------------------
index <- nrow(prices) * 0.2

prices <- group_by(prices, Date, coin)
test <- prices[1:index,]
train <- prices[index:nrow(prices),]

# Training a model to predict new prices
# Gridsearch -----------------------------------------------------------------
kg <- expand.grid(k = c(1, 2, 3, 4, 5, 10))

# Fitting the KNN ------------------------------------------------------------
knctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 5)
model.fit <- train(market_direction ~ Open + Volume + Market.Cap + coin +
                     earlier_price_1, 
                   data = train, 
                   method = "knn",
                   trControl= knctrl,
                   preProcess = c("center", "scale"),
                   tuneGrid = kg)

# Fitting RandomForest -------------------------------------------------------
rfcntrl <- trainControl(method = "repeatedcv", repeats = 1)
system.time({forest.fit <- train(market_direction ~ Open + Volume + Market.Cap + coin +
                                   earlier_price_1, 
                                 data = train,
                                 method = "rf",
                                 trControl = rfcntrl,
                                 preProcess = c("center", "scale"),
                                 tuneLength = 10)})

# Validation -------------------------------------------------------------------
# KNN Prediction ---------------------------------------------------------------
results <- predict(model.fit, test)
confusionMatrix(results, test$market_direction[2:nrow(test)])

# We start from the second entry, because the first entry has no value due to
# the lag function! 

# Random Forest Prediction -----------------------------------------------------
forest.pred <- predict(forest.fit, newdata = test)
confusionMatrix(forest.pred, test$market_direction[2:nrow(test)])

## Saving
write.csv(train, file = 'plotdata/train.csv', row.names = FALSE)
# END OF CODE  -----------------------------------------------------------------