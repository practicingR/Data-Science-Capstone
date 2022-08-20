library(shiny)
library(stringr)
library(tm)

# Loading in files

unigram <- readRDS("unigram.RData");
bigram <- readRDS("bigram.RData");
trigram <- readRDS("trigram.RData");
quadgram <- readRDS("quadgram.RData");


# Prediction function

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
    
    else {
      head(quadgram[quadgram$unigram == x.string[1] & 
                      quadgram$bigram == x.string[2] & 
                      quadgram$trigram == x.string[3], 4],1)}
    
  }
  
  if (length(x.string) >= 2){
    x.string <- tail(x.string,2)
    if (identical(character(0),
                  head(trigram[trigram$unigram == x.string[1] & 
                               trigram$bigram == x.string[2], 3],1))){
      
      predict(x.string[2])
      
    }
    
    else { 
      head(trigram[trigram$unigram == x.string[1] &
                     trigram$bigram == x.string[2], 3],1)}
    
  }
  
  else if (length(x.string) == 1){
    x.string <- tail(x.string,1)
    if (identical(character(0),
                  head(bigram[bigram$unigram == x.string[1], 2],1)))
    {
      head(unigram[sample(nrow(unigram),1),1])}
    else { 
      head(bigram[bigram$unigram == x.string[1],2],1)}
  }
}

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
