library(beepr)
library(data.table)
library(tau)
library(plyr)

source("F:/Rujuta/Coursera/Capstone/code/makeNgrams.R")
getwd()
setwd("F:/Rujuta/Coursera/Capstone")


# Make n grams and skip n grams --------------------------------------------
# Twitter
en_Twitter_clean <- readLines("Data/en_US.twitter.txt", encoding = "UTF-8")
#Take sample
set.seed(1001)
twitterTrainIndices <- sample(seq_along(en_Twitter_clean),
                              size = round(0.2 * length(en_Twitter_clean)),
                              replace = F)
tokensTwitter <- makeNgrams(en_Twitter_clean[twitterTrainIndices],
                            ngram = 1,
                            markSentences = F)
tokensTwitter <- tokensTwitter[count > 1]
save(tokensTwitter, file = "tokensTwitter_clean.RData")
bigramsTwitter <- makeNgrams(en_Twitter_clean[twitterTrainIndices],
                             ngram = 2,
                             markSentences = F)
bigramsTwitter <- bigramsTwitter[count > 1]
save(bigramsTwitter,file="bigramsTwitter_clean.RData")
rm(bigramsTwitter)
trigramsTwitter <- makeNgrams(en_Twitter_clean[twitterTrainIndices],
                              ngram = 3,
                              markSentences = F)
save(trigramsTwitter, file = "trigramsTwitter_clean.RData")
rm(trigramsTwitter)
gc()
fourgramsTwitter <- makeNgrams(en_Twitter_clean[twitterTrainIndices],
                               ngram = 4,
                               markSentences = F)
save(fourgramsTwitter, file = "fourgramsTwitter_clean.RData")
rm(fourgramsTwitter, en_Twitter_clean)
gc()

# News

en_News_clean <- readLines("Data/en_US.news.txt", encoding = "UTF-8")

set.seed(1002)
newsTrainIndices <- sample(seq_along(en_News_clean),
                           size = round(0.2 * length(en_News_clean)),
                           replace = F)
tokensNews <- makeNgrams(en_News_clean[newsTrainIndices],
                         ngram = 1,
                         markSentences = F)
save(tokensNews, file = "tokensNews_clean.RData")
rm(tokensNews)
gc()
bigramsNews <- makeNgrams(en_News_clean[newsTrainIndices],
                          ngram = 2,
                          markSentences = F)
save(bigramsNews, file = "bigramsNews_clean.RData")
rm(bigramsNews)
gc()
trigramsNews <- makeNgrams(en_News_clean[newsTrainIndices],
                           ngram = 3,
                           markSentences = F)
save(trigramsNews, file = "trigramsNews_clean.RData")
rm(trigramsNews)
gc()
fourgramsNews <- makeNgrams(en_News_clean[newsTrainIndices],
                            ngram = 4,
                            markSentences = F)
save(fourgramsNews, file = "fourgramsNews_clean.RData")
rm(fourgramsNews, en_News_clean)
gc()


# Blogs

en_Blogs_clean <- readLines("Data/en_US.blogs.txt", encoding = "UTF-8")
gc()

set.seed(1003)
blogsTrainIndices <- sample(seq_along(en_Blogs_clean),
                            size = round(0.2 * length(en_Blogs_clean)),
                            replace = F)
tokensBlogs <- makeNgrams(en_Blogs_clean[blogsTrainIndices],
                          ngram = 1,
                          markSentences = F)
save(tokensBlogs, file = "tokensBlogs_clean.RData")
rm(tokensBlogs)
gc()
bigramsBlogs <- makeNgrams(en_Blogs_clean[blogsTrainIndices],
                           ngram = 2,
                           markSentences = F)
save(bigramsBlogs, file = "bigramsBlogs_clean.RData")
rm(bigramsBlogs)
gc()
trigramsBlogs <- makeNgrams(en_Blogs_clean[blogsTrainIndices],
                            ngram = 3,
                            markSentences = F)
save(trigramsBlogs, file = "trigramsBlogs_clean.RData")
rm(trigramsBlogs)
gc()
fourgramsBlogs <- makeNgrams(en_Blogs_clean[blogsTrainIndices],
                             ngram = 4,
                             markSentences = F)
save(fourgramsBlogs, file = "fourgramsBlogs_clean.RData")
rm(fourgramsBlogs)
gc()


# Combine n-grams of the different sources ------------------------------------
load("tokensBlogs_clean.RData")
load("tokensNews_clean.RData")
load("tokensTwitter_clean.RData")
allTokens <- rbind.fill(tokensBlogs, tokensNews, tokensTwitter)
allTokens <- data.table(allTokens)
allTokens <- allTokens[, lapply(.SD, sum), by = ngram]
save(allTokens, file = "allTokens_clean.RData")
rm(tokensBlogs, tokensTwitter, tokensNews)

load("bigramsBlogs_clean.RData")
load("bigramsNews_clean.RData")
load("bigramsTwitter_clean.RData")
allBigrams <- rbind.fill(bigramsBlogs, bigramsNews, bigramsTwitter)
allBigrams <- data.table(allBigrams)
allBigrams <- allBigrams[, lapply(.SD, sum), by = ngram]
save(allBigrams, file = "allBigrams_clean.RData")
rm(bigramsBlogs, bigramsTwitter, bigramsNews)

load("trigramsBlogs_clean.RData")
load("trigramsNews_clean.RData")
load("trigramsTwitter_clean.RData")
allTrigrams <- rbind.fill(trigramsBlogs, trigramsNews, trigramsTwitter)
allTrigrams <- data.table(allTrigrams)
allTrigrams <- allTrigrams[, lapply(.SD, sum), by = ngram]
save(allTrigrams, file = "allTrigrams_clean.RData")
rm(trigramsBlogs, trigramsTwitter, trigramsNews)

load("fourgramsBlogs_clean.RData")
load("fourgramsNews_clean.RData")
load("fourgramsTwitter_clean.RData")
allFourgrams <- rbind.fill(fourgramsBlogs, fourgramsNews, fourgramsTwitter)
allFourgrams <- data.table(allFourgrams)
allFourgrams <- allFourgrams[, lapply(.SD, sum), by = ngram]
save(allFourgrams, file = "allFourgrams_clean.RData")
rm(fourgramsBlogs, fourgramsTwitter, fourgramsNews)





