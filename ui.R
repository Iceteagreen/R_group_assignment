#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shinydashboard)

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
               tabName = "data_overviw",
               icon = icon("google")),
      menuItem("Visualizations",
               tabName = "visualizations",
               icon = icon("google"))
      
    )
  ),
  
dashboardBody(
  tabItems(
    tabItem(tabName = "crypto",
            h2("A brief introduction")
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

