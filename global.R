library(shiny)

# Read in Datasets 
survey.sorted = read.csv("Fall2016SurveySorted.csv")
daily.averages = read.csv("Fall2016DailyAverages.csv")
schedule = read.csv("Fall2016Schedule.csv")
exertion = read.csv("Fall2016Exertion.csv")

survey.sorted$Date = substr(survey.sorted$Timestamp, 1, 8)
survey.sorted$Date = as.Date(survey.sorted$Date, format='%m/%d/%Y')

daily.averages$Date = as.Date(daily.averages$Date, format='%m/%d/%Y')

exertion$Date = as.Date(exertion$Date, format='%m/%d/%Y')

schedule$Date = as.Date(schedule$Date, format='%m/%d/%Y')

daily.averages$Team.Average.Exertion = exertion$Team.Average.Exertion
daily.averages$Coaches.Exertion = exertion$Coaches.Rating

survey.sorted.variables = c("Hours Slept Last Night", 
                            "Sleep Quality",
                            "Academic Stress",
                            "Muscle Soreness",
                            "Exertion")

daily.averages.variables = c("Sleep Hours",
                             "Sleep Quality",
                             "Academic Stress",
                             "Soreness",
                             "Hydration",
                             "Coaches Exertion",
                             "Team Average Exertion")