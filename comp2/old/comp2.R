##################################prep###########
rm(list=ls())
setwd("C:/Users/hediera/Google Drive/Memoire2/R/comp2")
setwd("C:/Users/antoi/Google Drive/Memoire2/R/comp2")

#import donnée
{
results1 <- read.csv("C:/Users/hediera/Google Drive/Memoire2/R/comp2/results1.txt", sep=",", header=FALSE, comment.char="#",
                      na.strings=".", stringsAsFactors=FALSE,
                      quote="", fill=FALSE)
results2 <- read.csv("C:/Users/hediera/Google Drive/Memoire2/R/comp2/results2.txt", sep=",", header=FALSE, comment.char="#",
                    na.strings=".", stringsAsFactors=FALSE,
                    quote="", fill=FALSE)
results3 <- read.csv("C:/Users/hediera/Google Drive/Memoire2/R/comp2/results3.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)
results4 <- read.csv("C:/Users/hediera/Google Drive/Memoire2/R/comp2/results4.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)
}
{
results1 <- read.csv("C:/Users/antoi/Google Drive/Memoire2/R/comp2/results1.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)
results2 <- read.csv("C:/Users/antoi/Google Drive/Memoire2/R/comp2/results2.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)
results3 <- read.csv("C:/Users/antoi/Google Drive/Memoire2/R/comp2/results3.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)
results4 <- read.csv("C:/Users/antoi/Google Drive/Memoire2/R/comp2/results4.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)
}

{
results1$V6[results1$V7==27] <- "stat_high"
results1$V6[results1$V7==28] <- "percep_low"
results2$V6[results2$V7==27] <- "stat_low"
results2$V6[results2$V7==28] <- "percep_high"
results3$V6[results3$V7==27] <- "percep_high"
results3$V6[results3$V7==28] <- "stat_low"
results4$V6[results4$V7==27] <- "percep_low"
results4$V6[results4$V7==28] <- "stat_high"
}

library(dplyr)
{
rawdata <- bind_rows(results1, results2, results3, results4)
names(rawdata) <- c("Time", "MD5.hash", "task", "Ordre", "seq", "Condition", "Item", "in", "completion")
}

#ajout id pour chaque participant
{
  rawdata$id <- NA
  timef <- as.factor(rawdata$Time)
  lvls <- levels(timef)
  
  for (i in 1:length(lvls)){
    
    rawdata[rawdata$Time==lvls[i] , ]$id <- i
    
  }
  
  rawdata$id <- as.factor(rawdata$id)
  nlevels(rawdata$id)
  rawdata$id <- as.numeric(rawdata$id)
}

rawdata <- subset(rawdata, id > 4)

#infos annexes
{
  participants <- subset(rawdata, rawdata$Condition == "intro")
  practice <- subset(rawdata, rawdata$Condition == "practice")
  filler <- subset(rawdata, rawdata$Condition == "filler")
  FM <- subset(rawdata, rawdata$Condition == "FM")
}

#ajout pour merge trials
{
data <- rawdata

data <- subset(data, !(Condition %in% "intro" | Condition %in% "practice" | Condition %in% "filler" | Condition %in% "FM"))
               
names(data) <- c("Time", "MD5.hash", "task", "Ordre", "seq", "Condition", "Item", "in", "rep.equation", "id")
}

{
  data$RT.equation <- NA
  data$completion <- NA
  data$RT.completion <- NA
  
  data$completion <- as.character(data$completion)
}
#merge trials (4 lignes en 1)
for (i in 1:nrow(data)){
  
  if (data[i,"Item"]==data[i+1,"Item"]) {
    
    data[i,"RT.equation"] <- data[i+1,"rep.equation"]
    
  }
  
  if (data[i+1,"Item"]==data[i+2,"Item"]) {
    
    data[i,"completion"] <- data[i+2,"rep.equation"]
    
  }
  
  if (data[i+2,"Item"]==data[i+3,"Item"]) {
    
    data[i,"RT.completion"] <- data[i+3,"rep.equation"]
    
  }
  
  i=i+1
  
}

data <- subset(data, data$"in" == "in" & data$seq == "0")

#reponses equation
{
  data$res.equation <- NA
  data$res.equation[data$Condition=="stat_low" & data$Item=="1"] <- "129"
  data$res.equation[data$Condition=="stat_high" & data$Item=="1"] <- "29"
  data$res.equation[data$Condition=="percep_low" & data$Item=="1"] <- "129"
  data$res.equation[data$Condition=="percep_high" & data$Item=="1"] <- "29"
  data$res.equation[data$Condition=="stat_low" & data$Item=="2"] <- "109"
  data$res.equation[data$Condition=="stat_high" & data$Item=="2"] <- "17"
  data$res.equation[data$Condition=="percep_low" & data$Item=="2"] <- "109"
  data$res.equation[data$Condition=="percep_high" & data$Item=="2"] <- "17"
  data$res.equation[data$Condition=="stat_low" & data$Item=="3"] <- "165"
  data$res.equation[data$Condition=="stat_high" & data$Item=="3"] <- "13"
  data$res.equation[data$Condition=="percep_low" & data$Item=="3"] <- "165"
  data$res.equation[data$Condition=="percep_high" & data$Item=="3"] <- "13"
  data$res.equation[data$Condition=="stat_low" & data$Item=="4"] <- "80"
  data$res.equation[data$Condition=="stat_high" & data$Item=="4"] <- "68"
  data$res.equation[data$Condition=="percep_low" & data$Item=="4"] <- "80"
  data$res.equation[data$Condition=="percep_high" & data$Item=="4"] <- "68"
  data$res.equation[data$Condition=="stat_low" & data$Item=="5"] <- "136"
  data$res.equation[data$Condition=="stat_high" & data$Item=="5"] <- "22"
  data$res.equation[data$Condition=="percep_low" & data$Item=="5"] <- "136"
  data$res.equation[data$Condition=="percep_high" & data$Item=="5"] <- "22"
  data$res.equation[data$Condition=="stat_low" & data$Item=="6"] <- "164"
  data$res.equation[data$Condition=="stat_high" & data$Item=="6"] <- "-22"
  data$res.equation[data$Condition=="percep_low" & data$Item=="6"] <- "164"
  data$res.equation[data$Condition=="percep_high" & data$Item=="6"] <- "-22"
  data$res.equation[data$Condition=="stat_low" & data$Item=="7"] <- "152"
  data$res.equation[data$Condition=="stat_high" & data$Item=="7"] <- "34"
  data$res.equation[data$Condition=="percep_low" & data$Item=="7"] <- "152"
  data$res.equation[data$Condition=="percep_high" & data$Item=="7"] <- "34"
  data$res.equation[data$Condition=="stat_low" & data$Item=="8"] <- "142"
  data$res.equation[data$Condition=="stat_high" & data$Item=="8"] <- "-48"
  data$res.equation[data$Condition=="percep_low" & data$Item=="8"] <- "142"
  data$res.equation[data$Condition=="percep_high" & data$Item=="8"] <- "-48"
  data$res.equation[data$Condition=="stat_low" & data$Item=="9"] <- "153"
  data$res.equation[data$Condition=="stat_high" & data$Item=="9"] <- "-54"
  data$res.equation[data$Condition=="percep_low" & data$Item=="9"] <- "153"
  data$res.equation[data$Condition=="percep_high" & data$Item=="9"] <- "-54"
  data$res.equation[data$Condition=="stat_low" & data$Item=="10"] <- "112"
  data$res.equation[data$Condition=="stat_high" & data$Item=="10"] <- "0"
  data$res.equation[data$Condition=="percep_low" & data$Item=="10"] <- "112"
  data$res.equation[data$Condition=="percep_high" & data$Item=="10"] <- "0"
  data$res.equation[data$Condition=="stat_low" & data$Item=="11"] <- "117"
  data$res.equation[data$Condition=="stat_high" & data$Item=="11"] <- "3"
  data$res.equation[data$Condition=="percep_low" & data$Item=="11"] <- "117"
  data$res.equation[data$Condition=="percep_high" & data$Item=="11"] <- "3"
  data$res.equation[data$Condition=="stat_low" & data$Item=="12"] <- "93"
  data$res.equation[data$Condition=="stat_high" & data$Item=="12"] <- "1"
  data$res.equation[data$Condition=="percep_low" & data$Item=="12"] <- "93"
  data$res.equation[data$Condition=="percep_high" & data$Item=="12"] <- "1"
  data$res.equation[data$Condition=="stat_low" & data$Item=="13"] <- "127"
  data$res.equation[data$Condition=="stat_high" & data$Item=="13"] <- "-39"
  data$res.equation[data$Condition=="percep_low" & data$Item=="13"] <- "127"
  data$res.equation[data$Condition=="percep_high" & data$Item=="13"] <- "-39"
  data$res.equation[data$Condition=="stat_low" & data$Item=="14"] <- "106"
  data$res.equation[data$Condition=="stat_high" & data$Item=="14"] <- "36"
  data$res.equation[data$Condition=="percep_low" & data$Item=="14"] <- "106"
  data$res.equation[data$Condition=="percep_high" & data$Item=="14"] <- "36"
  data$res.equation[data$Condition=="stat_low" & data$Item=="15"] <- "109"
  data$res.equation[data$Condition=="stat_high" & data$Item=="15"] <- "76"
  data$res.equation[data$Condition=="percep_low" & data$Item=="15"] <- "109"
  data$res.equation[data$Condition=="percep_high" & data$Item=="15"] <- "76"
  data$res.equation[data$Condition=="stat_low" & data$Item=="16"] <- "93"
  data$res.equation[data$Condition=="stat_high" & data$Item=="16"] <- "42"
  data$res.equation[data$Condition=="percep_low" & data$Item=="16"] <- "93"
  data$res.equation[data$Condition=="percep_high" & data$Item=="16"] <- "42"
  data$res.equation[data$Condition=="stat_low" & data$Item=="17"] <- "104"
  data$res.equation[data$Condition=="stat_high" & data$Item=="17"] <- "68"
  data$res.equation[data$Condition=="percep_low" & data$Item=="17"] <- "104"
  data$res.equation[data$Condition=="percep_high" & data$Item=="17"] <- "68"
  data$res.equation[data$Condition=="stat_low" & data$Item=="18"] <- "114"
  data$res.equation[data$Condition=="stat_high" & data$Item=="18"] <- "9"
  data$res.equation[data$Condition=="percep_low" & data$Item=="18"] <- "114"
  data$res.equation[data$Condition=="percep_high" & data$Item=="18"] <- "9"
  data$res.equation[data$Condition=="stat_low" & data$Item=="19"] <- "99"
  data$res.equation[data$Condition=="stat_high" & data$Item=="19"] <- "46"
  data$res.equation[data$Condition=="percep_low" & data$Item=="19"] <- "99"
  data$res.equation[data$Condition=="percep_high" & data$Item=="19"] <- "46"
  data$res.equation[data$Condition=="stat_low" & data$Item=="20"] <- "86"
  data$res.equation[data$Condition=="stat_high" & data$Item=="20"] <- "50"
  data$res.equation[data$Condition=="percep_low" & data$Item=="20"] <- "86"
  data$res.equation[data$Condition=="percep_high" & data$Item=="20"] <- "50"
  data$res.equation[data$Condition=="stat_low" & data$Item=="21"] <- "151"
  data$res.equation[data$Condition=="stat_high" & data$Item=="21"] <- "-19"
  data$res.equation[data$Condition=="percep_low" & data$Item=="21"] <- "151"
  data$res.equation[data$Condition=="percep_high" & data$Item=="21"] <- "-19"
  data$res.equation[data$Condition=="stat_low" & data$Item=="22"] <- "94"
  data$res.equation[data$Condition=="stat_high" & data$Item=="22"] <- "-1"
  data$res.equation[data$Condition=="percep_low" & data$Item=="22"] <- "94"
  data$res.equation[data$Condition=="percep_high" & data$Item=="22"] <- "-1"
  data$res.equation[data$Condition=="stat_low" & data$Item=="23"] <- "98"
  data$res.equation[data$Condition=="stat_high" & data$Item=="23"] <- "45"
  data$res.equation[data$Condition=="percep_low" & data$Item=="23"] <- "98"
  data$res.equation[data$Condition=="percep_high" & data$Item=="23"] <- "45"
  data$res.equation[data$Condition=="stat_low" & data$Item=="24"] <- "139"
  data$res.equation[data$Condition=="stat_high" & data$Item=="24"] <- "18"
  data$res.equation[data$Condition=="percep_low" & data$Item=="24"] <- "139"
  data$res.equation[data$Condition=="percep_high" & data$Item=="24"] <- "18"
  data$res.equation[data$Condition=="stat_low" & data$Item=="25"] <- "94"
  data$res.equation[data$Condition=="stat_high" & data$Item=="25"] <- "69"
  data$res.equation[data$Condition=="percep_low" & data$Item=="25"] <- "94"
  data$res.equation[data$Condition=="percep_high" & data$Item=="25"] <- "69"
  data$res.equation[data$Condition=="stat_low" & data$Item=="26"] <- "94"
  data$res.equation[data$Condition=="stat_high" & data$Item=="26"] <- "63"
  data$res.equation[data$Condition=="percep_low" & data$Item=="26"] <- "94"
  data$res.equation[data$Condition=="percep_high" & data$Item=="26"] <- "63"
  data$res.equation[data$Condition=="stat_low" & data$Item=="27"] <- "89"
  data$res.equation[data$Condition=="stat_high" & data$Item=="27"] <- "75"
  data$res.equation[data$Condition=="percep_low" & data$Item=="27"] <- "89"
  data$res.equation[data$Condition=="percep_high" & data$Item=="27"] <- "75"
  data$res.equation[data$Condition=="stat_low" & data$Item=="28"] <- "86"
  data$res.equation[data$Condition=="stat_high" & data$Item=="28"] <- "64"
  data$res.equation[data$Condition=="percep_low" & data$Item=="28"] <- "86"
  data$res.equation[data$Condition=="percep_high" & data$Item=="28"] <- "64"
  
  data$cor.equation <- NA
  data$cor.equation <- ifelse(data$rep.equation == data$res.equation, 1, 0)
}

#ajout nombre NP1
{
  data$nbr.NP1 <- NA
  data$nbr.comp <- NA  
  data$attachment <- NA
  
  data$nbr.NP1[data$Item=="1"] <-  "pl"
  data$nbr.NP1[data$Item=="2"] <-  "pl"
  data$nbr.NP1[data$Item=="3"] <-  "pl"
  data$nbr.NP1[data$Item=="4"] <-  "pl"
  data$nbr.NP1[data$Item=="5"] <-  "pl"
  data$nbr.NP1[data$Item=="6"] <-  "pl"
  data$nbr.NP1[data$Item=="7"] <-  "pl"
  data$nbr.NP1[data$Item=="8"] <-  "sg"
  data$nbr.NP1[data$Item=="9"] <-  "sg"
  data$nbr.NP1[data$Item=="10"] <- "sg"
  data$nbr.NP1[data$Item=="11"] <- "sg"
  data$nbr.NP1[data$Item=="12"] <- "sg"
  data$nbr.NP1[data$Item=="13"] <- "pl"
  data$nbr.NP1[data$Item=="14"] <- "sg"
  data$nbr.NP1[data$Item=="15"] <- "pl"
  data$nbr.NP1[data$Item=="16"] <- "sg"
  data$nbr.NP1[data$Item=="17"] <- "sg"
  data$nbr.NP1[data$Item=="18"] <- "pl"
  data$nbr.NP1[data$Item=="19"] <- "pl"
  data$nbr.NP1[data$Item=="20"] <- "sg"
  data$nbr.NP1[data$Item=="21"] <- "pl"
  data$nbr.NP1[data$Item=="22"] <- "sg"
  data$nbr.NP1[data$Item=="23"] <- "sg"
  data$nbr.NP1[data$Item=="24"] <- "sg"
  data$nbr.NP1[data$Item=="25"] <- "pl"
  data$nbr.NP1[data$Item=="26"] <- "sg"
  data$nbr.NP1[data$Item=="27"] <- "sg"
  data$nbr.NP1[data$Item=="28"] <- "sg"
}

#html to correct signs
{
data$completion <- sub("Ã¨", "è", data$completion)
data$completion <- sub("Ãª", "ê", data$completion)
data$completion <- sub("Ã´", "ô", data$completion)
data$completion <- sub("Ã§", "ç", data$completion)
data$completion <- sub("Ã¢", "â", data$completion)
data$completion <- sub("Ã ", "à", data$completion)
data$completion <- sub("Ã®", "ï", data$completion)
data$completion <- sub("Ã©", "é", data$completion)
data$completion <- sub("Ã©", "é", data$completion)
data$completion <- sub("Ã©", "é", data$completion)
data$completion <- sub("Ã©", "é", data$completion)
data$completion <- sub("Ä©", "é", data$completion)
data$completion <- sub("Ã©", "é", data$completion)
data$completion <- sub("Ã", "à", data$completion)
data$completion <- sub("Ã", "à", data$completion)
data$completion <- sub("%2C", ",", data$completion)
}

#nombre du verbe de la completion
{
data$nbr.comp[grep("ent",data$completion)] <- "pl"
data$nbr.comp[grep("ont",data$completion)] <- "pl"
data[is.na(data)] <- "sg"
#ent
data$nbr.comp[data$Item=="12" & data$id=="5"] <- "sg"
data$nbr.comp[data$Item=="21" & data$id=="6"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="6"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="8"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="8"] <- "sg"
data$nbr.comp[data$Item=="5" & data$id=="9"] <- "sg"
data$nbr.comp[data$Item=="10" & data$id=="10"] <- "sg"
data$nbr.comp[data$Item=="9" & data$id=="10"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="10"] <- "sg"
data$nbr.comp[data$Item=="25" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="23" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="10" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="12"] <- "sg"
data$nbr.comp[data$Item=="23" & data$id=="12"] <- "sg"
data$nbr.comp[data$Item=="22" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="10" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="24" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="7" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="23" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="22" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="23" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="28" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="23" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="11" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="28" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="24" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="14" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="21" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="24" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="14" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="21" & data$id=="19"] <- "sg"
data$nbr.comp[data$Item=="27" & data$id=="20"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="22"] <- "sg"
data$nbr.comp[data$Item=="15" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="24"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="24"] <- "sg"
data$nbr.comp[data$Item=="24" & data$id=="25"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="25"] <- "sg"
data$nbr.comp[data$Item=="5" & data$id=="28"] <- "sg"
data$nbr.comp[data$Item=="3" & data$id=="28"] <- "sg"
data$nbr.comp[data$Item=="6" & data$id=="28"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="29"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="30"] <- "sg"
data$nbr.comp[data$Item=="9" & data$id=="30"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="31"] <- "sg"
data$nbr.comp[data$Item=="6" & data$id=="31"] <- "sg"
data$nbr.comp[data$Item=="7" & data$id=="31"] <- "sg"
data$nbr.comp[data$Item=="21" & data$id=="32"] <- "sg"
#ont
data$nbr.comp[data$Item=="8" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="12"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="7" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="23" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="11" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="20"] <- "sg"
data$nbr.comp[data$Item=="24" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="24"] <- "sg"
data$nbr.comp[data$Item=="25" & data$id=="26"] <- "sg"
data$nbr.comp[data$Item=="15" & data$id=="28"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="33"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="33"] <- "sg"
data$nbr.comp[data$Item=="3" & data$id=="33"] <- "sg"
data$nbr.comp[data$Item=="2" & data$id=="34"] <- "sg"
data$nbr.comp[data$Item=="26" & data$id=="34"] <- "sg"
data$nbr.comp[data$Item=="11" & data$id=="34"] <- "sg"
data$nbr.comp[data$Item=="24" & data$id=="36"] <- "sg"
data$nbr.comp[data$Item=="21" & data$id=="36"] <- "sg"
data$nbr.comp[data$Item=="9" & data$id=="36"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="37"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="37"] <- "sg"
data$nbr.comp[data$Item=="7" & data$id=="40"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="40"] <- "NA"

data$attachment <- ifelse(data$nbr.comp == data$nbr.NP1, 1, 0)
}

#codage moitié de session
{
  data$halfsession <- NA
  data$helpsession <- NA
}

for (i in 1:nrow(data)){
  
  if (data[i,"id"]==data[i+27,"id"]) {
    
    data[i,"helpsession"] <- 1
    data[i+1,"helpsession"] <- 2
    data[i+2,"helpsession"] <- 3
    data[i+3,"helpsession"] <- 4
    data[i+4,"helpsession"] <- 5
    data[i+5,"helpsession"] <- 6
    data[i+6,"helpsession"] <- 7
    data[i+7,"helpsession"] <- 8
    data[i+8,"helpsession"] <- 9
    data[i+9,"helpsession"] <- 10
    data[i+10,"helpsession"] <- 11
    data[i+11,"helpsession"] <- 12
    data[i+12,"helpsession"] <- 13
    data[i+13,"helpsession"] <- 14
    data[i+14,"helpsession"] <- 15
    data[i+15,"helpsession"] <- 16
    data[i+16,"helpsession"] <- 17
    data[i+17,"helpsession"] <- 18
    data[i+18,"helpsession"] <- 19
    data[i+19,"helpsession"] <- 20
    data[i+20,"helpsession"] <- 21
    data[i+21,"helpsession"] <- 22
    data[i+22,"helpsession"] <- 23
    data[i+23,"helpsession"] <- 24
    data[i+24,"helpsession"] <- 25
    data[i+25,"helpsession"] <- 26
    data[i+26,"helpsession"] <- 27
    data[i+27,"helpsession"] <- 28
    
  }
  
  i=i+1
  
}

data$halfsession <- ifelse(data$helpsession < 15, 0, 1)

#scindage condition
{
  data$verbetype <- NA
  data$prompt <- NA
  data$verbetype[grep("percep",data$Condition)] <- "percep"
  data$verbetype[grep("stat",data$Condition)] <- "stat"
  data$prompt[grep("low",data$Condition)] <- "low"
  data$prompt[grep("high",data$Condition)] <- "high"
  data$vtype <- NA
  data$prime <- NA
  data$vtype <- ifelse(data$verbetype == "percep", 1, 0)
  data$prime <- ifelse(data$prompt =="high", 1, 0)
}

#ajout nombre d'equation correct par participants et age
require(data.table)
{
  cor.eq.participant <- data.table(data) 
  cor.eq.participant <- cor.eq.participant[ , .(amount.cor.equation = sum(cor.equation)), by = .(id)]
  cor.eq.participant$amount.cor.equation <- as.numeric(cor.eq.participant$amount.cor.equation)
  data <- merge(data, cor.eq.participant, by="id")
}
{  
  age <- subset(participants, participants$"in" == "age")
  age <- age[,c(9,10)]
  names(age) <- c("age","id")
  data <- merge(data, age, by="id") 
}


write.csv(data, file = "Datacomp2.csv")


##################################inspect####

data$amount.cor.equation <- as.numeric(data$amount.cor.equation)
bargraph.CI(x.factor=amount.cor.equation,group=Condition,response=attachment, col=c("tomato", "dark blue"), xlab="Prime (highly mathematically skillful group), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data)
data.onlygood <- subset(data, data$cor.equation  == 1)
bargraph.CI(x.factor=amount.cor.equation,group=Condition,response=attachment, col=c("tomato", "dark blue"), xlab="Prime (highly mathematically skillful group, only good), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood)



##################################split overall####

library(sciplot)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type, 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data)
dev.print(device = png, file = "1b", width = 800)

mean(data$attachment[data$verbetype == "percep" & data$prompt == "high"])
mean(data$attachment[data$verbetype == "percep" & data$prompt == "low"])
mean(data$attachment[data$verbetype == "stat" & data$prompt == "high"])
mean(data$attachment[data$verbetype == "stat" & data$prompt == "low"])

data$RT.equation <- as.numeric(data$RT.equation)
median_overall <- median(data$RT.equation)
data.lent <- subset(data, data$RT.equation > median_cor)
data.rapide <- subset(data, data$RT.equation < median_cor)

bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (fast equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.rapide)
dev.print(device = png, file = "1b-fast.png", width = 800)

mean(data.rapide$attachment[data.rapide$verbetype == "percep" & data.rapide$prompt == "high"])
mean(data.rapide$attachment[data.rapide$verbetype == "percep" & data.rapide$prompt == "low"])
mean(data.rapide$attachment[data.rapide$verbetype == "stat" & data.rapide$prompt == "high"])
mean(data.rapide$attachment[data.rapide$verbetype == "stat" & data.rapide$prompt == "low"])

bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (slow equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.lent)
dev.print(device = png, file = "1b-fast.png", width = 800)

mean(data.lent$attachment[data.lent$verbetype == "percep" & data.lent$prompt == "high"])
mean(data.lent$attachment[data.lent$verbetype == "percep" & data.lent$prompt == "low"])
mean(data.lent$attachment[data.lent$verbetype == "stat" & data.lent$prompt == "high"])
mean(data.lent$attachment[data.lent$verbetype == "stat" & data.lent$prompt == "low"])

library(brms)
  
data$vt <- ifelse(data$vtype==1, -1, 1)
data$pr <- ifelse(data$prime==1, -1, 1)
data$RT.equation <- as.numeric(data$RT.equation)
median_RT.equation <- median(data$RT.equation)
data$slow <- ifelse(data$RT.equation < median_RT.equation, -1, 1)

  
get_prior(attachment ~ vt*pr*slow + (vt*pr*slow|id) + (vt*pr*slow|Item), data=data, family=bernoulli)
  
prior <- c(set_prior("normal(0,10)", class="b"),
             set_prior("normal(0,10)", class="Intercept"),
             set_prior("normal(0,10)", class="sd"),
             set_prior("lkj(2)", class="cor"))
  
fit <- brm(attachment ~ 1+vt*pr*slow + (1+vt*pr*slow|id) + (1+vt*pr*slow|Item), data=data, family=bernoulli, 
             prior=prior, chains=4, iter=3000)
  
#plot(fit, ask = FALSE)
  
summary(fit, waic=T)
  
fit_df <- as.data.frame(fit)
beta <- fit_df[,grepl("b_",colnames(fit_df))]
beta <- beta[,-1]
  
library(tidyverse)
df.overall <- gather(beta, key=effect, value=beta, 1:ncol(beta)) %>%
    group_by(effect=as.factor(effect)) %>% 
    summarize(mean=mean(beta), # mean
              prob_greater=mean(beta>0), prob_smaller=mean(beta<0), # probability greater / smaller than zero
              min=min(beta), max=max(beta), # min and max values
              l95=unname(quantile(beta,probs=0.025)), # lower 95% credible intervals boundary
              h95=unname(quantile(beta,probs=0.975)), # upper 95% CrI boundary
              l85=unname(quantile(beta,probs=0.075)), # lower 85% CrI boundary
              h85=unname(quantile(beta,probs=0.925))) # upper 85% CrI boundary
  
levord <- colnames(beta)[1:ncol(beta)]
df.overall$effect <- factor(df.overall$effect, levels=levord)
df.overall <- arrange(df.overall, effect)
  
library(ggplot2)
ggplot(data=df.overall, aes(x=mean, y=effect)) + theme_bw() +
   ggtitle("Interaction: Overall") +
    geom_vline(aes(xintercept=0), size=1, linetype=2, col=gray(0.2)) + 
    geom_errorbarh(aes(xmax=max, xmin=min),height=0, size=1.2, col="#009E73") +
    geom_errorbarh(aes(xmax=l95, xmin=h95),linetype=1,height=0.2,size=1.5,col="#D55E00") +
    geom_errorbarh(aes(xmax=l85, xmin=h85),linetype=1,height=0.1,size=1.4,col="#56B4E9") +
    geom_point(size=4) + 
    scale_y_discrete(limits=rev(df.overall$effect))
dev.print(device = png, file = "1b-bayes", width = 800)



##################################split high math > 20####

datamath <- subset(data, data$amount.cor.equation > 20)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (highly mathematically skillful group), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath)
dev.print(device = png, file = "1b-highmath.png", width = 800)

mean(datamath$attachment[datamath$verbetype == "percep" & datamath$prompt == "high"])
mean(datamath$attachment[datamath$verbetype == "percep" & datamath$prompt == "low"])
mean(datamath$attachment[datamath$verbetype == "stat" & datamath$prompt == "high"])
mean(datamath$attachment[datamath$verbetype == "stat" & datamath$prompt == "low"])


datamath$RT.equation <- as.numeric(datamath$RT.equation)
median_cor <- median(datamath$RT.equation)
datamath.lent <- subset(datamath, datamath$RT.equation > median_cor)
datamath.rapide <- subset(datamath, datamath$RT.equation < median_cor)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (high-math group, fast equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.rapide)
dev.print(device = png, file = "1b-highmath-fast.png", width = 800)

mean(datamath.rapide$attachment[datamath.rapide$verbetype == "percep" & datamath.rapide$prompt == "high"])
mean(datamath.rapide$attachment[datamath.rapide$verbetype == "percep" & datamath.rapide$prompt == "low"])
mean(datamath.rapide$attachment[datamath.rapide$verbetype == "stat" & datamath.rapide$prompt == "high"])
mean(datamath.rapide$attachment[datamath.rapide$verbetype == "stat" & datamath.rapide$prompt == "low"])

bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (high-math group, slow equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.lent)
dev.print(device = png, file = "1b-highmath-slow.png", width = 800)

mean(datamath.lent$attachment[datamath.lent$verbetype == "percep" & datamath.lent$prompt == "high"])
mean(datamath.lent$attachment[datamath.lent$verbetype == "percep" & datamath.lent$prompt == "low"])
mean(datamath.lent$attachment[datamath.lent$verbetype == "stat" & datamath.lent$prompt == "high"])
mean(datamath.lent$attachment[datamath.lent$verbetype == "stat" & datamath.lent$prompt == "low"])

library(brms)

datamath$slow <- ifelse(datamath$RT.equation < median_cor, -1, 1)

get_prior(attachment ~ vt*pr*slow + (vt*pr*slow|id) + (vt*pr*slow|Item), data=datamath, family=bernoulli)

prior <- c(set_prior("normal(0,10)", class="b"),
           set_prior("normal(0,10)", class="Intercept"),
           set_prior("normal(0,10)", class="sd"),
           set_prior("lkj(2)", class="cor"))

fit <- brm(attachment ~ 1+vt*pr*slow + (1+vt*pr*slow|id) + (1+vt*pr*slow|Item), data=datamath, family=bernoulli, 
           prior=prior, chains=4, iter=3000)

#plot(fit, ask = FALSE)

summary(fit, waic=T)

fit_df <- as.data.frame(fit)
beta <- fit_df[,grepl("b_",colnames(fit_df))]
beta <- beta[,-1]

library(tidyverse)
df.math <- gather(beta, key=effect, value=beta, 1:ncol(beta)) %>%
  group_by(effect=as.factor(effect)) %>% 
  summarize(mean=mean(beta), # mean
            prob_greater=mean(beta>0), prob_smaller=mean(beta<0), # probability greater / smaller than zero
            min=min(beta), max=max(beta), # min and max values
            l95=unname(quantile(beta,probs=0.025)), # lower 95% credible intervals boundary
            h95=unname(quantile(beta,probs=0.975)), # upper 95% CrI boundary
            l85=unname(quantile(beta,probs=0.075)), # lower 85% CrI boundary
            h85=unname(quantile(beta,probs=0.925))) # upper 85% CrI boundary

levord <- colnames(beta)[1:ncol(beta)]
df.math$effect <- factor(df.math$effect, levels=levord)
df.math <- arrange(df.math, effect)

library(ggplot2)
ggplot(data=df.math, aes(x=mean, y=effect)) + theme_bw() +
  ggtitle("Interaction: highly mathematically skillful group") +
  geom_vline(aes(xintercept=0), size=1, linetype=2, col=gray(0.2)) + 
  geom_errorbarh(aes(xmax=max, xmin=min),height=0, size=1.2, col="#009E73") +
  geom_errorbarh(aes(xmax=l95, xmin=h95),linetype=1,height=0.2,size=1.5,col="#D55E00") +
  geom_errorbarh(aes(xmax=l85, xmin=h85),linetype=1,height=0.1,size=1.4,col="#56B4E9") +
  geom_point(size=4) + 
  scale_y_discrete(limits=rev(df.math$effect))
dev.print(device = png, file = "1b-bayes-highmath", width = 800)

##################################split onlygood####

data.onlygood <- subset(data, data$cor.equation == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (highly mathematically skillful group), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood)
dev.print(device = png, file = "1b-onlygood.png", width = 800)

mean(data.onlygood$attachment[data.onlygood$verbetype == "percep" & data.onlygood$prompt == "high"])
mean(data.onlygood$attachment[data.onlygood$verbetype == "percep" & data.onlygood$prompt == "low"])
mean(data.onlygood$attachment[data.onlygood$verbetype == "stat" & data.onlygood$prompt == "high"])
mean(data.onlygood$attachment[data.onlygood$verbetype == "stat" & data.onlygood$prompt == "low"])


data.onlygood$RT.equation <- as.numeric(data.onlygood$RT.equation)
median_onlygood <- median(data.onlygood$RT.equation)
data.onlygood.lent <- subset(data.onlygood, data.onlygood$RT.equation > median_cor)
data.onlygood.rapide <- subset(data.onlygood, data.onlygood$RT.equation < median_cor)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall, fast equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood.rapide)
dev.print(device = png, file = "1b-fast.png", width = 800)

mean(data.onlygood.rapide$attachment[data.onlygood.rapide$verbetype == "percep" & data.onlygood.rapide$prompt == "high"])
mean(data.onlygood.rapide$attachment[data.onlygood.rapide$verbetype == "percep" & data.onlygood.rapide$prompt == "low"])
mean(data.onlygood.rapide$attachment[data.onlygood.rapide$verbetype == "stat" & data.onlygood.rapide$prompt == "high"])
mean(data.onlygood.rapide$attachment[data.onlygood.rapide$verbetype == "stat" & data.onlygood.rapide$prompt == "low"])

bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (slow equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood.lent)
dev.print(device = png, file = "1b-slow.png", width = 800)

mean(data.onlygood.lent$attachment[data.onlygood.lent$verbetype == "percep" & data.onlygood.lent$prompt == "high"])
mean(data.onlygood.lent$attachment[data.onlygood.lent$verbetype == "percep" & data.onlygood.lent$prompt == "low"])
mean(data.onlygood.lent$attachment[data.onlygood.lent$verbetype == "stat" & data.onlygood.lent$prompt == "high"])
mean(data.onlygood.lent$attachment[data.onlygood.lent$verbetype == "stat" & data.onlygood.lent$prompt == "low"])

library(brms)

data.onlygood$slow <- ifelse(data.onlygood$RT.equation < median_cor, -1, 1)

get_prior(attachment ~ vt*pr*slow + (vt*pr*slow|id) + (vt*pr*slow|Item), data=data.onlygood, family=bernoulli)

prior <- c(set_prior("normal(0,10)", class="b"),
           set_prior("normal(0,10)", class="Intercept"),
           set_prior("normal(0,10)", class="sd"),
           set_prior("lkj(2)", class="cor"))

fit <- brm(attachment ~ 1+vt*pr*slow + (1+vt*pr*slow|id) + (1+vt*pr*slow|Item), data=data.onlygood, family=bernoulli, 
           prior=prior, chains=4, iter=3000)

#plot(fit, ask = FALSE)

summary(fit, waic=T)

fit_df <- as.data.frame(fit)
beta <- fit_df[,grepl("b_",colnames(fit_df))]
beta <- beta[,-1]

library(tidyverse)
df.onlygood <- gather(beta, key=effect, value=beta, 1:ncol(beta)) %>%
  group_by(effect=as.factor(effect)) %>% 
  summarize(mean=mean(beta), # mean
            prob_greater=mean(beta>0), prob_smaller=mean(beta<0), # probability greater / smaller than zero
            min=min(beta), max=max(beta), # min and max values
            l95=unname(quantile(beta,probs=0.025)), # lower 95% credible intervals boundary
            h95=unname(quantile(beta,probs=0.975)), # upper 95% CrI boundary
            l85=unname(quantile(beta,probs=0.075)), # lower 85% CrI boundary
            h85=unname(quantile(beta,probs=0.925))) # upper 85% CrI boundary

levord <- colnames(beta)[1:ncol(beta)]
df.onlygood$effect <- factor(df.onlygood$effect, levels=levord)
df.onlygood <- arrange(df.onlygood, effect)

library(ggplot2)
ggplot(data=df.onlygood, aes(x=mean, y=effect)) + theme_bw() +
  ggtitle("Interaction: Overall with correct responses to equation") +
  geom_vline(aes(xintercept=0), size=1, linetype=2, col=gray(0.2)) + 
  geom_errorbarh(aes(xmax=max, xmin=min),height=0, size=1.2, col="#009E73") +
  geom_errorbarh(aes(xmax=l95, xmin=h95),linetype=1,height=0.2,size=1.5,col="#D55E00") +
  geom_errorbarh(aes(xmax=l85, xmin=h85),linetype=1,height=0.1,size=1.4,col="#56B4E9") +
  geom_point(size=4) + 
  scale_y_discrete(limits=rev(df.onlygood$effect))
dev.print(device = png, file = "1b-bayes-onlygood", width = 800)

##################################split high math > 20 onlygood####



datamath.onlygood <- subset(datamath, datamath$cor.equation == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (high-math group, only good), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.onlygood)
dev.print(device = png, file = "1b-highmath-onlygood.png", width = 800)

mean(datamath.onlygood$attachment[datamath.onlygood$verbetype == "percep" & datamath.onlygood$prompt == "high"])
mean(datamath.onlygood$attachment[datamath.onlygood$verbetype == "percep" & datamath.onlygood$prompt == "low"])
mean(datamath.onlygood$attachment[datamath.onlygood$verbetype == "stat" & datamath.onlygood$prompt == "high"])
mean(datamath.onlygood$attachment[datamath.onlygood$verbetype == "stat" & datamath.onlygood$prompt == "low"])


datamath.onlygood$RT.equation <- as.numeric(datamath.onlygood$RT.equation)
median_cor.onlygood <- median(datamath.onlygood$RT.equation)
datamath.onlygood.lent <- subset(datamath.onlygood, datamath.onlygood$RT.equation > median_cor.onlygood)
datamath.onlygood.rapide <- subset(datamath, datamath$RT.equation < median_cor)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (high-math group, only good with fast equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.onlygood.rapide)
dev.print(device = png, file = "1b-highmath-onlygood-fast.png", width = 800)

mean(datamath.onlygood.rapide$attachment[datamath.onlygood.rapide$verbetype == "percep" & datamath.onlygood.rapide$prompt == "high"])
mean(datamath.onlygood.rapide$attachment[datamath.onlygood.rapide$verbetype == "percep" & datamath.onlygood.rapide$prompt == "low"])
mean(datamath.onlygood.rapide$attachment[datamath.onlygood.rapide$verbetype == "stat" & datamath.onlygood.rapide$prompt == "high"])
mean(datamath.onlygood.rapide$attachment[datamath.onlygood.rapide$verbetype == "stat" & datamath.onlygood.rapide$prompt == "low"])

bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (high-math group, only good with slow equation), 1b",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.onlygood.lent)
dev.print(device = png, file = "1b-highmath-onlygood-slow.png", width = 800)

mean(datamath.onlygood.lent$attachment[datamath.onlygood.lent$verbetype == "percep" & datamath.onlygood.lent$prompt == "high"])
mean(datamath.onlygood.lent$attachment[datamath.onlygood.lent$verbetype == "percep" & datamath.onlygood.lent$prompt == "low"])
mean(datamath.onlygood.lent$attachment[datamath.onlygood.lent$verbetype == "stat" & datamath.onlygood.lent$prompt == "high"])
mean(datamath.onlygood.lent$attachment[datamath.onlygood.lent$verbetype == "stat" & datamath.onlygood.lent$prompt == "low"])


library(brms)

datamath.onlygood$slow <- ifelse(datamath.onlygood$RT.equation < median_cor.onlygood, -1, 1)

get_prior(attachment ~ vt*pr*slow + (vt*pr*slow|id) + (vt*pr*slow|Item), data=datamath.onlygood, family=bernoulli)

prior <- c(set_prior("normal(0,10)", class="b"),
           set_prior("normal(0,10)", class="Intercept"),
           set_prior("normal(0,10)", class="sd"),
           set_prior("lkj(2)", class="cor"))

fit <- brm(attachment ~ 1+vt*pr*slow + (1+vt*pr*slow|id) + (1+vt*pr*slow|Item), data=datamath.onlygood, family=bernoulli, 
           prior=prior, chains=4, iter=3000)


#plot(fit, ask = FALSE)

summary(fit, waic=T)

fit_df <- as.data.frame(fit)
beta <- fit_df[,grepl("b_",colnames(fit_df))]
beta <- beta[,-1]

library(tidyverse)
df.math.onlygood <- gather(beta, key=effect, value=beta, 1:ncol(beta)) %>%
  group_by(effect=as.factor(effect)) %>% 
  summarize(mean=mean(beta), # mean
            prob_greater=mean(beta>0), prob_smaller=mean(beta<0), # probability greater / smaller than zero
            min=min(beta), max=max(beta), # min and max values
            l95=unname(quantile(beta,probs=0.025)), # lower 95% credible intervals boundary
            h95=unname(quantile(beta,probs=0.975)), # upper 95% CrI boundary
            l85=unname(quantile(beta,probs=0.075)), # lower 85% CrI boundary
            h85=unname(quantile(beta,probs=0.925))) # upper 85% CrI boundary

levord <- colnames(beta)[1:ncol(beta)]
df.math.onlygood$effect <- factor(df.math.onlygood$effect, levels=levord)
df.math.onlygood <- arrange(df.math.onlygood, effect)

library(ggplot2)
ggplot(data=df.math.onlygood, aes(x=mean, y=effect)) + theme_bw() +
  ggtitle("Interaction: highly mathematically skillful group with only correct responses") +
  geom_vline(aes(xintercept=0), size=1, linetype=2, col=gray(0.2)) + 
  geom_errorbarh(aes(xmax=max, xmin=min),height=0, size=1.2, col="#009E73") +
  geom_errorbarh(aes(xmax=l95, xmin=h95),linetype=1,height=0.2,size=1.5,col="#D55E00") +
  geom_errorbarh(aes(xmax=l85, xmin=h85),linetype=1,height=0.1,size=1.4,col="#56B4E9") +
  geom_point(size=4) + 
  scale_y_discrete(limits=rev(df.math.onlygood$effect))
dev.print(device = png, file = "1b-bayes-highmath-onlygood", width = 800)








LATER


##################################LATER####

#bonnes reponses equation par participant
require(ggplot2)
data$id <- as.factor(data$id)
ggplot(data=data) +
  geom_bar(mapping = aes(x = id, y = cor.equation), stat  = "identity")

#completion NP1 participant
ggplot(data=data) +
  geom_bar(mapping = aes(x = id, y = attachment), stat  = "identity")



#remove outliers, equation et completion
{
  data$RT.equation <- as.numeric(data$RT.equation)
  moy.eq <- mean(data$RT.equation)
  ecart.eq <- sd(data$RT.equation)
  
  data$RT.completion <- as.numeric(data$RT.completion)
  moy.comp <- mean(data$RT.completion)
  ecart.comp <- sd(data$RT.completion)
  
  exclu.eq <- moy.eq+2*ecart.eq
  exclu.comp <- moy.comp+2*ecart.comp
  
  data <- subset(data, data$RT.equation < exclu.eq)
  data <- subset(data, data$RT.completion < exclu.comp)
}

{
data$age <- as.numeric(data$age)
data$amount.cor.equation <- as.numeric(data$amount.cor.equation)
data$RT.equation <- as.numeric(data$RT.equation)
data$RT.completion <- as.numeric(data$RT.completion)
}

library(lme4)
library(car)
require(lmerTest)


m3=glmer(attachment ~ vtype * prime + (vtype||id) + (prime||id) + (prime||Item),data=data,family=binomial)
summary(m3)

#plot overall
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data)

overall=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data,family=binomial)
summary(overall)

#plot overall, premiere et deuxieme moitié de session
data.firsthalf <- subset(data, data$halfsession == 0)
data.secondhalf <- subset(data, data$halfsession == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall, first half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.firsthalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall, second half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.secondhalf)

overall.firsthalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.firsthalf,family=binomial)
summary(overall.firsthalf)
overall.secondhalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.secondhalf,family=binomial)
summary(overall.secondhalf)

#plot overall avec bonne reponse equation
data.onlygood <- subset(data, data$cor.equation  == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall with good response)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood)

