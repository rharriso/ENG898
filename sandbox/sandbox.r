text.v <- readLines("texts/war_and_peace.txt")
words <- scan("texts/war_and_peace.txt", character(0))
wordsNoQuotes <- scan("texts/war_and_peace.txt", character(0), quote=NULL)
sentences <- scan("texts/war_and_peace.txt", character(0), sep=".")

require("tau")
tokenize("here's a sentences. for you?")
require("cwhmisc")
substring.location("here's a sentences. for you?", "en")

# from internet
text.v <- scan("http://www.gutenberg.org/cache/epub/2701/pg2701.txt", what="character", sep="\n")

# only using content (sub arrays), .v appears to hook up to some statistics lib
start.v <- which(text.v == "CHAPTER 1. Loomings.")
end.v <- which(text.v == "orphan.")
start.metadata.v <- text.v[1:start.v-1]
end.metadata.v <- text.v[end.v+1:length(text.v)]
metadata.v <- c(start.metadata.v, end.metadata.v)

novel.v <- text.v[start.v:end.v]

#
# War and peace tagged in sentences
#
library(stringr)
library(hash)

# load in sentences
sentences <- scan("texts/war_and_peace.out.txt", character(0), quote="", sep='.')
# split sentenes into individual words
starr <- strsplit(sentences, " ")

characters <- new.env()

for (i in 1:length(starr)) {
  s <- unlist(starr[i])
  match_indices <- grep("/PERSON", s)
  matches <- s[match_indices]  
  names <- gsub("/PERSON", "", matches) 
  
  if(length(names) > 0){
    for (j in 1:length(names)){
      n <- names[j]
      
      # don't visit empty strings
      if(n != ""){
        prev <-characters[[n]]
        characters[[n]] <- c(prev, i) # add entry to vector
      }   
    }
  }
}