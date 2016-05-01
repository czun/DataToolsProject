library(shiny)
require(shiny)
library(ggplot2)
library(dplyr)


#Load and Prepare Dataset
load(url("http://bit.ly/dasi_gss_data"))
gss <- subset(gss, year >= 2000 & year <=2012)
gss <- select(gss, year, sex, race, polviews, region, degree, getahead)
gss <- subset(gss, !is.na(sex) & !is.na(race) & !is.na(polviews)& 
                !is.na(getahead) & !is.na(region) & !is.na(degree) & !is.na(year))
gss <- droplevels(gss)

#Function
shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("Opinions of Getting Ahead by", input$variable)
  })
  
  #Create Plot
  
  output$getaheadPlot <- renderPlot({
      getaheadData <- data.frame(getahead = gss$getahead, Variable = factor(gss[[input$variable]]))

        
    p <- ggplot(getaheadData, aes(getahead, fill = Variable)) + 
      geom_bar(position = "fill") + 
      xlab("How people get ahead") +
      ylab("Percent of Respondents")
    print(p)
    
  })
  
  #Generate Prop Table
  output$getaheadtable <- renderTable({
    getaheadData <- data.frame(getahead = gss$getahead, Variable = factor(gss[[input$variable]]))
    t <- prop.table(table(getaheadData$Variable, getaheadData$getahead), 2)
    print(t)
  })
  
  output$getaheadtable2 <- renderTable({
    getaheadData <- data.frame(getahead = gss$getahead, Variable = factor(gss[[input$variable]]))
    t2 <- prop.table(table(getaheadData$Variable, getaheadData$getahead), 1)
    print(t2)
  })
  
  #Generate Year Plot
  output$yearPlot <- renderPlot({
         getaheadData <- data.frame(getahead = gss$getahead, year = factor(gss$year), Variable = factor(gss[[input$variable]]))
         g <- ggplot(getaheadData, aes(year, getahead)) + 
           geom_jitter(aes(color = year)) + 
           facet_wrap(~ Variable) +
           xlab("Year") +
           ylab("How People Get Ahead") +
           scale_x_discrete(breaks = c("2000", "2006", "2012"))
         print (g)
      
})
})

  