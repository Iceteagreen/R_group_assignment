### Group Assignment Epsilon ---------------------------------------------------
## Cleaning memory -------------------------------------------------------------
  rm(list = ls())

## Loading libraries -----------------------------------------------------------
  library(psych)             # For the Explanetory Descriptive Analysis (EDA)
  library(e1071)             # For the SVM - The prediction
  library(timeSeries)        # Time Serie Analysis
  library(shiny)             # For the dashboard
  library(shinydashboard)    # For the dashboard

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
  
  ## Clearing NA ---------------------------------------------------------------
  index <- which(is.na(df$Date))        # Selecting NA
  df <- df[-index,]                     # Removing the NA values from data
  
## Creating BTC subset ---------------------------------------------------------
  X_BTC <- subset(df, coin == "BTC")
  
## EDA -------------------------------------------------------------------------
  describe(X_BTC)
  
## Support Vector Machine ------------------------------------------------------
  model <- tune(svm, Y ~ X ,                     # Grid search results
                data = X_BTC,                    # Loading dataset
                ranges = list(epsilon = seq(0,0.2,0.01),
                     cost = 2^(2:9)))            # Defining the cost function
  
  best_model <- model$best.model
  Y <- predict(best_model, X_BTC)
  error <- df$Y - Y
  RMSE <- rmse(error)

## Dashboard Set Up ------------------------------------------------------------
  

### END OF CODE ################################################################