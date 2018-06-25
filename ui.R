#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#install.packages("shinydashboard")
library(shinydashboard)
#install.packages("timeSeries")
library(timeSeries)

dashboardPage(
  dashboardHeader(
    title = "Cryptocurreny Dashboard",
    titleWidth = 350
  ),
  
  dashboardSidebar(
    sidebarMenu(
      menuItem("Introduction to cryptocurrency",
               tabName = "crypto",
               icon = icon("google")),
      menuItem("The origin of the Data",
               tabName = "origin",
               icon = icon("google")),
      menuItem("Research Questions",
               tabName = "question",
               icon = icon("google")),
      menuItem("R packages",
               tabName = "package",
               icon = icon("google")),
      menuItem("Data Overview",
               tabName = "data_overview",
               icon = icon("google")),
      menuItem("Visualizations",
               tabName = "visualizations",
               icon = icon("google")),
      menuItem("Results",
               tabName = "Results",
               icon = icon("google")),
      menuItem("Conclusion",
               tabName = "Conclusion",
               icon = icon("google")),
      menuItem("References",
               tabName = "References",
               icon = icon("google"))
      
    )
  ),
  
dashboardBody(
  tabItems(
    tabItem(tabName = "crypto",
            h2("A brief introduction", align = 'center'),
            fluidRow(
              valueBox(1640, "Different coins",
                      icon = icon("bitcoin"),
                      color = "orange"),
              valueBox(23952849, "Amount of wallets",
                      icon = icon("briefcase"),
                      color = "orange"),
              valueBox(334436919408, "Total market value",
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
                of blockchain technology (Harvard Law School Forum, 2018). Currently, accounting firms and banks 
                are experimenting with blockchain applications such as smart 
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
              )
              
              
            )
              

    ),
    tabItem(tabName = "origin",
            h2("The origin of the data", align = 'center'),
            
            box(
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
              coin (CoinMarketCap, 2018).", width = 12
            )
            ),
    
    tabItem(tabName = "question",
            h2("The research questions", align = 'center'),
            
            box(h3("Research question 1", align = "left"),
              "Is it possible to predict future price-levels for crypto 
              currencies based on historical data?",
              br(),
              h3("Research question 2", align = "left"),
              "Does the accuracy of the predicted prices-level deviate between
              crypto currencies?", width = 12)
            ),
    tabItem(tabName = "package",
            h2("Elaboration on used packages", align = 'center'),
            box(
              "During the research project, several packages were used. 
              This section provides information about additional packages that 
              are used during this project. Next to that, some base packages 
              are included e.g. Dplyr, GGplot and tidyr. Every additional 
              package is described separately.", 
              br(),
              h3("Shiny Dashboard"),
              "Shiny dashboard is an application that elaborates on the regular 
              shiny package. This package is used in this project to create a 
              dashboard that is interactive for visualizing the total project 
              and can be consulted through a web browser (CRAN R project, 17).",
              br(),
              h3("Caret"),
              "This package is widely used for creating predictive models. The 
              features that are used in this project are the K-nearest neighbor 
              function to predict if future price-levels will go up or down for 
              the four biggest crypto currencies (Kuhn, 2018).", 
              br(),
              h3("Plotly"),
              "This package is an alternative of GGplot for visualizing the 
              data. Plotly is directly interactive and can be implemented easily
              in a shiny dashboard (Plotly, 2017).",
              br(),
              h3("TimeSeries"), 
              "To get a general idea of the development of crypto currencies, 
              TimeSeries was used to visualize the price-levels over time. This 
              information was the foundation for our research project 
              (Wuertz et al., 2017). ", width = 12
            )
            ),
    tabItem(tabName = "data_overview",
            h2("Overview of the data", align = 'center'),
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
                width = 12)
            ),
    tabItem(tabName = "visualizations",
            h2("Data visualizations", align = 'center'),
            box(width = 3,
              helpText("Show cryptocurrency value
                       for selected period."),
              selectInput("coin", 
                          label = "Choose a currency to display",
                          choices = list("Bitcoin" = "BTC",
                                         "Ethereum" = "ETH",
                                         "Ripple" = "XRP", 
                                         "Bitcoin Cash" = "BCH"),
                          selected = "BTC"),
              sliderInput("range", 
                          label = "Range of interest:",
                          min = 2010, max = 2018, value = c(2010, 2018))
              ),
            box(width = 9,
              textOutput("selected_coin"),
              textOutput("min_max"),
              plotOutput("plot1")
            )
            ),
    tabItem(tabName = "Results",
            h2("Results", align = 'center'),
            box("Insert results here", width = 12)
            ),
    tabItem(tabName = "Conclusion",
            h2("Conclusion", align = 'center'),
            box("Insert conclusion here", width = 12)
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

