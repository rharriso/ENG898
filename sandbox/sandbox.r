# load from package
require(tm)
require(Snowball)
require(SnowballC)
require(XML)

txt <- system.file("texts", "txt", package = "tm")
ovid <- Corpus(DirSource(txt, encoding = "UTF-8"), readerControl = list(languages="lat"))

reut21578 <- system.file("texts", "crude", package = "tm")
reuters <- Corpus(DirSource(reut21578), 
                  readerControl = list(reader = readReut21578XML))

