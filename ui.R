library(shiny)

source('global.R', local=TRUE)

fluidPage(
  navbarPage("Fall 2016 CMU Men's Soccer", inverse = TRUE,
    navbarMenu("Individual Player Report",
      tabPanel("Univariate Analysis",
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = "playerName", label = "Player Name:",
                               choices = unique(survey.sorted$Name)),
                   radioButtons(inputId = "individualVariable", label = "Variable:",
                                choices = survey.sorted.variables)
                   ),
                 mainPanel(plotOutput("individualPlot"))
                 )
               ),
      tabPanel("Bivariate Analysis",
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = "indPlayerName", label = "Player Name:",
                               choices = unique(survey.sorted$Name)),                 
                   selectInput(inputId = "indXVar", label = "X Variable",
                               choices = survey.sorted.variables),
                   selectInput(inputId = "indYVar", label = "Y Variable",
                               choices = survey.sorted.variables)
                   ),
                 mainPanel(plotOutput("individualBivariatePlot"))
                 )             
               )
    ),
    
    navbarMenu("Team Report", 
      tabPanel("Univariate Analysis",
               sidebarLayout(
                 sidebarPanel(
                   radioButtons(inputId = "teamVariable", label = "Variable:",
                                choices = daily.averages.variables),
                   checkboxInput(inputId = "showSchedule", label = "Show Games?",
                                 value = FALSE)
                   ),
                 mainPanel(plotOutput("teamPlot"))
                 )
               ),
      tabPanel("Bivariate Analysis",
               sidebarLayout(
                 sidebarPanel(
                   selectInput(inputId = "teamXVar", label = "X Variable",
                               choices = daily.averages.variables),
                   selectInput(inputId = "teamYVar", label = "Y Variable",
                               choices = daily.averages.variables)
                   ),
                 mainPanel(plotOutput("teamBivariatePlot"))
                 )
               )
    )
  )
)
