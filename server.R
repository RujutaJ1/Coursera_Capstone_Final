
library(shiny)

library(shiny)
library(plyr)
library(data.table)


load("data/finalbigrams.RData")
load("data/finalTokens.RData")
load("data/finaltrigrams.RData") 
setkey(allTokens2, "count", "ngram")
setkey(bigrams, "count", "ngram")
setkey(trigrams, "count", "ngram")

predictSimple <- function(input, allTokens2, bigrams, trigrams){
  input <- tolower(input)
  splitInput <- unlist(strsplit(input, split = " "))
  # if (length(splitInput)>3)
  #{input2 <- paste(tail(splitInput,3),collapse = " ")}
  if (length(splitInput) > 2){
    input2 <- paste(tail(splitInput, 2), collapse = " ")
    
    
    trigramPred <- tail(trigrams[ngram == input2]$nextword, 1)
    trigramothers <- tail(trigrams[ngram==input2],5)
    others <- arrange(trigramothers,desc(count))
    others$count <- NULL
    others$ngram <- NULL
    
    
    
    
    
    if (length(trigramPred > 0)){
      print("Prediction with Good Confidence")
      Confidencelevel <- "Good"
      pred <- list(trigramPred,others,Confidencelevel)
      return(pred)
    }} 
  else {
    input2 <- tail(splitInput, 1)
    bigramPred <- tail(bigrams[ngram == input2]$nextword, 1)
    bigramothers <- tail(bigrams[ngram==input2],5)
    others <- arrange(bigramothers,desc(count))
    others$count <- NULL
    others$ngram <- NULL
    
    
    if (length(bigramPred) > 0){
      print("Prediction with moderate confidence")
      Confidencelevel <- "Moderate"
      pred <- list(bigramPred, others, Confidencelevel)
      return(pred)
    }
    else {
      unigramPred <- tail(allTokens2[ngram == input2]$nextword, 1)
      unigramothers <- tail(allTokens2[ngram==input2],5)
      others <- arrange(unigramothers,desc(count))
      others$count <- NULL
      
      
      if (length(unigramPred) > 0){
        print("Prediction with low confidence")
        Confidencelevel <- " very low"
        pred <- list(unigramPred, others, Confidencelevel)
        return(pred)
      } else { 
        others <- data.table(c(0,0))
        Confidencelevel <- " Zero "
        Tokenpred <- "No Prediction available, please try again."
        pred <- list(Tokenpred, others, Confidencelevel)
      return(pred)}
    }
  }
}








# server.R

shinyServer(
  function(input, output) {
    observeEvent(input$do,{
      
      
      
      text <- input$var
      time1<- Sys.time()
      answer <- predictSimple(text,allTokens2, bigrams,trigrams)
      
      
      output$text1 <- renderText({as.character(answer[[1]])})
      output$Confidencelevel <- renderText({ answer[[3]]})
      output$others <- renderTable({answer[[2]]})
      
      time2 <- Sys.time()
      timetaken <- round((time2-time1),2)
      output$time <- renderText({paste( timetaken,"seconds")})
      
    })
  }
)


