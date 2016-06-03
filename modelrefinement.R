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
  } else {
    input2 <- paste(splitInput, collapse = " ")
  }
  
  trigramPred <- tail(trigrams[ngram == input2]$nextword, 1)
  trigramothers <- tail(trigrams[ngram==input2],10)
  
  
  others <- data.table(trigramothers)
  
  if (length(trigramPred > 0)){
    print("Prediction with Good Confidence")
    Confidencelevel <- "Good"
    pred <- list(trigramPred,others,Confidencelevel)
    return(pred)
  } else {
    input2 <- tail(splitInput, 1)
    bigramPred <- tail(bigrams[ngram == input2]$nextword, 1)
    bigramothers <- tail(bigrams[ngram==input2]$nextword,10)
    others <- data.table(bigramothers)
    
    if (length(bigramPred) > 0){
      print("Prediction with moderate confidence")
      Confidencelevel <- "Moderate"
      pred <- list(bigramPred, others, Confidencelevel)
      return(pred)
    } else {
      unigramPred <- tail(tokens[ngram == input2]$nextword, 1)
      unigramothers <- tail(tokens[ngram==input2]$nextword,10)
      others <- data.table(unigramothers)
      if (length(unigramPred) > 0){
        print("Prediction with low confidence")
        Confidencelevel <- "low"
        pred <- list(unigramPred, others, Confidencelevel)
        return(pred)
      } else {
        tokenPred <- tail(tokens$ngram, 1)
        print("Token Prediction")
        Confidencelevel <- "very low"
        pred <- list(tokenPred, Confidencelevel)
        return(pred)
      }
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
      
      
      output$text1 <- renderText({answer[[1]]})
      output$Confidencelevel <- renderText({paste("The level of confidence about the prediction is ", answer[[3]])})
      output$others <- renderDataTable({answer[[2]]})
      
      time2 <- Sys.time()
      timetaken <- round(time2-time1)
      output$time <- renderText({paste("Time taken for processing is", timetaken)})
      
    })
  }
)


