## Loading packages ------------------------------------------------------------
library(dplyr)
library(TTR)
library(timeSeries)
library(ggplot2)
library(psych)
library(tidyr)

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
plot.ts(btc_time) # This is used in dashboard

## plot on time
log_btc_time <- log(btc_time)
plot.ts(log_btc_time)