overall.onlygood=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.onlygood,family=binomial)
summary(overall.onlygood)

#plot overall avec bonne reponse equation, premiere et deuxieme moitié de session
data.onlygood.firsthalf <- subset(data.onlygood, data.onlygood$halfsession == 0)
data.onlygood.secondhalf <- subset(data.onlygood, data.onlygood$halfsession == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall with good response, first half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood.firsthalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (overall with good response, second half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.onlygood.secondhalf)

overall.onlygood.firsthalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.onlygood.firsthalf,family=binomial)
summary(overall.onlygood.firsthalf)
overall.onlygood.secondhalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.onlygood.secondhalf,family=binomial)
summary(overall.onlygood.secondhalf)

#plot séparation bon et mauvais participants (sur les resultats d'equation)
datamath <- subset(data, data$amount.cor.equation > 14)
datalitt <- subset(data, data$amount.cor.equation <= 14)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically skillful group)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically inept group)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datalitt)

math=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datamath,family=binomial)
summary(math)
litt=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datalitt,family=binomial)
summary(litt)

#plot bon participants, premiere et deuxieme moitié
datamath.firsthalf <- subset(datamath, datamath$halfsession == 0)
datamath.secondhalf <- subset(datamath, datamath$halfsession == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically skillful group, first half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.firsthalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically skillful group, second half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.secondhalf)

