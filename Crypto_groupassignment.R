crypto_pricelist <- read.csv("input/crypto_pricelist.csv", stringsAsFactors = FALSE)

crypto_prices <- read.csv("input/crypto_prices.csv", stringsAsFactors = FALSE)

head(crypto_btc)## based on BTC
head(crypto_pricelist) ## List
head(crypto_prices) ## based on dollars

tail(crypto_btc)
tail(crypto_prices)

crypto_prices$percentage_change <- crypto_prices$Delta * 100
crypto_prices$X <- NULL

btc <- crypto_prices[crypto_prices$coin %in%
                          c("BTC"), ]

eth <- crypto_prices[crypto_prices$coin %in%
                       c("ETH"), ]
xrp <- crypto_prices[crypto_prices$coin %in%
                       c("XRP"), ]
bch <- crypto_prices[crypto_prices$coin %in%
                       c("BCH"), ]
eos <- crypto_prices[crypto_prices$coin %in%
                       c("EOS"), ]
ltc <- crypto_prices[crypto_prices$coin %in%
                       c("LTC"), ]
ada <- crypto_prices[crypto_prices$coin %in%
                       c("ADA"), ]
xlm <- crypto_prices[crypto_prices$coin %in%
                       c("XLM"), ]
miota <- crypto_prices[crypto_prices$coin %in%
                       c("MIOTA"), ]
trx <- crypto_prices[crypto_prices$coin %in%
                       c("TRX"), ]
neo <- crypto_prices[crypto_prices$coin %in%
                       c("NEO"), ]
dash <- crypto_prices[crypto_prices$coin %in%
                       c("DASH"), ]
xmr <- crypto_prices[crypto_prices$coin %in%
                       c("XMR"), ]
xem <- crypto_prices[crypto_prices$coin %in%
                       c("XEM"), ]


## Calculating the mean for market cap
btc$Market.Cap <- gsub(",", "", btc$Market.Cap)
class(btc$Market.Cap)
btc$marketcap <- as.numeric(btc$Market.Cap) 

mean(btc$marketcap)


## Linear model Volume versus Open 
btc$Volume <- gsub(",", "", btc$Volume)

class(btc$Volume)
btc$Volume <- as.numeric(btc$Volume) 

btc$volumec <- btc$Volume - 1000000

btc1 <- lm( Open ~ Volume, data = btc)
plot( btc1, which = 3 )

plot( btc1, which = 2)

summary( btc1 )
standardCoefs( btc1 )
mean(btc$Open)

