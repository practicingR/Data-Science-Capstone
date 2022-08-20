library(shiny)
library(markdown)
library(RColorBrewer)

# Define UI for application that predicts next word based on user input
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Word Prediction"),
  
  # sidebar
  sidebarLayout(
    sidebarPanel(
      textInput("inputString", "Enter some words here to get a predicted next word", value = "")
    ),
    mainPanel(
      h2("Predicted Next Word"),
      verbatimTextOutput("prediction"),
      br()
    )
  )
)
)
