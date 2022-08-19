library(shiny)
library(markdown)
library(RColorBrewer)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
    titlePanel("Word Prediction"),

    # Sidebar with ability for user to enter string of words
    sidebarLayout(
        sidebarPanel(
          helpText("Enter one to four words to predict next word"),
            textInput("inputString", "Enter words below", value= "")
        ),

        # Show the predicted word
        mainPanel(
            h2("Predicted Next Word"),
            verbatimTextOutput("prediction"),
            strong("Sentence Input:"),
            textOutput('text1'),
            br(),
            strong("Note:"),
            textOutput('text2')
        )
    )
))
