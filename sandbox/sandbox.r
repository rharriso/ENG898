lines <- readLines("texts/war_and_peace.txt")
words <- scan("texts/war_and_peace.txt", character(0))
wordsNoQuotes <- scan("texts/war_and_peace.txt", character(0), quote=NULL)
sentences <- scan("texts/war_and_peace.txt", character(0), sep=".")

require("tau")
tokenize("here's a sentences. for you?")
require("cwhmisc")
substring.location("here's a sentences. for you?", "en")