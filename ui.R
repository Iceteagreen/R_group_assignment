## Programming in R - Group Project

## This is the user-interface definition of a Shiny web application. You can
## run the application by clicking 'Run App' above.

## Yorick Schekermans u717419 , Jurgen van den Hoogen u919127,
## Decio Da Silveira Quiosa u283203, Bastiaan de Groot u642447,
## Jarno Vrolijk, Koen Hendriks u688250.

## Installing required packages ------------------------------------------------
library(shinydashboard)
library(timeSeries)
library(plotly)

## Dashboard UI ----------------------------------------------------------------
dashboardPage(
  dashboardHeader(
    title = "Cryptocurreny Dashboard",
    titleWidth = 350
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction",
               tabName = "crypto",
               icon = icon("file")),
      menuItem("Data Overview",
               tabName = "data_overview",
               icon = icon("database")),
      menuItem("Bitcoin Visualization",
               tabName = "bitcoin",
               icon = icon("signal")),
      menuItem("Ethereum Visualization",
               tabName = "ethereum",
               icon = icon("signal")),
      menuItem("Ripple Visualization",
               tabName = "ripple",
               icon = icon("signal")),
      menuItem("Bitcoin Cash Visualization",
               tabName = "bitcoin-cash",
               icon = icon("signal")),
      menuItem("Results",
               tabName = "Results",
               icon = icon("file")),
      menuItem("Conclusion",
               tabName = "Conclusion",
               icon = icon("file")),
      menuItem("References",
               tabName = "References",
               icon = icon("file"))
      
    )
  ),
  
