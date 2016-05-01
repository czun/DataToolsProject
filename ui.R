library(shiny)
library(ggplot2)
library(dplyr)

shinyUI(fluidPage(

  titlePanel("How people get ahead"),
  
  sidebarLayout(
      sidebarPanel(
          helpText("See how certain factors influence opinions 
                    on how people get ahead with
                    data from the General Social Survey (GSS)."),
    
          selectInput("variable",
                          label = h3("Choose a variable:"), 
                            choices = list("Race" = "race", 
                              "Sex" = "sex", 
                              "PoliticalView" = "polviews",
                              "Region" = "region",
                              "EducationLevel" = "degree"),
                      selected = "sex"
                   )),
    
    mainPanel(
      h5("What makes people get ahead in life? Is it hard work? Pure luck or help from another person?
          Or an equal amount of both? See how views on this subject vary depending on
          one's race, sex, region, political views and level of education", align = "center",
         style = "font-family: 'helvetica'; font-si16pt"),
    
    h3(textOutput("caption")),
    
    tabsetPanel(type = "tabs", 
          tabPanel("BarPlot",plotOutput("getaheadPlot")),   
          
          tabPanel("Table", 
                  br(),
                  h4("Table1"), 
                  tableOutput("getaheadtable"), 
                          p("Comparing respondents with different opinions on 
                            how people get ahead (Column percents)."),
                  br(),
                  h4("Table 2"),
                  tableOutput("getaheadtable2"), 
                          p("Comparing respondents of your selected variable
                          (Row Percents)")),
          
          tabPanel("Year", 
                   h4("Year Plot"),
                   plotOutput("yearPlot"),
                          br(),
                          p("Comparing opinions on how people get ahead 
                            between 2000-2012, by chosen variable"))
                        
              )
  )
  ))
)