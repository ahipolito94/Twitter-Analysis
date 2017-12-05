
# ---------- SET UP ----------

#!/usr/local/bin/Rscript

setwd("/Users/ahipolito94/Capstone_2/Data")
library(twitteR)

setup_twitter_oauth("consumer-key", 
                    "consumer-secret",
                    "access-key",
                    "access-secret")

# ---------- SEARCH TERMS ----------

iphonex_terms <- c("iphonex", "iPhonex", "iphoneX", "iPhoneX", "iphone10", "iPhone10",
                   "iphone x", "iPhone x", "iphone X", "iPhone X", "iphone 10", "iPhone 10",
              "#iphonex", "#iPhonex", "#iphoneX", "#iPhoneX", "#iphone10", "#iPhone10")
iphonex_terms_search <- paste(iphonex_terms, collapse = " OR ")
iphonex <- searchTwitter(iphonex_terms_search, n=20, lang="en")
iphonex <- twListToDF(iphonex)

galaxys8_terms <- c("galaxys8", "Galaxys8", "galaxy s8", "Galaxy s8", "galaxy S8", "Galaxy S8",
              "#galaxys8", "#Galaxys8", "#galaxy s8", "#Galaxy s8", "#galaxy S8", "#Galaxy S8")
galaxys8_terms_search <- paste(galaxys8_terms, collapse = " OR ")
galaxys8 <- searchTwitter(galaxys8_terms_search, n=20, lang="en")
galaxys8 <- twListToDF(galaxys8)

pixel2xl_terms <- c("pixel2xl", "Pixel2xl", "pixel2XL", "Pixel2XL", "pixel 2xl", "Pixel 2xl", "pixel 2XL", "Pixel 2XL",
                    "#pixel2xl", "#Pixel2xl", "#pixel2XL", "#Pixel2XL", "#pixel 2xl", "#Pixel 2xl", "#pixel 2XL", "#Pixel 2XL")
pixel2xl_terms_search <- paste(pixel2xl_terms, collapse = " OR ")
pixel2xl <- searchTwitter(pixel2xl_terms_search, n=20, lang="en")
pixel2xl <- twListToDF(pixel2xl)


# ---------- WRITE/APPEND TO CSV FILE ----------

#write.csv(iphonex, "/Users/ahipolito94/Capstone_2/Data/iphonex.csv", append=T)

write.table(iphonex, "/Users/ahipolito94/Capstone_2/Data/iphonex.csv", append=T, row.names=F, col.names=T,  sep=",")
write.table(galaxys8, "/Users/ahipolito94/Capstone_2/Data/galaxys8.csv", append=T, row.names=F, col.names=T,  sep=",")
write.table(pixel2xl, "/Users/ahipolito94/Capstone_2/Data/pixel2xl.csv", append=T, row.names=F, col.names=T,  sep=",")

iphonex_csv <- read.csv("/Users/ahipolito94/Capstone_2/Data/iphonex.csv", header = TRUE, encoding = "UCS-2LE")
View(iphonex_csv)

galaxys8_csv <- read.csv("/Users/ahipolito94/Capstone_2/Data/galaxys8.csv", header = TRUE, encoding = "UCS-2LE")
View(galaxys8_csv)

pixel2xl_csv <- read.csv("/Users/ahipolito94/Capstone_2/Data/pixel2xl.csv", header = TRUE, encoding = "UCS-2LE")
View(pixel2xl_csv)
