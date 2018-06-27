# Cleaning memory
rm(list = ls())

# Loading dataset
crypto_prices <- read.csv("input/crypto_prices.csv", 
                          header = T, 
                          stringsAsFactors = F)

# Loading libraries  
library(plotly)
library(dplyr)
library(caret)

# Top 5 coins ------------------------------------------------------------------
prices <- subset(crypto_prices, coin == "BTC" | 
                   coin == "ETH" | 
                   coin == "XRP" | 
                   coin == "BCH")

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
prices$earlier_price_2 <- lag(prices$Delta, k = 2)

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
                     earlier_price_1 + earlier_price_2, 
                   data = train, 
                   method = "knn",
                   trControl= knctrl,
                   preProcess = c("center", "scale"),
                   tuneGrid = kg)

# Fitting RandomForest -------------------------------------------------------
rfcntrl <- trainControl(method = "repeatedcv", repeats = 1)
system.time({forest.fit <- train(market_direction ~ Open + Volume + Market.Cap + coin +
                                   earlier_price_1 + earlier_price_2, 
                                 data = train,
                                 method = "rf",
                                 trControl = rfcntrl,
                                 preProcess = c("center", "scale"),
                                 tuneLength = 10)})

# Validation -------------------------------------------------------------------
# KNN Prediction -------------------------------------------------------------
results <- predict(model.fit, test)
confusionMatrix(results, test$market_direction[2:nrow(test)])

# We start from the second entry, because the first entry has no value due to
# the lag function! 

# Random Forest Prediction ---------------------------------------------------
forest.pred <- predict(forest.fit, newdata = test)
confusionMatrix(forest.pred, test$market_direction[2:nrow(test)])

# Visualizing candlestick ------------------------------------------------------
rs <- list(visible = TRUE, x = 0.5, y = -0.055,
           xanchor = 'center', yref = 'paper',
           font = list(size = 9))

p <- plot_ly(data = train, x = ~Month_Year, type = 'candlestick', 
             open = ~Open, 
             close = ~Close, 
             high = ~High, 
             low = ~Low,
             color = ~coin) 
pp <- train %>%
  plot_ly(x = ~Month_Year, y = ~Volume, type='bar', name = "Volume",
          color = ~market_direction, colors = c('green','red')) %>%
  layout(yaxis = list(title = "Volume"))
p <- subplot(p, pp, heights = c(0.7,0.2), nrows=2,
             shareX = TRUE, titleY = TRUE) %>%
  layout(xaxis = list(rangeselector = rs),
         legend = list(orientation = 'h', x = 0.5, y = 1,
                       xanchor = 'center', yref = 'paper',
                       font = list(size = 10),
                       bgcolor = 'transparent'))

p

### END OF CODE ###-------------------------------------------------------------