dashboardBody(
  tabItems(
    tabItem(tabName = "crypto",
            h2("A brief introduction", align = 'center'),
            fluidRow(
              valueBox("1,640", "Different coins",
                      icon = icon("bitcoin"),
                      color = "orange"),
              valueBox("23,952,849", "Amount of wallets",
                      icon = icon("briefcase"),
                      color = "orange"),
              valueBox("334,436,919,408", "Total market value",
                      icon = icon("dollar"),
                      color = "orange")
            ),
            fluidRow(
              box(
                h3("Blockchain and crypto's"),
                "The Blockchain is defined as a growing list of records which 
                are all linked and secured throuh cryptography. This technology
                forms the basis of the well-known Bitcoin cryptocurrency. In the
                early days in the history of cryptocurrency bitcoin was the only
                coin. Nowadays the “cryptomarket” consists of 1640 different
                types of coins, each of them build upon the blockchain 
                framework (CryptoCurreny Facts, n.d.).", width = 12
              ),
              box(
                h3("Usage and coins"),
                "While there is no clear motivation for bitcoins the often heard
                benefits mentioned by the crypto community can be summarized as 
                decentralization of economic power, efficiency improvements, 
                reduction in transactions costs (no brokerage or banks needed). 
                Furthermore, firms are increasingly interested in the benefits 
                of blockchain technology (Harvard Law School Forum, 2018). 
                Currently, accounting firms and banks are experimenting with 
                blockchain applications such as smart 
                contracts, a contract embedded in computer code that executes an
                agreement. This contract makes use of the blockchain platform in
                order to automatically execute all points in the agreement
                (Nasdaq, 2017).", 
                width = 12
              ),
              box(
                h3("Alternative coins"),
                "In general, other coins (other than bitcoins) are referred to 
                as alternative coins (altcoins) by the crypto community. These 
                coins are often linked to variety of platforms or innovations 
                which can also drive prices up. While, blockchain technology and
                cryptocurrency is promising and increasingly regarded as one of 
                the most important innovation of our time. It is common 
                knowledge that people view cryptocurrency as a mean for 
                financial gain. Hence, individuals speculate on exchange rates 
                (CryptoCurreny Facts, n.d.)."
                , width = 12
              ),
              box(
                h3("The aim of this report"),
                "Although investing in cryptocurrency will always contain
                elements of speculation, by utilizing historical data it might
                be possible to make better argumented, data-driven, decisions.
                This report is, therefore, aimed at trying out different 
                classification methods on a dataset containing historic market 
                data, in order to try to predict future price levels. This
                results in the following research question:",
                br(),
                br(),
                "RQ1: Is it possible to predict future price-levels for crypto 
                currencies based on historical data?",
                br(),
                br(),
                "RQ2: Do different classification methods yield different
                prediction accuracies when predicting crypto prices based on 
                historic data",
                width = 12 
              )
            )
          ),
    tabItem(tabName = "data_overview",
            h2("Overview of the data", align = 'center'),
            fluidRow(
            box(h3("Origin of the data"),
              "Retrieved from Kaggle, the original cryptocurrency dataset
              “CryptocoinsHistoricalPrices.csv” is a collection of daily 
              historical prices for more than 1000 coins which existed between 
              2013-04-28 and 2018-05-20. It consists of 760,103 observations of
              9 variables compiled from the historical pages of CoinMarketCap by
              using an R script (Vaccaro, 2018). CoinMarketCap is a website 
              collecting all data available from cryptocurrency exchanges. 
              By aggregating these data, they are able to provide information 
              regarding price, change in price, market capitalization, 
              total supply of the coin, and the 24 hour trading volume of the 
              coin (CoinMarketCap, 2018).", width = 12),
            box(h3("Explanation of the variables"),
                "Date - the day of recored values",
                br(),
                "Open - the opening price (in USD)",
                br(),
                "High - the highest price (in USD)",
                br(),
                "Low - the lowest price (in USD)",
                br(),
                "Close - the closing price (in USD)",
                br(),
                "Volume - total exchanged volume (in USD)",
                br(),
                "Market.Cap - the total market captipalization for the coin 
                (in USD)",
                br(),
                "coin - the name of the coin",
                br(),
                "Delta - calculated as (Close - Open) / Open",
                width = 12),
            box(h3("Pre-processing"),
                "Prior to visualizing and modelling the data some cleaning and 
                sub setting was required. First of all,  due to the size of the 
                dataset and its influence on the performance of the Shiny 
                Dashboard, the decision was made to create a subset of four 
                coins with the highest market capitalization. This was done with
                the use of the subset() function. Secondly, some cleaning was 
                required because the Volume and Market.Cap variable were strings
                instead of numeric values. By using a combination of the 
                as.numeric() and gsub() function, we were able to remove the ","
                and converting the remaining strings in numeric values. Finaly, 
                in dealing with missing values (NAs) in the data set, it was 
                determined to take the mean values of the particular columns.", 
                width = 12),
            box(h3("Time-series of market prices"),
                br(),
                img(src="https://image.ibb.co/kot6C8/timeseries.png", height='400', width='600'),
                br(),
                "The time series analysis indicated that the price-levels for 
                crypto currencies are extremely volatile.",
                width = 12),
            box(h3("Elaboration on the packages used during the project"),
              "During the research project, several packages were used. 
              This section provides information about additional packages that 
              are used during this project. Next to that, some base packages 
              are included e.g. Dplyr, GGplot and tidyr. Every additional 
              package is described separately.", 
              br(),
              h4("Shiny Dashboard"),
              "Shiny dashboard is an application that elaborates on the regular 
              shiny package. This package is used in this project to create a 
              dashboard that is interactive for visualizing the total project 
              and can be consulted through a web browser (CRAN R project, 17).",
              br(),
              h4("Caret"),
              "This package is widely used for creating predictive models. The 
              features that are used in this project are the K-nearest neighbor 
              function to predict if future price-levels will go up or down for 
              the four biggest crypto currencies (Kuhn, 2018).", 
              br(),
              h4("Plotly"),
              "This package is an alternative of GGplot for visualizing the 
              data. Plotly is directly interactive and can be implemented easily
              in a shiny dashboard (Plotly, 2017).",
              br(),
              h4("TimeSeries"), 
              "To get a general idea of the development of crypto currencies, 
              TimeSeries was used to visualize the price-levels over time. This 
              information was the foundation for our research project 
              (Wuertz et al., 2017). ", width = 12
              )
            )
          ),
    tabItem(tabName = "bitcoin",
            h2("Bitcoin visualization", align = 'center'),
            box(width = 12,
              plotlyOutput("plot_btc")
            )
    ),
    tabItem(tabName = "ethereum",
            h2("Ethereum visualization", align = 'center'),
            box(width = 12,
                plotlyOutput("plot_eth")
            )
    ),
    tabItem(tabName = "ripple",
            h2("Ripple visualization", align = 'center'),
            box(width = 12,
                plotlyOutput("plot_xrp")
            )
    ),
    tabItem(tabName = "bitcoin-cash",
            h2("Bitcoin Cash visualization", align = 'center'),
            box(width = 12,
                plotlyOutput("plot_bch")
            )
    ),
    tabItem(tabName = "Results",
            h2("Results", align = 'center'),
            box("The time series analysis indicated that the price-levels for 
                crypto currencies are extremely volatile. For this reason, it 
                would be not achievable to make valid prediction for actual 
                price-levels in the future. Instead, we focused on predicting 
                if a particular coin would increase or decrease on a given time 
                in the future. For this analysis, we added a variable that 
                derives from the deviation of a coin between two consecutive 
                days. This variable uses the deviation between a coin from the 
                day before the prediction. A negative value indicates that the 
                price of a coin decreased in comparison with the day before, a 
                positive value means that the price went up. Based on this 
                information, we designed two predictive models. The first model 
                uses the K-nearest Neighbor (KNN) classification method to make 
                a prediction for future increase or decrease in price-levels. 
                This model uses cross validation to make the samples from the 
                total dataset less biased. The next model uses the Random Forest 
                method to make a prediction. This model also uses cross validation 
                to improve the sampling method. By splitting the data in a train 
                and test set, we were able to validate the predictive accuracy 
                of the models.", width = 12),
            box(h3("KNN predictive model of market"),
                "This model combines all the data of the four biggest coins on 
                which this research is based. The model reports that it can 
                predict with an 0.4873 accuracy if price-levels increase or 
                decline. This means that an investor would have a 48.73% chance 
                to make a good informed decision based on this model. ", 
                width = 12),
            box(h3("Random Forest predictive model of market"),
                "This model uses a different predictive functionality than the 
                KNN model. Therefore, the accuracy may vary from the other model 
                even though both models use the same data and variables. The 
                Random Forest model is able to predict if price-levels increase 
                or decline with an accuracy of 0.4761. This means that the model 
                predicts 47,61% of the change in price-levels accurately.", 
                width = 12)
            ),
    tabItem(tabName = "Conclusion",
            h2("Conclusion", align = 'center'),
            box("Recent developments in the market of crypto currency sparked 
            the need for thorough analyses. Making good predictions based on 
            historical data could help investors decide whether to invest or not.
            The purpose of this research was to create a statistical model that 
            would give an accurate prediction on the four biggest crypto 
            currencies. This model could assist in designing strategical 
            investment plans that improve the return on investment. In this 
            research, we analyzed historical data of four different crypto 
            currencies which were made available from CoinMarketCap. The time 
            series analysis showed that the price-levels over time are extremely 
            volatile. This gave the indication that a prediction of the actual 
            price for a coin on a given time in the future would not be accurate. 
            Therefore, we focused on predicting positive or negative change in 
            the price-levels. The first model, which uses the KNN method, 
            resulted in an accuracy of 0.4873. The second model, which uses the 
            Random Forest method, acquired an accuracy of 0.4761. The results 
            suggest that the KNN model fits the data better than the Random 
            Forest model. However, both models predict under the 50% threshold 
            which indicates that an investor has a better chance of making a 
            successful investment decision when flipping a coin. From these 
            results we can conclude that we are not able to accurately predict 
            future changes in price-levels. Next to that, the two different 
            models do vary in accuracy. However, this variation does not clearly 
            suggest that one of the two models is significantly better in 
            predicting future price-levels. Additionally, humans behave irrational 
            on currency markets which makes it difficult to predict future 
            price-levels solely based on historical data. If it was possible to 
            make extremely accurate predictions of price-levels based on this 
            dataset, it would change the whole dynamic of these types of markets.",
            width = 12)
            ),
    tabItem(tabName = "References",
            h2("References", align = 'center'),
            box("CoinMarketCap. (2018). Cryptocurrency Market Capitalizations | 
                CoinMarketCap. Retrieved from Cryptocurrency Market 
                Capitalizations | CoinMarketCap: https://coinmarketcap.com/",
                br(),
                br(),
                "CRAN R project. (17, May 2018). Package Shiny. Retrieved from 
                cran.r-project: https://cran.r-project.org/web/packages/shiny/
                shiny.pdf",
                br(),
                br(),
                "CryptoCurreny Facts. (n.d.). Cryptocurrency Basics Archives - 
                CryptoCurrency Facts. Retrieved from Introduction to 
                Cryptocurrency - CryptoCurrency Facts: https://cryptocurrency
                facts.com/section/cryptocurrency-basics/",
                br(),
                br(),
                "Harvard Law School Forum. (2018). An Introduction to Smart 
                Contracts and Their Potential and Inherent Limitations. 
                Retrieved from The Harvard Law School Forum on Corporate 
                Governance and Financial Regulation | The leading online blog in
                the fields of corporate governance and financial regulation.: 
                https://corpgov.law.harvard.edu/2018/05/26/an-introduction-to-
                smart-contracts-and-their-potential-and-inherent-limitations/",
                br(),
                br(),
                "Kuhn, M. (2018, May 26). The caret Package. Retrieved from 
                Github.io: http://topepo.github.io/caret/index.html",
                br(),
                br(),
                "Nasdaq. (2017). 'Big 4' Accounting Firms Are Experimenting 
                With Blockchain And Bitcoin - Nasdaq.com. Retrieved from Daily 
                Stock Market Overview, Data Updates, Reports & News - Nasdaq: 
                https://www.nasdaq.com/article/big-4-accounting-firms-are-
                experimenting-with-blockchain-and-bitcoin-cm812018",
                br(),
                br(),
                "Plotly. (2017). plot.ly. Retrieved from plot.ly: https://plot.
                ly",
                br(),
                br(),
                "Vaccaro, V. (2018). Cryptocoins Historical Prices | Kaggle. 
                Retrieved from Kaggle: Your Home for Data Science: https://www.
                kaggle.com/valeriovaccaro/cryptocoinshistoricalprices",
                br(),
                br(),
                "Wuertz, S. C. (2017, November 17). Package timeSeries. 
                Retrieved from cran.r-project: https://cran.r-project.org/web/
                packages/timeSeries/timeSeries.pdf",
                width = 12)
            
    )
    )
  )
)

