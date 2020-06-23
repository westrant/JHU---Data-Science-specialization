library(stringr)
library(quanteda)

## Load the data.
unigrams <- readRDS("./data/UniGram.rds")
bigrams <- readRDS("./data/BiGram.rds")
trigrams <- readRDS("./data/TriGram.rds")
quadgrams <- readRDS("./data/QuadGram.rds")


## Take user input, convert to lowercase, and tokenize.
tokenizeInput <- function(txt) {
  txt <- corpus(tolower(txt))
  tokens <- tokens(txt, verbose = F)
  tokens[[1]]
}

## Predict which ngram we want to use.
predictNgram <- function(txt, ngram = 4) {
  ngram <- min(ngram - 1, length(txt))
  txt <- tail(txt, ngram)
  txt <- paste(txt, collapse = "_")
  res <- list()
  res$bigram <- word(txt, -1, -1, sep = fixed("_"))
  res$trigram <- word(txt, -2, -1, sep = fixed("_"))
  res$tetragram <- word(txt, -3, -1, sep = fixed("_"))
  res
}

## Predict the next character.
predictNext <- function(txt) {
  txt <- tokenizeInput(txt)
  num_words <- length(txt)
  ngrams <- predictNgram(txt)
  
  ## If we have three or more words, iet's try to use quadgrams.
  if(num_words >= 3 && (!exists("prediction") || nrow(prediction) < 5)) {
    quadPredict <- quadgrams[quadgrams$sentence == ngrams$tetragram, ]
    if (!exists("prediction")) {
      prediction <- head(quadPredict, 5)
    } else {
      prediction <- rbind(prediction, head(quadPredict, 5))  
    }
  }
  
  ## If we have two or more words, let's try a trigram.
  if(num_words >= 2 && (!exists("prediction") || nrow(prediction) < 5)) {
    triPredict <- trigrams[trigrams$sentence == ngrams$trigram, ]
    if (!exists("prediction")) {
      prediction <- head(triPredict, 5)
    } else {
      prediction <- rbind(prediction, head(triPredict, 5))  
    }
  }
  
  ## If we have one or more words, let's try a bigram.
  if(num_words >= 1 && (!exists("prediction") || nrow(prediction) < 5)) {
    biPredict <- bigrams[bigrams$sentence == ngrams$bigram, ]
    if (!exists("prediction")) {
      prediction <- head(biPredict, 5)
    } else {
      prediction <- rbind(prediction, head(biPredict, 5))  
    }
  }
  
  ## If we made it here, the user hasn't entered anything.
  ## So, let's just return 5 common words.
  if (!exists("prediction")) {
    return(c("the", "I", "so", "we", "they"))
  } else {
    prediction <- prediction[order(prediction$probability, decreasing = TRUE),]
    prediction <- prediction$prediction
    prediction_length <- length(prediction)
    if (prediction_length < 5) {
      prediction <- c(prediction, rep("the", 5 - prediction_length))
    }
    return(prediction)
  }
}