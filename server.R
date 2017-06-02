library(shiny)
library(ggplot2)

source('global.R', local=TRUE)


shinyServer(function(input, output) {
   
  output$individualPlot <- renderPlot({
    
    variable = gsub(" ", ".", input$individualVariable)
    player.df = subset(survey.sorted, Name == input$playerName)
    player.exertion.df = exertion[, c("Date", gsub(" ", ".", input$indPlayerName))]
    colnames(player.exertion.df) = c("Date", "Exertion")
    player.df = merge(player.df, player.exertion.df, by = "Date")
    player.df = data.frame(Date = player.df$Date,
                           var = player.df[[variable]])
    
    ggplot(player.df) + 
      geom_point(aes(x = Date, y = var)) +
      scale_x_date(date_labels = "%b %d", date_breaks = "1 week") +
      labs(y = input$individualVariable, 
           title = paste(input$individualVariable, "-", input$playerName)) 
    
  })
  
  
  output$teamPlot <- renderPlot({
    
    variable = gsub(" ", ".", input$teamVariable)
    team.df = data.frame(Date = daily.averages$Date,
                         var = daily.averages[[variable]])
    
    teamPlot <- ggplot() +
      geom_point(data = team.df, aes(x = Date, y = var)) +
      scale_x_date(date_labels = "%b %d", date_breaks = "1 week") +
      labs(y = input$teamVariable)
    
    if (input$showSchedule) {
      teamPlot <- teamPlot + 
        geom_vline(data = schedule, 
                   aes(xintercept = as.numeric(Date), col = Result)) +
        scale_colour_manual(values = c("L" = "red", "T" = "blue", "W" = "green"))
    }
    
    teamPlot
    
  })
  
  
  output$individualBivariatePlot <- renderPlot({
    
    xVar = gsub(" ", ".", input$indXVar)
    yVar = gsub(" ", ".", input$indYVar)    
    player.df = subset(survey.sorted, Name == input$indPlayerName)
    player.exertion.df = exertion[, c("Date", gsub(" ", ".", input$indPlayerName))]
    colnames(player.exertion.df) = c("Date", "Exertion")
    player.df = merge(player.df, player.exertion.df, by = "Date")
    player.df = data.frame(xVar = player.df[[xVar]],
                           yVar = player.df[[yVar]])  

    ggplot(player.df) +
      geom_jitter(aes(x = xVar, y = yVar)) +
      labs(x = input$indXVar, y = input$indYVar)
    
  })
  
  
  output$teamBivariatePlot <- renderPlot({
    
    xVar = gsub(" ", ".", input$teamXVar)
    yVar = gsub(" ", ".", input$teamYVar)
    team.df = data.frame(xVar = daily.averages[[xVar]],
                         yVar = daily.averages[[yVar]])
    
    ggplot(team.df) +
      geom_jitter(aes(x = xVar, y = yVar)) +
      labs(x = input$teamXVar, y = input$teamYVar)
    
  })
  
  
})
