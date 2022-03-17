
#cargamos las librerias correspondientes
library(tm)
library(NLP)
library(SnowballC)
library(RColorBrewer)
library(wordcloud)


#Trabajo de repeticion de palabras SABADO.

setwd("~/R/Scripts - todos/nube de palabra mails")
texto <- readLines("~/R/Scripts - todos/nube de palabra mails/compimails.txt")
texto_2 <- VCorpus(VectorSource(texto))
texto_2 <- tm_map(texto_2, content_transformer(tolower))
texto_2 <- tm_map(texto_2, removePunctuation)
texto_2 <- tm_map(texto_2, removeWords, stopwords("spanish"))

View(texto_2)

#####  Data Frame ####

letras = TermDocumentMatrix(texto_2)
findFreqTerms(letras, lowfreq = 5)
matriz = as.matrix (letras)
vector <- sort(rowSums(matriz),decreasing=TRUE) 
dataletras <- data.frame(word= names(vector),frequencia=vector)
View(dataletras)


####  WordCloud   ####

colorgraf = brewer.pal(8, "Dark2")
wordcloud(dataletras$word,scale = c(4,0.5), freq = dataletras$freq, min.freq = 2,
          max.words=70, random.order=FALSE, rot.per=0.02, 
          colors=colorgraf)

title(main = "WordCloud - despedida Mdlz", cex.main=1.5)
