### Group Assignment Epsilon ---------------------------------------------------
## Cleaning memory -------------------------------------------------------------
#rm(list = ls())

## Install libraries -----------------------------------------------------------
#install.packages("psych")             # For the Explanetory Descriptive Analysis (EDA)
#install.packages("e1071")             # For the SVM - The prediction
#install.packages("timeSeries")        # Time Serie Analysis
#install.packages("shiny")             # For the dashboard
#install.packages("shinydashboard")    # For the dashboard

## Loading libraries -----------------------------------------------------------
library(psych)             # For the Explanetory Descriptive Analysis (EDA)
library(e1071)             # For the SVM - The prediction
library(timeSeries)        # Time Serie Analysis
library(shiny)             # For the dashboard
library(shinydashboard)    # For the dashboard
library(ggplot2)           # Plot

## Loading datasets ------------------------------------------------------------
crypto_pricelist <- read.csv("input/crypto_pricelist.csv", 
                             stringsAsFactors = FALSE)

df <- read.csv("input/crypto_prices.csv", 
               stringsAsFactors = FALSE)

## Cleaning the data -----------------------------------------------------------
## Cleaning variables --------------------------------------------------------
df$Volume <- as.numeric(gsub(",", "", df$Volume))
df$Volume <- df$Volume / 1000

df$Market.Cap <- as.numeric(gsub(",", "", df$Market.Cap))
df$Market.Cap <- df$Market.Cap / 1000

df$Date <- as.Date(df$Date, "%Y-%m-%d")

## Clearing NA ---------------------------------------------------------------
index <- which(is.na(df$Date))        # Selecting NA
df <- df[-index,]                     # Removing the NA values from data

## Creating BTC subset ---------------------------------------------------------
#BTC <- subset(df, coin == "BTC")
#ETH <- subset(df, coin == "ETH")
#XRP <- subset(df, coin == "XRP")
#BCH <- subset(df, coin == "BCH")

## EDA -------------------------------------------------------------------------
#describe(X_BTC)

## Support Vector Machine ------------------------------------------------------
#model <- tune(svm, Y ~ X ,                     # Grid search results
#              data = X_BTC,                    # Loading dataset
#              ranges = list(epsilon = seq(0,0.2,0.01),
#                            cost = 2^(2:9)))            # Defining the cost function

#best_model <- model$best.model
#Y <- predict(best_model, X_BTC)
#error <- df$Y - Y
#RMSE <- rmse(error)

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
