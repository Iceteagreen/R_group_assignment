## Programming in R - Group Project

## This is the server definition of a Shiny web application. You can
## run the application by clicking 'Run App' above.

## Yorick Schekermans u717419 , Jurgen van den Hoogen u919127,
## Decio Da Silveira Quiosa u283203, Bastiaan de Groot u642447,
## Jarno Vrolijk, Koen Hendriks u688250.

## Cleaning memory -------------------------------------------------------------
rm(list = ls())

## Loading libraries -----------------------------------------------------------  
library(plotly)
library(dplyr)
library(caret)
library(TTR)
library(timeSeries)
library(ggplot2)
library(psych)
library(tidyr)

# Visualizing timeseries  ------------------------------------------------------
## Load the data ---------------------------------------------------------------
crypto_prices2 <- read.csv("input/crypto_prices.csv", stringsAsFactors = FALSE)

## Average price of the coins per day
crypto_prices2$Price <- (crypto_prices2$Open + crypto_prices2$Close) / 2

## Make an object only containing BTC because it acts as a benchmark for other
## crypto currencies
btc <- crypto_prices2[crypto_prices2$coin %in%
                        c("BTC"), ]

## New object with only relevant columns for the timeseries analysis
btc2 <- data.frame(select(btc, Price, Date))
btc2$Date <- gsub("-", "", btc2$Date)
btc2$Date <- as.numeric(btc2$Date)
btc2 <- arrange(btc2, Date)
btc2$Date <- NULL

## Building the timeseries for BTC
btc_time <- ts(btc2)
btc_time

## plots for timeseries BTC
ts <- plot.ts(btc_time)


# Visualizing candlestick ------------------------------------------------------
train <- read.csv("plotdata/train.csv", header = T, stringsAsFactors = F)

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
  # https://stackoverflow.com/questions/40872124/subfiltering-
  # dataset-in-shiny-reactive?rq=1
  
  # Plot 1
  #output$plot1<-renderPlot({
    #ggplot(df, aes(x = df$Date, y = df$Market.Cap)) + geom_point(colour = 'red')},
    #height = 400, width = 600) 
  
  # Plot 2
  output$plot1<-renderPlot({
  p},
  height = 400, width = 600) 
}

### END OF CODE ################################################################
