library(beepr)
library(data.table)
library(tau)
library(plyr)
setwd("F:/Rujuta/Coursera/Capstone/shinyold/intermediatelatestdataon1stjune")
load("allTrigrams_clean.RData")
load("allBigrams_clean.RData")
load("allTokens_clean.RData")



setwd("F:/Rujuta/Coursera/Capstone/shiny")
allTrigrams2 <- allTrigrams[count > 2]
allBigrams2 <- allBigrams[count > 2]
allTokens2 <- allTokens[count > 2]
#allFourgrams2 <- allFourgrams[count>2]
save(allTokens2, file="data/finalTokens.RData")

#dim(allFourgrams2)
dim(allTrigrams2)
dim(allBigrams2)
dim(allTokens2)

trigrams <- do.call(rbind, strsplit(allTrigrams2$ngram, split = " "))
trigrams <- cbind(apply(trigrams[, 1:2], 1, function(x) paste(x, collapse = " ")),
                  trigrams[, 3])
trigrams <- cbind.data.frame(trigrams, allTrigrams2$count)
setnames(trigrams, old = c("1","2","allTrigrams2$count"), new = c('ngram',"nextword","count"))

delete <- grep(pattern = "' ", trigrams$ngram)
trigrams <- trigrams[-delete, ]
trigrams <- arrange(trigrams, desc(count))
trigrams <- data.table(trigrams)
save(trigrams, file="data/finaltrigrams.RData")

bigrams <- do.call(rbind, strsplit(allBigrams2$ngram, split = " "))
bigrams <- cbind.data.frame(bigrams, allBigrams2$count)
setnames(bigrams, old = c("1","2","allBigrams2$count"), new = c('ngram',"nextword","count"))

bigrams <- bigrams[-(which(bigrams$ngram == "'")), ]
bigrams <- arrange(bigrams, desc(count))
bigrams <- data.table(bigrams)
save(bigrams, file="data/finalbigrams.RData")

setkey(allTokens2, "count", "ngram")
setkey(bigrams, "count", "ngram")
setkey(trigrams, "count", "ngram")
#setkey(fourgrams,"count","ngram")
