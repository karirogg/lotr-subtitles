fotrtemp = readChar("fotr.srt", file.info("fotr.srt")$size)
fotr = unlist(strsplit(fotrtemp, split="\n"))

ttttemp = readChar("ttt.srt", file.info("ttt.srt")$size)
ttt = unlist(strsplit(ttttemp, split="\n"))

rotktemp = readChar("rotk.srt", file.info("rotk.srt")$size)
rotk = unlist(strsplit(rotktemp, split="\n"))

dat = data.frame(startTime=c(), endTime=c(), text=c(), stringsAsFactors = F)

currentString = ""
currentTime = ""
k=0
for(item in fotr) {
    if(grepl("-->", item)) {
        if(currentString != "") {
            currentString=gsub(pattern = "\\d|<i>|</i>","", currentString)
            currentTime=gsub(pattern = "\r","", currentTime)
            splitTime = unlist(strsplit(currentTime, " "))
            dat = rbind(dat, data.frame(movie="fotr", startTime=splitTime[1], endTime=splitTime[3], text=currentString))
            currentString = ""
        } 
        currentTime = item
        k = k+1
        
    } else {
        currentString = paste(currentString, item, sep=" ")
    }
}

for(item in ttt) {
    if(grepl("-->", item)) {
        if(currentString != "") {
            currentString=gsub(pattern = "\\d|<i>|</i>","", currentString)
            currentTime=gsub(pattern = "\r","", currentTime)
            splitTime = unlist(strsplit(currentTime, " "))
            dat = rbind(dat, data.frame(movie="ttt", startTime=splitTime[1], endTime=splitTime[3], text=currentString))
            currentString = ""
        } 
        currentTime = item
        k = k+1
        
    } else {
        currentString = paste(currentString, item, sep=" ")
    }
}

for(item in rotk) {
    if(grepl("-->", item)) {
        if(currentString != "") {
            currentString=gsub(pattern = "\\d|<i>|</i>","", currentString)
            currentTime=gsub(pattern = "\r","", currentTime)
            splitTime = unlist(strsplit(currentTime, " "))
            dat = rbind(dat, data.frame(movie="rotk", startTime=splitTime[1], endTime=splitTime[3], text=currentString))
            currentString = ""
        } 
        currentTime = item
        k = k+1
        
    } else {
        currentString = paste(currentString, item, sep=" ")
    }
}

dat = as.data.frame(lapply(dat,as.character))