math.firsthalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datamath.firsthalf,family=binomial)
summary(math.firsthalf)
math.secondhalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datamath.secondhalf,family=binomial)
summary(math.secondhalf)

#plot bon participants avec bonne reponse equation
datamath.onlygood <- subset(datamath, datamath$cor.equation == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically skillful group with good response)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.onlygood)

math.onlygood=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datamath.onlygood,family=binomial)
summary(math.onlygood)

#plot mauvais participants avec bonne reponse equation
datalitt.onlygood <- subset(datalitt, datalitt$cor.equation == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically inept group with good response)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datalitt.onlygood)

litt.onlygood=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datalitt.onlygood,family=binomial)
summary(litt.onlygood)

#plot bon participants avec bonne reponse equation, premiere et deuxieme moitie de session
datamath.onlygood.firsthalf <- subset(datamath.onlygood, datamath.onlygood$halfsession == 0)
datamath.onlygood.secondhalf <- subset(datamath.onlygood, datamath.onlygood$halfsession == 1)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically skillful group with good response, first half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.onlygood.firsthalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (mathematically skillful group with good response, second half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datamath.onlygood.secondhalf)

math.onlygood.halfsession=glmer(attachment ~ vtype * prime * halfsession + (vtype||id) + (1|Item),data=datamath.onlygood,family=binomial)
summary(math.onlygood.halfsession)

