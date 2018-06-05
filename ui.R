#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#
#install.packages("shinydashboard")
#library(shinydashboard)

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
               icon = icon("google"))
      
    )
  ),
  
dashboardBody(
  tabItems(
    tabItem(tabName = "crypto",
            h2("A brief introduction"),
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
                "Blockchain and crypto's",
                br(),
                "The Blockchain is defined as a growing list of records which are all linked and secured throuh cryptography. This technology forms the basis of the well-known Bitcoin cryptocurrency. In the early days in the history of cryptocurrency bitcoin was the only coin. Nowadays the “cryptomarket” consists of 1640 different types of coins, each of them build upon the blockchain framework. "
              ),
              box(
                "Usage and coins",
                br(),
                "While there is no clear motivation for bitcoins the often heard benefits mentioned by the crypto community can be summarized as decentralization of economic power, efficiency improvements, reduction in transactions costs (no brokerage or banks needed). Furthermore, firms are increasingly interested in the benefits of blockchain technology. 
Currently, accounting firms and banks are experimenting with blockchain applications such as smart contracts, a contract embedded in computer code that executes an agreement. This contract makes use of the blockchain platform in order to automatically execute all points in the agreement.
                "
              ),
              box(
                "Blockchain and crypto's",
                br(),
                "In general, other coins (other than bitcoins) are referred to as alternative coins (altcoins) by the crypto community. These coins are often linked to variety of platforms or innovations which can also drive prices up. While, blockchain technology and cryptocurrency is promising and increasingly regarded as one of the most important innovation of our time. It is common knowledge that people view cryptocurrency as a mean for financial gain. Hence, individuals speculate on exchange rates. "
              )
              
              
            )
              

    ),
    tabItem(tabName = "origin",
            h2("The origin of the data"),
            
            box(
              "Box 1 content"
            )
            ),
    
    tabItem(tabName = "question",
            h2("The research questions"),
            
            box(
              "Box 1 content"
            )
            ),
    tabItem(tabName = "package",
            h2("Elaboration on used packages"),
            
            box(
              "Box 1 content"
            )
            ),
    tabItem(tabName = "data_overview",
            h2("Overview of the data")
            ),
    tabItem(tabName = "visualizations",
            h2("Data visualizations")
            )
  )
  
),
)

