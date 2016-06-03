library(shiny)

shinyUI(fluidPage( theme= "bootstrap.css",
   
  br(),                
  titlePanel(
        div(h1("Next Word Prediction Shiny App"),style="color:blue",align="center")
    ),
  br(),
  br(),
  br(),
  sidebarLayout(
    
    sidebarPanel(
      
      helpText("Please type in a few words in the space given below. ."),
      
      textInput("var", label = "Type here",   value= ""),
      actionButton("do",label="Submit"),
      h4 ("About the app"),
      h6 ("This app predicts the next word by using the natural 
          language processing methods."),
      h6(" When the user inputs the words, it compares them against a database, and checks what would be the next words possible and their corresponding probabilities. "),
      h6(" For this the database used is HC Coursera, the Twitter, blog and news sources."),
      div(h6 (" Created for : Coursera Data Specialisation Course, Capstone"), style="color:blue"),
      div(h6("Built by:Rujuta Joshi"),style="color:blue"),
      h6("June 2016")
      
      ),
    
    mainPanel(
      h4 (" The predicted next word is  "),
      div(h2(textOutput("text1")),style="color:blue"),
      h4("The level of confidence about the prediction is "),
      div(h4(textOutput ("Confidencelevel")),style="color:blue"),
      br(),
      
      h4("Processing time for the prediction is"),
      h4(textOutput("time"),style="color:blue"),
      br(),
      
      h4 (" Other predicted words are"),
      tableOutput("others")
      
      
    )
  )
))