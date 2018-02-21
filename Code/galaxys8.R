# import packages
library(stringr)          # str_replace_all()
library(tm)               # stopwords()
library(ggplot2)          # ggplot()
library(wordcloud)        # wordcloud()
library(lda)              # lda.collapsed.gibbs.sampler()
library(LDAvis)           # createJSON(), serVis()
library(syuzhet)          # get_sentiment

# step 1: import data
galaxy_df <- read.csv("/Users/ahipolito94/Capstone_2/Data/galaxys8.csv", header = TRUE, encoding = "UCS-2LE")

# step 2: clean tweets/pre-processing
galaxy_df$clean_tweets <- cleanTweets(galaxy_df)            
new_df <- galaxy_df[!duplicated(galaxy_df$clean_tweets), ]  # removes duplicates
dim(galaxy_df)
dim(new_df)
galaxy_num <- nrow(new_df)

# step 3: sentiment analysis
new_df$sentiment <- get_sentiment(new_df$clean_tweets)

galaxy_sent_min <- min(new_df$sentiment)
galaxy_sent_max <- max(new_df$sentiment)
galaxy_sent_mean <- mean(new_df$sentiment)
galaxy_sent_median <- median(new_df$sentiment)

# step 4: tokenize words on space and output as a list
doc.list <- strsplit(galaxy_df$clean_tweets, "[[:space:]]+")

######### 

# step 5: compute the table of terms
term.table <- table(unlist(doc.list))
term.table <- sort(term.table, decreasing = TRUE)

# step 6: remove stopwords or words occurring less than 5 times
stop_words <- c(stopwords("english"), "twitter", "href", "via", "amp", "rt", "retweet", "falsenanaa", 
                "s","X", "x","iphone", "iphonex", "apple", "ios", "false" , "bd", "b", "c", "free", 
                "new", "now", "giveaway", "phone", "fef", "d", "android", "galaxy", "hindustan", 
                "samsung", "bc", "bitcoi", "don", "competition", "ends", "plus", "win", 
                "get", "e", "twitter", "tweet", "nok", "gagne")
del <- names(term.table) %in% stop_words | term.table < 5
term.table <- term.table[!del]
vocab <- as.character(freq_df$Var1)

# step 7: create frequency plot
freq_df <- data.frame(term.table)
freq_df <- freq_df[!(is.na(freq_df$Var1) | freq_df$Var1==""), ]

ggplot(freq_df[0:20,], aes(x=reorder(Var1, Freq), y=Freq)) + 
  geom_bar(stat="identity") + 
  ggtitle("Samsung Galaxy S8") + 
  xlab("Terms") + 
  ylab("Count") +
  coord_flip()

# step 8: create wordcloud
wordcloud(words = freq_df$Var1, freq = freq_df$Freq, max.words=600,colors=brewer.pal(10,"Dark2"), random.color=TRUE)

# step 9: pre-processing for lda
get.terms <- function(x) {
  index <- match(x, vocab)
  index <- index[!is.na(index)]
  rbind(as.integer(index - 1), as.integer(rep(1, length(index))))
}

documents <- lapply(doc.list, get.terms)

# step 10: set lda parameters
doc.length <- sapply(documents, function(x) sum(x[2, ]))   # number of tokens per document 
term.frequency <- as.integer(freq_df$Freq) 

K <- 5            # 5 topics
G <- 500          # number of iterations
alpha <- 0.02     # alpha
eta <- 0.02       # eta

# step 11: apply lda function
set.seed(123)
fit <- lda.collapsed.gibbs.sampler(documents = documents, K = K, vocab = vocab, 
                                   num.iterations = G, alpha = alpha, 
                                   eta = eta, initial = NULL, burnin = 0,
                                   compute.log.likelihood = TRUE)

theta <- t(apply(fit$document_sums + alpha, 2, function(x) x/sum(x)))
phi <- t(apply(t(fit$topics) + eta, 2, function(x) x/sum(x)))

tweets <- list(phi = phi,
               theta = theta,
               doc.length = doc.length,
               vocab = vocab,
               term.frequency = term.frequency)

# step 12: create  JSON object to feed visualization
json <- createJSON(phi = tweets$phi, 
                   theta = tweets$theta, 
                   doc.length = tweets$doc.length, 
                   vocab = tweets$vocab, 
                   term.frequency = tweets$term.frequency)

# step 13: create gist and open in browser
serVis(json, out.dir = 'vis', open.browser = TRUE, as.gist = TRUE) 