math.onlygood.firsthalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datamath.onlygood.firsthalf,family=binomial)
summary(math.onlygood.firsthalf)
math.onlygood.secondhalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=datamath.onlygood.secondhalf,family=binomial)
summary(math.onlygood.secondhalf)


##################################???#####

mage <- mean(data$age)
data.yng <- subset(data, data$age < mage)
data.old <- subset(data, data$age > mage)
data.yng.firsthalf <- subset(data.yng, data.yng$halfsession == 0)
data.yng.secondhalf <- subset(data.yng, data.yng$halfsession == 1)
data.old.firsthalf <- subset(data.old, data.old$halfsession == 0)
data.old.secondhalf <- subset(data.old, data.old$halfsession == 1)

bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (below mean age, first half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.yng.firsthalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (below mean age, second half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.yng.secondhalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (above mean age, first half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.old.firsthalf)
bargraph.CI(x.factor=verbetype, group= prompt,response=attachment, col=c("tomato", "dark blue"), xlab="Verb type (above mean age, second half)",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.old.secondhalf)

yng.firsthalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.yng.firsthalf,family=binomial)
summary(yng.firsthalf)
yng.secondhalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.yng.secondhalf,family=binomial)
summary(yng.secondhalf)
old.firsthalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.old.firsthalf,family=binomial)
summary(old.firsthalf)
old.secondhalf=glmer(attachment ~ vtype * prime + (vtype||id) + (1|Item),data=data.old.secondhalf,family=binomial)
summary(old.secondhalf)



