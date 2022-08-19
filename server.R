library(shiny)
library(stringr)
library(tm)

# Import the files

unigram <- readRDS("C:/Users/VickyCastro/OneDrive - Zoomph/Documents/R/R Course/Course 10/Course 10/unigram.RData");
bigram <- readRDS("C:/Users/VickyCastro/OneDrive - Zoomph/Documents/R/R Course/Course 10/Course 10/bigram.RData");
trigram <- readRDS("C:/Users/VickyCastro/OneDrive - Zoomph/Documents/R/R Course/Course 10/Course 10/trigram.RData");
quadgram <- readRDS("C:/Users/VickyCastro/OneDrive - Zoomph/Documents/R/R Course/Course 10/Course 10/quadgram.RData");
msg <<- ""

# Cleaning of user input before predicting the next word

predict <- function(x.word) {
  x.clean <- removeNumbers(removePunctuation(tolower(x.word)))
  x.string <- strsplit(x.clean, " ")[[1]]
  
  if (length(x.string) >= 3) {
    x.string <- tail(x.string,3)
    if (identical(character(0),
                  head(quadgram[quadgram$unigram == x.string[1] & 
                                quadgram$bigram == x.string[2] & 
                                quadgram$trigram == x.string[3], 4],1))){
      
      predict(paste(x.string[2], x.string[3], sep=" "))
      
    }
    
    else {msg <<- "Next word is predicted using 4-gram.";
    head(quadgram[quadgram$unigram == x.string[1] & 
                    quadgram$bigram == x.string[2] & 
                    quadgram$trigram == x.string[3], 4],1)}
    
  }
  
  else if (length(x.string) == 2){
    x.string <- tail(x.string,2)
    if (identical(character(0),
                  head(trigram[trigram$unigram == x.string[1] & 
                               trigram$bigram == x.string[2], 3],1))){
      
      predict(x.string[2])
      
    }
    
    else {msg <<- "Next word is predicted using 3-gram.";
    head(trigram[trigram$unigram == x.string[1] &
                   trigram$bigram == x.string[2], 3],1)}
    
  }
  
  else if (length(x.string) == 1){
    x.string <- tail(x.string,1)
    if (identical(character(0),
                  head(bigram[bigram$unigram == x.string[1], 2],1)))
    {
    head(unigram[sample(nrow(unigram),1),1])}
    else {msg <<- "Next word is predicted using 2-gram.";
    head(bigram[bigram$unigram == x.string[1],2],1)}
  }
}




# Define server logic required to draw a histogram
shinyServer(function(input, output) {
      output$prediction <- renderPrint({
        result <- predict(input$inputString)
        output$text2 <- renderText({msg})
        result
      });
      
      output$text1 <- renderText({
        input$inputString});

}
)

