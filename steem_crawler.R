install.packages(c('rvest','httr','KoNLP','stringr','tm','qgraph','xml2'))

install.packages("dplyr")


rm(list=ls())



library(rvest)

library(httr)

library(KoNLP)

library(stringr)

library(tm)

library(qgraph)

library(dplyr)

library('xml2')

for ( x in 1:100){
  
url_base <- 'https://steemit.com/created/kr' 

steem <- read_html(url_base)

steem

#steem_title <- html_nodes(steem, 'div') %>% html_nodes('h2')


steem_title <- html_nodes(steem, 'div') %>% html_nodes('h2') %>% html_nodes('a') 

steem_title_text <- html_text(steem_title)

steem_title_link <- html_nodes(steem, 'div') %>% html_nodes('h2') %>% html_nodes('a') %>% html_attr('href')

steemit <- cbind.data.frame(Number=c(1:20),TITLE=steem_title_text , LINK=steem_title_link)

View(steemit)


##class(steem_title_text)
setwd("E:/Study/R")
##final_data = data.frame(steemit,stringsAsFactors = F)
##write.csv(final_data, 'steem_test.csv')

write.table(steemit, file = "steem_test_total.csv", sep = ",", row.names = F, append = TRUE)

Sys.sleep(1800)
}
