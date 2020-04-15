fotrtemp = readChar("fotr.srt", file.info("fotr.srt")$size)
fotr = tibble(raw=unlist(strsplit(fotrtemp, split="\n")))

ttttemp = readChar("ttt.srt", file.info("ttt.srt")$size)
ttt = tibble(raw=unlist(strsplit(ttttemp, split="\n")))

rotktemp = readChar("rotk.srt", file.info("rotk.srt")$size)
rotk = tibble(raw=unlist(strsplit(rotktemp, split="\n")))

movies = bind_rows(fotr,ttt,rotk, .id="source")

dat = data.frame(movie=c(), startTime=c(), endTime=c(), text=c(), stringsAsFactors = F)

currentString = ""
currentTime = ""
k=0

for(i in 1:nrow(movies)) {
    if(grepl("-->", movies$raw[i])) {
        if(currentString != "") {
            currentString=trimws(tolower(gsub(pattern = '\\d|<i>|</i>|\\.|:|,|\\r|\\?|\\!|\\-|"',"", currentString)))
            currentTime=gsub(pattern = "\\r","", currentTime)
            splitTime = unlist(strsplit(currentTime, " "))
            dat = rbind(dat, data.frame(movie=movies$source[i], startTime=splitTime[1], endTime=splitTime[3], text=currentString, stringsAsFactors = F))
            currentString = ""
        } 
        currentTime = movies$raw[i]
        k = k+1
            
    } else {
        currentString = paste(currentString, movies$raw[i], sep=" ")
    }
}

dat = dat %>% separate_rows(., text, sep=" ")

songs = c("survive.lrc", "winnertakes.lrc", "Bohemian.lrc", "doesmother.lrc", "Wonderwall.lrc")
lyricsdat = data.frame(songname=c(), nword=c(), word=c(), stringsAsFactors = F)

for(i in 1:length(songs)) {
    rawlyr = readChar(songs[i], file.info(songs[i])$size)
    subbedlyr = rawlyr %>% sub("\\[[0-9][0-9]:[0-9][0-9].[0-9][0-9]\\]","á",.) %>% gsub("\\[|\\]", " ", .) %>% gsub("\\.|\\,|\\?|\\!|\\n|\\:|\\-|\\d", "", .) %>% tolower()
    templyr = unlist(strsplit(subbedlyr, split="á"))
    splitlyr = unlist(strsplit(templyr[2], split=" "))
    splitlyr = splitlyr[splitlyr != ""]
    lyricsdat = rbind(lyricsdat, data.frame(songname=songs[i], nword=1:length(splitlyr), word=splitlyr, stringsAsFactors = F))
}

total = left_join(lyricsdat, dat, by=c("word"="text"))
group_by(total, songname, word) %>% summarize(word)
