# Coursera_Capstone_Final

# Capstone project of the Coursera Data Science Specialization in cooperation with swiftkey

These are the main files of my capstone project app. The app can be run at https://rujuta.shinyapps.io/shiny/, the ui.R and server.R files show the code for the shiny app. The other code files are for processing the data, and they are run in the following sequence. 


- Data is downloaded seperately, and unzipped. 
- makeNgrams is the program for taking the data, and making ngrams from that. 
- createNgrams is the main program, which sources the makeNgram program, and preprocesses the data.createNgrams creates the ngrams and saves the files for final use. 
- ngramForServerfinal is the code which takes the saved files, and preprocesses them for the final consumption in app. 
- server.R and UI.R are the files which finally run the app. however the code was finalised in the modelrefinement code. this is simply put in the server.R to run as an app. 


# About the app 
The app uses the HC Coursera Dataset as the database for the app. We have used 50% of the dataset(Twitter, Blog, and News), as the training dataset for the app. 

## How to use the app 
Please put in a few words in the space provided and the app will predict the next word, and other words that can also come up. the app also gives the time taken for processing, and how confident is the program about the prediction. This comes from whether the prediction is made basis trigram, or bigram or unigram. 
As the program is based on making N grams and then comparing the strings, it works better if the user inputs more than 2 words rather than just a word or 2.

# About the predictive algorithm:

1. Basis the dataset, the algorithm has database of N grams, Trigrams, Bigrams and Unigrams. 
2. For Trigram, the algorithm splits the database trigrams into 2 parts, final word, and first 2 words. When the user inputs the data, takes the last 2 words, compares them with the Trigram Database first 2 words. for those Trigrams with a match, it checks the probability of the final words and puts them in descending order. thus the topmost word is predicted and the rest are predicted as other possible words. 
3. Similarly for Bigrams, the algorithm splits the database of bigrams into first word and last word. When the user inputs the words, it takes the last word, compares them with the database, and selectes those bigrams, where the word matches. the next word then indicates the next words posssible and they are put in descending order of probability. the topmost word is taken as the predicted word. 



