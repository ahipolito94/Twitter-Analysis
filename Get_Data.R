#!/usr/local/bin/Rscript

# ---------- SET UP ----------
setwd("/Users/ahipolito94/Capstone_2/Data")
library(twitteR)

setup_twitter_oauth("ptvRakfz60tOZTu8EHF5ga9Qa", 
                    "DPru6ywvxXBnTFA56EnEVT4A6N6MO8ZaGXVSbn2acowB7tpHTe",
                    "3560060536-7bcx89YFtFxxr5A4X8rpEdj1jq8EmIyXx05VdxR",
                    "Z62vuu5S2pHJIxVG7jot9b8jJEmCNcyUBBt1t5KQjMFpr")

# ---------- SEARCH TERMS ----------

iphonex_terms <- c("iphonex", "iPhonex", "iphoneX", "iPhoneX", "iphone10", "iPhone10",
                   "iphone x", "iPhone x", "iphone X", "iPhone X", "iphone 10", "iPhone 10",
              "#iphonex", "#iPhonex", "#iphoneX", "#iPhoneX", "#iphone10", "#iPhone10")
iphonex_terms_search <- paste(iphonex_terms, collapse = " OR ")
iphonex <- searchTwitter(iphonex_terms_search, n=1000, lang="en")
iphonex <- twListToDF(iphonex)

galaxys8_terms <- c("galaxys8", "Galaxys8", "galaxy s8", "Galaxy s8", "galaxy S8", "Galaxy S8",
              "#galaxys8", "#Galaxys8", "#galaxy s8", "#Galaxy s8", "#galaxy S8", "#Galaxy S8")
galaxys8_terms_search <- paste(galaxys8_terms, collapse = " OR ")
galaxys8 <- searchTwitter(galaxys8_terms_search, n=1000, lang="en")
galaxys8 <- twListToDF(galaxys8)

pixel2xl_terms <- c("pixel2XL", "Pixel 2XL","#pixel2xl")
pixel2xl_terms_search <- paste(pixel2xl_terms, collapse = " OR ")
pixel2xl <- searchTwitter(pixel2xl_terms_search, n=1000, lang="en")
pixel2xl <- twListToDF(pixel2xl)

oneplus_terms <- c("oneplus 5t", "Oneplus 5t", "oneplus 5T", "Oneplus 5T", "oneplus5t",
                   "#oneplus 5t", "#Oneplus 5t", "#oneplus 5T", "#Oneplus 5T", "#oneplus5t")
oneplus_terms_search <- paste(oneplus_terms, collapse = " OR ")
oneplus <- searchTwitter(oneplus_terms_search, n=1000, lang="en")
oneplus <- twListToDF(oneplus)

# ---------- WRITE/APPEND TO CSV FILE ---------- 

write.table(iphonex, "/Users/ahipolito94/Capstone_2/Data/iphonex.csv", append=T, row.names=F, col.names=T,  sep=",")
write.table(galaxys8, "/Users/ahipolito94/Capstone_2/Data/galaxys8.csv", append=T, row.names=F, col.names=T,  sep=",")
write.table(pixel2xl, "/Users/ahipolito94/Capstone_2/Data/pixel2xl.csv", append=T, row.names=F, col.names=T,  sep=",")
write.table(oneplus, "/Users/ahipolito94/Capstone_2/Data/oneplus.csv", append=T, row.names=F, col.names=T,  sep=",")

