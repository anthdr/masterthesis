
rm(list=ls())
setwd("C:/Users/hediera/Google Drive/Memoire2/R/comp3")
setwd("C:/Users/antoi/Google Drive/Memoire2/R/comp3")

#import donnée

rawdata <- read.csv("C:/Users/hediera/Google Drive/Memoire2/R/comp3/results.txt", sep=",", header=FALSE, comment.char="#",
                      na.strings=".", stringsAsFactors=FALSE,
                      quote="", fill=FALSE)

rawdata <- read.csv("C:/Users/antoi/Google Drive/Memoire2/R/comp3/results.txt", sep=",", header=FALSE, comment.char="#",
                     na.strings=".", stringsAsFactors=FALSE,
                     quote="", fill=FALSE)

names(rawdata) <- c("Time", "MD5.hash", "task", "Ordre", "seq", "Condition", "Item", "in", "completion")


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

rawdata <- subset(rawdata, id != 1 & id != 36 & id != 37)

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
  data$res.equation[data$Condition=="stat_low" & data$Item=="1"] <- "111"
  data$res.equation[data$Condition=="stat_high" & data$Item=="1"] <- "59"
  data$res.equation[data$Condition=="stat_low" & data$Item=="2"] <- "116"
  data$res.equation[data$Condition=="stat_high" & data$Item=="2"] <- "70"
  data$res.equation[data$Condition=="stat_low" & data$Item=="3"] <- "111"
  data$res.equation[data$Condition=="stat_high" & data$Item=="3"] <- "59"
  data$res.equation[data$Condition=="stat_low" & data$Item=="4"] <- "93"
  data$res.equation[data$Condition=="stat_high" & data$Item=="4"] <- "55"
  data$res.equation[data$Condition=="stat_low" & data$Item=="5"] <- "98"
  data$res.equation[data$Condition=="stat_high" & data$Item=="5"] <- "81"
  data$res.equation[data$Condition=="stat_low" & data$Item=="6"] <- "116"
  data$res.equation[data$Condition=="stat_high" & data$Item=="6"] <- "70"
  data$res.equation[data$Condition=="stat_low" & data$Item=="7"] <- "108"
  data$res.equation[data$Condition=="stat_high" & data$Item=="7"] <- "70"
  data$res.equation[data$Condition=="stat_low" & data$Item=="8"] <- "97"
  data$res.equation[data$Condition=="stat_high" & data$Item=="8"] <- "58"
  data$res.equation[data$Condition=="stat_low" & data$Item=="9"] <- "95"
  data$res.equation[data$Condition=="stat_high" & data$Item=="9"] <- "57"
  data$res.equation[data$Condition=="stat_low" & data$Item=="10"] <- "93"
  data$res.equation[data$Condition=="stat_high" & data$Item=="10"] <- "55"
  data$res.equation[data$Condition=="stat_low" & data$Item=="11"] <- "97"
  data$res.equation[data$Condition=="stat_high" & data$Item=="11"] <- "48"
  data$res.equation[data$Condition=="stat_low" & data$Item=="12"] <- "104"
  data$res.equation[data$Condition=="stat_high" & data$Item=="12"] <- "55"
  data$res.equation[data$Condition=="stat_low" & data$Item=="13"] <- "96"
  data$res.equation[data$Condition=="stat_high" & data$Item=="13"] <- "72"
  data$res.equation[data$Condition=="stat_low" & data$Item=="14"] <- "108"
  data$res.equation[data$Condition=="stat_high" & data$Item=="14"] <- "80"
  data$res.equation[data$Condition=="stat_low" & data$Item=="15"] <- "96"
  data$res.equation[data$Condition=="stat_high" & data$Item=="15"] <- "75"
  data$res.equation[data$Condition=="stat_low" & data$Item=="16"] <- "101"
  data$res.equation[data$Condition=="stat_high" & data$Item=="16"] <- "55"
  data$res.equation[data$Condition=="stat_low" & data$Item=="17"] <- "98"
  data$res.equation[data$Condition=="stat_high" & data$Item=="17"] <- "79"
  data$res.equation[data$Condition=="stat_low" & data$Item=="18"] <- "99"
  data$res.equation[data$Condition=="stat_high" & data$Item=="18"] <- "69"
  data$res.equation[data$Condition=="stat_low" & data$Item=="19"] <- "107"
  data$res.equation[data$Condition=="stat_high" & data$Item=="19"] <- "59"
  data$res.equation[data$Condition=="stat_low" & data$Item=="20"] <- "100"
  data$res.equation[data$Condition=="stat_high" & data$Item=="20"] <- "51"
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
  data$nbr.NP1[data$Item=="11"] <- "pl"
  data$nbr.NP1[data$Item=="12"] <- "sg"
  data$nbr.NP1[data$Item=="13"] <- "sg"
  data$nbr.NP1[data$Item=="14"] <- "sg"
  data$nbr.NP1[data$Item=="15"] <- "pl"
  data$nbr.NP1[data$Item=="16"] <- "pl"
  data$nbr.NP1[data$Item=="17"] <- "pl"
  data$nbr.NP1[data$Item=="18"] <- "sg"
  data$nbr.NP1[data$Item=="19"] <- "sg"
  data$nbr.NP1[data$Item=="20"] <- "sg"
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
#auto
data$nbr.comp[grep("ent",data$completion)] <- "pl"
data$nbr.comp[grep("ont",data$completion)] <- "pl"
data[is.na(data)] <- "sg"
#repasse
data$nbr.comp[data$Item=="8" & data$id=="2"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="2"] <- "sg"
data$nbr.comp[data$Item=="7" & data$id=="3"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="3"] <- "sg"
data$nbr.comp[data$Item=="13" & data$id=="4"] <- "sg"
data$nbr.comp[data$Item=="3" & data$id=="4"] <- "sg"
data$nbr.comp[data$Item=="2" & data$id=="4"] <- "sg"
data$nbr.comp[data$Item=="14" & data$id=="4"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="5"] <- "sg"
data$nbr.comp[data$Item=="18" & data$id=="5"] <- "sg"
data$nbr.comp[data$Item=="2" & data$id=="8"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="10"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="11"] <- "sg"
data$nbr.comp[data$Item=="13" & data$id=="12"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="12"] <- "sg"
data$nbr.comp[data$Item=="10" & data$id=="12"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="7" & data$id=="13"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="14" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="14"] <- "sg"
data$nbr.comp[data$Item=="2" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="3" & data$id=="15"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="15" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="6" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="16"] <- "sg"
data$nbr.comp[data$Item=="3" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="17"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="18"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="18"] <- "sg"
data$nbr.comp[data$Item=="5" & data$id=="18"] <- "sg"
data$nbr.comp[data$Item=="13" & data$id=="19"] <- "NA"
data$nbr.comp[data$Item=="19" & data$id=="20"] <- "sg"
data$nbr.comp[data$Item=="14" & data$id=="20"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="21"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="22"] <- "sg"
data$nbr.comp[data$Item=="13" & data$id=="23"] <- "NA"
data$nbr.comp[data$Item=="9" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="8" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="18" & data$id=="23"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="24"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="24"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="25"] <- "sg"
data$nbr.comp[data$Item=="3" & data$id=="25"] <- "sg"
data$nbr.comp[data$Item=="20" & data$id=="25"] <- "sg"
data$nbr.comp[data$Item=="6" & data$id=="25"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="26"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="27"] <- "sg"
data$nbr.comp[data$Item=="13" & data$id=="27"] <- "sg"
data$nbr.comp[data$Item=="4" & data$id=="27"] <- "sg"
data$nbr.comp[data$Item=="11" & data$id=="28"] <- "sg"
data$nbr.comp[data$Item=="17" & data$id=="29"] <- "sg"
data$nbr.comp[data$Item=="9" & data$id=="30"] <- "sg"
data$nbr.comp[data$Item=="12" & data$id=="30"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="30"] <- "sg"
data$nbr.comp[data$Item=="10" & data$id=="31"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="32"] <- "sg"
data$nbr.comp[data$Item=="19" & data$id=="33"] <- "sg"
data$nbr.comp[data$Item=="18" & data$id=="33"] <- "sg"
data$nbr.comp[data$Item=="9" & data$id=="33"] <- "sg"
data$nbr.comp[data$Item=="2" & data$id=="34"] <- "pl"
data$nbr.comp[data$Item=="18" & data$id=="34"] <- "sg"
data$nbr.comp[data$Item=="11" & data$id=="34"] <- "pl"
data$nbr.comp[data$Item=="3" & data$id=="34"] <- "sg"
data$nbr.comp[data$Item=="16" & data$id=="35"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="35"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="36"] <- "sg"
data$nbr.comp[data$Item=="1" & data$id=="37"] <- "sg"
data$nbr.comp[data$Item=="5" & data$id=="37"] <- "sg"
data$nbr.comp[data$Item=="10" & data$id=="37"] <- "sg"

#data$nbr.comp[data$Item=="" & data$id==""] <- "sg"


data$attachment <- ifelse(data$nbr.comp == data$nbr.NP1, 1, 0)
}

#codage moitié de session
{
  data$halfsession <- NA
  data$helpsession <- NA
}

for (i in 1:nrow(data)){
  
  if (data[i,"id"]==data[i+19,"id"]) {
    
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
    
  }
  
  i=i+1
  
}

data$halfsession <- ifelse(data$helpsession < 10, 0, 1)

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
cor.eq.participant <- data.table(data) 
cor.eq.participant <- cor.eq.participant[ , .(amount.cor.equation = sum(cor.equation)), by = .(id)]
data <- merge(data, cor.eq.participant, by="id")

{
  age <- subset(participants, participants$"in" == "age")
  age <- age[,c(9,10)]
  names(age) <- c("age","id")
  data <- merge(data, age, by="id") 
}

write.csv(data, file = "Datacomp3.csv")


