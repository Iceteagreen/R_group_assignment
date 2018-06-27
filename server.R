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
library(ggplot2)
library(dplyr)
library(caret)
library(TTR)


# Visualizing candlestick ------------------------------------------------------
train <- read.csv("plotdata/train.csv", header = T, stringsAsFactors = F)

btc <- train %>%
  filter(coin == "BTC")

eth <- train %>%
  filter(coin == "ETH")

xrp <- train %>%
  filter(coin == "XRP")

bch <- train %>%
  filter(coin == "BCH")



## Dashboard Set Up ------------------------------------------------------------
server <- function(input, output) {
  
  # BTC Plot
  btc_plot <- plot_ly(data = btc, x = ~Month_Year, type = 'candlestick', 
                      open = ~Open, 
                      close = ~Close, 
                      high = ~High, 
                      low = ~Low,
                      color = ~coin)
  
  # BTC Plot
  eth_plot <- plot_ly(data = eth, x = ~Month_Year, type = 'candlestick', 
                      open = ~Open, 
                      close = ~Close, 
                      high = ~High, 
                      low = ~Low,
                      color = ~coin)
  
  # BTC Plot
  xrp_plot <- plot_ly(data = xrp, x = ~Month_Year, type = 'candlestick', 
                      open = ~Open, 
                      close = ~Close, 
                      high = ~High, 
                      low = ~Low,
                      color = ~coin)
  
  # BTC Plot
  bch_plot <- plot_ly(data = bch, x = ~Month_Year, type = 'candlestick', 
                      open = ~Open, 
                      close = ~Close, 
                      high = ~High, 
                      low = ~Low,
                      color = ~coin)
  
  # Plot outputs
  output$plot_btc<-renderPlotly({btc_plot})
  output$plot_eth<-renderPlotly({eth_plot})
  output$plot_xrp<-renderPlotly({xrp_plot})
  output$plot_bch<-renderPlotly({bch_plot})
}

### END OF CODE ################################################################
