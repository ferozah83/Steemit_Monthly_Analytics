install.packages("wordcloud")
install.packages("RColorBrewer")
install.packages("KoNLP")

library(KoNLP)
library(RColorBrewer)
library(wordcloud)
library(ggplot2)


rm(list=ls())
f <- file("steemkr_wordcloud.txt", blocking= F)
txtLines <- readLines(f)

nouns <- sapply(txtLines,extractNoun, USE.NAMES=F)
nouns




close(f)
#data_unlist <- table(unlist(nouns))
data_unlist <- unlist(nouns)

data_unlist <- Filter(function(x){nchar(x)>=2}, data_unlist)



data_unlist1 = gsub('”', "", data_unlist)
data_unlist1 = gsub('“', "", data_unlist1)
data_unlist1 <- gsub("#", "", data_unlist1)
data_unlist1 <- gsub("[", "", data_unlist1)
data_unlist1 <- gsub("]", "", data_unlist1)
data_unlist1 <- gsub("$", "", data_unlist1)
data_unlist1 <- gsub("@", "", data_unlist1)
data_unlist1 <- gsub('[~!@#$%&*()_+=?<>]','',data_unlist1)
data_unlist1 <- gsub("\\[","",data_unlist1)
data_unlist1 <- gsub('[ㄱ-ㅎ]','',data_unlist1)
data_unlist1 <- gsub("가상\\S*", "가상화폐", data_unlist1)
data_unlist1 <- gsub("\\S*화폐", "가상화폐", data_unlist1)
data_unlist1 <- gsub("\\S*체인", "블록체인", data_unlist1)
data_unlist1 <- gsub("블록\\S*", "블록체인", data_unlist1)
data_unlist1 <- gsub("Bitco", "Bitcoin", data_unlist1)
data_unlist1 <- gsub("Bitco", "Bitcoin", data_unlist1)
data_unlist1 <- gsub("bitco", "Bitcoin", data_unlist1)
data_unlist1 <- gsub("BITCOIN*", "Bitcoin", data_unlist1)
data_unlist1 <- gsub("Bitco", "Bitcoin", data_unlist1)

data_unlist1 = gsub("of", "", data_unlist1)
data_unlist1 = gsub("01.", "", data_unlist1)
data_unlist1 = gsub("to", "", data_unlist1)
data_unlist1 = gsub("and", "", data_unlist1)
data_unlist1 = gsub("-01", "", data_unlist1)
data_unlist1 = gsub("10", "", data_unlist1)
data_unlist1 = gsub("is", "", data_unlist1)
data_unlist1 = gsub("for", "", data_unlist1)
data_unlist1 = gsub("my", "", data_unlist1)
data_unlist1 = gsub("on", "", data_unlist1)
data_unlist1 = gsub("12", "", data_unlist1)
data_unlist1 = gsub("with", "", data_unlist1)
data_unlist1 = gsub("#1", "", data_unlist1)
data_unlist1 = gsub("1.", "", data_unlist1)
data_unlist1 = gsub("2.", "", data_unlist1)
data_unlist1 = gsub("the", "", data_unlist1)
data_unlist1 = gsub("by", "", data_unlist1)
data_unlist1 = gsub("DAY", "", data_unlist1)
data_unlist1 = gsub("in", "", data_unlist1)
data_unlist1 = gsub("00", "", data_unlist1)
data_unlist1 = gsub("The", "", data_unlist1)
data_unlist1 = gsub("01", "", data_unlist1)
data_unlist1 = gsub("My", "", data_unlist1)
data_unlist1 = gsub("day", "", data_unlist1)
data_unlist1 = gsub("무엇", "", data_unlist1)
data_unlist1 = gsub("vs", "", data_unlist1)
data_unlist1 = gsub("하기", "", data_unlist1)
data_unlist1 = gsub("BW", "", data_unlist1)






data_unlist1 <- Filter(function(x){nchar(x)>=2}, data_unlist1)

sort(data_unlist1)


data_unlist1 <- table(data_unlist1)


View(data_unlist1)


pal <- brewer.pal(12,"Set3")
pal 
set.seed(123)
wordcloud(names(data_unlist1), freq=data_unlist1, scale=c(10,1), min.freq= 10, random.color=T, random.order=F ,rot.per=.23,colors=pal)


wordDf = data.frame(word=names(data_unlist1), freq=data_unlist1)

library(ggplot2)
View(sort(data_unlist1,decreasing=T))

ggplot(wordDf, aes(x=reorder(word,-freq.Freq) , y=freq.Freq)) + geom_bar(stat = "identity") 

ggplot(head(wordDf,35), aes(x=reorder(word,-freq.Freq)) + geom_bar(stat = "identity") 
#ggplot(head(wordDf,150), aes(x=reorder(word,-freq.Freq) , y=freq.Freq)) + geom_bar(stat = "identity") 

str(wordDf)

sort(wordDf$freq.Freq,decreasing=T)




pal = brewer.pal(n = 9, name = "Set1") 
wordcloud(wordDf$word # 단어
          , wordDf$freq.Freq # 빈도수
          , min.freq = 35
          , colors = pal 
          , rot.per = 0.2
          , random.order = F 
          , scale = c(2,1)
          , family="맑은 고딕")  

#install.packages("treemap")
library(treemap)
treemap(wordDf # 대상 데이터 설정
        ,title = "Word Tree Map"
        ,index = c("word") # 박스 안에 들어갈 변수 설정
        ,vSize = "freq.Freq"  # 박스 크기 기준
        ,fontfamily.labels = "AppleGothic" # 맥 폰트 설정
        ,fontsize.labels = 12 # 폰트 크기 설정
        ,palette=pal # 위에서 만든 팔레트 정보 입력
        ,border.col = "white") # 경계선 색깔 설정

