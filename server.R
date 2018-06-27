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
  
  # Plot 1
  #output$plot1<-renderPlot({
  #ts})
  
  
  p <- plot_ly(data = train, x = ~Month_Year, type = 'candlestick', 
               open = ~Open, 
               close = ~Close, 
               high = ~High, 
               low = ~Low,
               color = ~coin) 
  
  # Plot 2
  output$plot2<-renderPlotly({p})
}

### END OF CODE ################################################################
