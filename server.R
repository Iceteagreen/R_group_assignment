# Loading Packages -------------------------------------------------------------
library(plotly)
library(dplyr)
library(caret)

# Loading the dataset ----------------------------------------------------------
crypto_prices <- read.csv('input/crypto_prices.csv')
# Subsetting the top 4 coins ------------------------------------------------------------------
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

# Removing NA ------------------------------------------------------------------
prices[is.na(prices[,6]), 6] <- mean(prices[,6], na.rm = TRUE)
prices[is.na(prices[,7]), 7] <- mean(prices[,7], na.rm = TRUE)

# Moving average --------------------------------------------------------------- 
moving_average <- function(x, n){
  cx <- c(0,cumsum(ifelse(is.na(x), 0, x)))
  rsum <- (cx[(n+1):length(cx)] - cx[1:(length(cx) - n)]) / n
}

# Creating up / down method ----------------------------------------------------
prices$market_direction <- "None"
prices$market_direction <- as.factor(ifelse(prices$Delta < 0, "Down", "Up"))

# Train/ Test set --------------------------------------------------------------
prices %>%
  group_by(prices, c(Date, coin))

index <- nrow(prices) * 0.2

test <- prices[1:index,]
train <- prices[index:nrow(prices),]


# Training a model to predict new prices
trctrl <- trainControl(method = "repeatedcv", number = 10, repeats = 3)
model.fit <- train(market_direction ~ Open + Close + 
                     Volume + Market.Cap + coin + Delta, 
                   data = train, 
                   method = "knn",
                   trControl=trctrl,
                   preProcess = c("center", "scale"),
                   tuneLength = 10)


# Validation -------------------------------------------------------------------
results <- predict(model.fit, test)
confusionMatrix(results, test$market_direction)

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
          color = ~market_direction, colors = c('#17BECF','#7F7F7F')) %>%
  layout(yaxis = list(title = "Volume"))
p <- subplot(p, pp, heights = c(0.7,0.2), nrows=2,
             shareX = TRUE, titleY = TRUE) %>%
  layout(xaxis = list(rangeselector = rs),
         legend = list(orientation = 'h', x = 0.5, y = 1,
                       xanchor = 'center', yref = 'paper',
                       font = list(size = 10),
                       bgcolor = 'transparent'))

## Dashboard Set Up ------------------------------------------------------------
server <- function(input, output) {
  
  # Selected coin
  output$selected_coin <- renderText({ 
    paste("You have selected", input$coin)
  })
  
  # Selected period
  output$min_max <- renderText({ 
    paste("You have chosen a timeperiod that goes from",
          input$range[1], "to", input$range[2])
  })
  
  # Add reactive data information
  # https://stackoverflow.com/questions/40872124/subfiltering-dataset-in-shiny-reactive?rq=1
  
  #Plot 1
  output$plot1<-renderPlot({
    ggplot(df, aes(x = df$Date, y = df$Market.Cap)) + geom_point(colour = 'red')},
    height = 400, width = 600) 
}

### END OF CODE ################################################################
