movies=c("fotr.srt", "ttt.srt", "rotk.srt")
dat = data.frame(movie=c(), startTime=c(), endTime=c(), text=c(), stringsAsFactors = F)

for(movie in movies) {
    currentString = ""
    currentTime = ""
    k=0
    temp = readChar(movie, file.info(movie)$size)
    subtitles = unlist(strsplit(temp, split="\n"))
    for(subtitle in subtitles) {
        if(grepl("-->", subtitle)) {
            if(currentString != "") {
                currentString=trimws(tolower(gsub(pattern = '\\d|<i>|</i>|\\.|:|,|\\r|\\?|\\!|\\-|"',"", currentString)))
                currentTime=gsub(pattern = "\\r","", currentTime)
                splitTime = unlist(strsplit(currentTime, " "))
                dat = rbind(dat, data.frame(movie=movie, startTime=splitTime[1], endTime=splitTime[3], text=currentString, stringsAsFactors = F))
                currentString = ""
            } 
            currentTime = subtitle
            k = k+1
            
        } else {
            currentString = paste(currentString, subtitle, sep=" ")
        }
    }
}

dat = dat %>% separate_rows(., text, sep=" ")

songs = c("survive.lrc", "winnertakes.lrc", "Bohemian.lrc", "doesmother.lrc", "Wonderwall.lrc")
lyricsdat = data.frame(songname=c(), nword=c(), word=c(), stringsAsFactors = F)

for (song in songs) {
    rawlyr = readChar(song, file.info(song)$size)
    subbedlyr = rawlyr %>% sub("\\[[0-9][0-9]:[0-9][0-9].[0-9][0-9]\\]","á",.) %>% gsub("\\[|\\]", " ", .) %>% gsub("\\.|\\,|\\?|\\!|\\n|\\:|\\-|\\d", "", .) %>% tolower()
    templyr = unlist(strsplit(subbedlyr, split="á"))
    splitlyr = unlist(strsplit(templyr[2], split=" "))
    splitlyr = splitlyr[splitlyr != ""]
    lyricsdat = rbind(lyricsdat, data.frame(songname=song, nword=1:length(splitlyr), word=splitlyr, stringsAsFactors = F))
}

total3 = left_join(lyricsdat, dat, by=c("word"="text"))

#group_by(total, songname, word) %>% summarize(word)
