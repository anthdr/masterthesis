
rm(list=ls())
setwd("D:/Gdrive/Memoire2/R/comp1")
{
#import donnée
rawdata <- read.table("C:/Users/antoi/Google Drive/Memoire2/R/comp1/results", sep=",", header=FALSE, comment.char="#",
                      na.strings=".", stringsAsFactors=FALSE,
                      quote="", fill=FALSE)
#noms colonnes
names(rawdata) <- c("Time.results.were.received", "MD5.hash.of.participant's.IP.address", "Controller.name", "Item.number", "Element.number", "Type", "Item", "Field.name", "rep.equation")

#ajout id pour chaque participant
{
  rawdata$id <- NA
  timef <- as.factor(rawdata$Time.results.were.received)
  lvls <- levels(timef)
  
  for (i in 1:length(lvls)){
    
    rawdata[rawdata$Time.results.were.received==lvls[i] , ]$id <- i
    
  }
  
  rawdata$id <- as.factor(rawdata$id)
  nlevels(rawdata$id)
  rawdata$id <- as.numeric(rawdata$id)
}

#drop mauvais participants
{
  rawdata <- subset(rawdata, id > 4 & id!=62 & id!=63) #6 test exp
  rawdata <- subset(rawdata, id!=20 & id!=43 & id!=55 & id!=78 & id!=85) #3 pas francais L1
  rawdata <- subset(rawdata, id!=116) #mauvais calcul
  rawdata <- subset(rawdata, id!=93) #a découvert le design
  rawdata <- subset(rawdata, id!=88) #experience a 2
  rawdata <- subset(rawdata, id!=29 & id!=44) #pas majeur
  rawdata <- droplevels(rawdata)
  rawdata$id <- as.factor(rawdata$id)
  nlevels(rawdata$id)
}

#ajout pour merge trials
{
  rawdata$RT.equation <- NA
  rawdata$completion <- NA
  rawdata$RT.completion <- NA
  
  rawdata$rep.equation <- as.character(rawdata$rep.equation)
}
#merge trials (4ligne en 1)
for (i in 1:nrow(rawdata)){
  
  if (rawdata[i,"Item.number"]==rawdata[i+1,"Item.number"]) {
    
    rawdata[i,"RT.equation"] <- rawdata[i+1,"rep.equation"]
    
  }
  
  if (rawdata[i+1,"Item.number"]==rawdata[i+2,"Item.number"]) {
    
    rawdata[i,"completion"] <- rawdata[i+2,"rep.equation"]
    
  }
  
  if (rawdata[i+2,"Item.number"]==rawdata[i+3,"Item.number"]) {
    
    rawdata[i,"RT.completion"] <- rawdata[i+3,"rep.equation"]
    
  }
  
  i=i+1
  
}


}
{
rawdata <- subset(rawdata, Field.name!="_REACTION_TIME_" & Element.number!="1")

#données, infos participant et filler mathématiques
{
  data <- subset(rawdata, Type!="intro" & Type!="practice" & Type!="filler" & Type!="FM")
  participants <- subset(rawdata, Type!="percep_low" & Type!="percep_high" & Type!="stat_low" & Type!="stat_high" & Type!="filler")
  FM <- subset(rawdata, Type!="intro" & Type!="practice" & Type!="filler" & Type!="percep_low" & Type!="percep_high" & Type!="stat_low" & Type!="stat_high" & Type!="filler")
}

# réponses equation
{
  data$res.equation <- NA
  data$res.equation[data$Type=="percep_low" & data$Item=="1"] <- "44"
  data$res.equation[data$Type=="percep_high" & data$Item=="1"] <- "20"
  data$res.equation[data$Type=="stat_low" & data$Item=="1"] <- "35"
  data$res.equation[data$Type=="stat_high" & data$Item=="1"] <- "126"
  data$res.equation[data$Type=="percep_low" & data$Item=="2"] <- "84"
  data$res.equation[data$Type=="percep_high" & data$Item=="2"] <- "39"
  data$res.equation[data$Type=="stat_low" & data$Item=="2"] <- "40"
  data$res.equation[data$Type=="stat_high" & data$Item=="2"] <- "15"
  data$res.equation[data$Type=="percep_low" & data$Item=="3"] <- "104"
  data$res.equation[data$Type=="percep_high" & data$Item=="3"] <- "64"
  data$res.equation[data$Type=="stat_low" & data$Item=="3"] <- "66"
  data$res.equation[data$Type=="stat_high" & data$Item=="3"] <- "24"
  data$res.equation[data$Type=="percep_low" & data$Item=="4"] <- "36"
  data$res.equation[data$Type=="percep_high" & data$Item=="4"] <- "30"
  data$res.equation[data$Type=="stat_low" & data$Item=="4"] <- "22"
  data$res.equation[data$Type=="stat_high" & data$Item=="4"] <- "4"
  data$res.equation[data$Type=="percep_low" & data$Item=="5"] <- "63"
  data$res.equation[data$Type=="percep_high" & data$Item=="5"] <- "63"
  data$res.equation[data$Type=="stat_low" & data$Item=="5"] <- "44"
  data$res.equation[data$Type=="stat_high" & data$Item=="5"] <- "24"
  data$res.equation[data$Type=="percep_low" & data$Item=="6"] <- "105"
  data$res.equation[data$Type=="percep_high" & data$Item=="6"] <- "117"
  data$res.equation[data$Type=="stat_low" & data$Item=="6"] <- "27"
  data$res.equation[data$Type=="stat_high" & data$Item=="6"] <- "36"
  data$res.equation[data$Type=="percep_low" & data$Item=="7"] <- "49"
  data$res.equation[data$Type=="percep_high" & data$Item=="7"] <- "56"
  data$res.equation[data$Type=="stat_low" & data$Item=="7"] <- "72"
  data$res.equation[data$Type=="stat_high" & data$Item=="7"] <- "16"
  data$res.equation[data$Type=="percep_low" & data$Item=="8"] <- "56"
  data$res.equation[data$Type=="percep_high" & data$Item=="8"] <- "72"
  data$res.equation[data$Type=="stat_low" & data$Item=="8"] <- "96"
  data$res.equation[data$Type=="stat_high" & data$Item=="8"] <- "21"
  data$res.equation[data$Type=="percep_low" & data$Item=="9"] <- "54"
  data$res.equation[data$Type=="percep_high" & data$Item=="9"] <- "98"
  data$res.equation[data$Type=="stat_low" & data$Item=="9"] <- "56"
  data$res.equation[data$Type=="stat_high" & data$Item=="9"] <- "6"
  data$res.equation[data$Type=="percep_low" & data$Item=="10"] <- "72"
  data$res.equation[data$Type=="percep_high" & data$Item=="10"] <- "64"
  data$res.equation[data$Type=="stat_low" & data$Item=="10"] <- "126"
  data$res.equation[data$Type=="stat_high" & data$Item=="10"] <- "45"
  data$res.equation[data$Type=="percep_low" & data$Item=="11"] <- "136"
  data$res.equation[data$Type=="percep_high" & data$Item=="11"] <- "26"
  data$res.equation[data$Type=="stat_low" & data$Item=="11"] <- "11"
  data$res.equation[data$Type=="stat_high" & data$Item=="11"] <- "112"
  data$res.equation[data$Type=="percep_low" & data$Item=="12"] <- "35"
  data$res.equation[data$Type=="percep_high" & data$Item=="12"] <- "60"
  data$res.equation[data$Type=="stat_low" & data$Item=="12"] <- "15"
  data$res.equation[data$Type=="stat_high" & data$Item=="12"] <- "10"
  data$res.equation[data$Type=="percep_low" & data$Item=="13"] <- "7"
  data$res.equation[data$Type=="percep_high" & data$Item=="13"] <- "39"
  data$res.equation[data$Type=="stat_low" & data$Item=="13"] <- "34"
  data$res.equation[data$Type=="stat_high" & data$Item=="13"] <- "99"
  data$res.equation[data$Type=="percep_low" & data$Item=="14"] <- "9"
  data$res.equation[data$Type=="percep_high" & data$Item=="14"] <- "15"
  data$res.equation[data$Type=="stat_low" & data$Item=="14"] <- "105"
  data$res.equation[data$Type=="stat_high" & data$Item=="14"] <- "16"
  data$res.equation[data$Type=="percep_low" & data$Item=="15"] <- "56"
  data$res.equation[data$Type=="percep_high" & data$Item=="15"] <- "70"
  data$res.equation[data$Type=="stat_low" & data$Item=="15"] <- "63"
  data$res.equation[data$Type=="stat_high" & data$Item=="15"] <- "72"
  data$res.equation[data$Type=="percep_low" & data$Item=="16"] <- "16"
  data$res.equation[data$Type=="percep_high" & data$Item=="16"] <- "72"
  data$res.equation[data$Type=="stat_low" & data$Item=="16"] <- "56"
  data$res.equation[data$Type=="stat_high" & data$Item=="16"] <- "56"
  data$res.equation[data$Type=="percep_low" & data$Item=="17"] <- "17"
  data$res.equation[data$Type=="percep_high" & data$Item=="17"] <- "12"
  data$res.equation[data$Type=="stat_low" & data$Item=="17"] <- "60"
  data$res.equation[data$Type=="stat_high" & data$Item=="17"] <- "6"
  data$res.equation[data$Type=="percep_low" & data$Item=="18"] <- "25"
  data$res.equation[data$Type=="percep_high" & data$Item=="18"] <- "81"
  data$res.equation[data$Type=="stat_low" & data$Item=="18"] <- "66"
  data$res.equation[data$Type=="stat_high" & data$Item=="18"] <- "105"
  data$res.equation[data$Type=="percep_low" & data$Item=="19"] <- "50"
  data$res.equation[data$Type=="percep_high" & data$Item=="19"] <- "60"
  data$res.equation[data$Type=="stat_low" & data$Item=="19"] <- "48"
  data$res.equation[data$Type=="stat_high" & data$Item=="19"] <- "96"
  data$res.equation[data$Type=="percep_low" & data$Item=="20"] <- "24"
  data$res.equation[data$Type=="percep_high" & data$Item=="20"] <- "65"
  data$res.equation[data$Type=="stat_low" & data$Item=="20"] <- "117"
  data$res.equation[data$Type=="stat_high" & data$Item=="20"] <- "28"
  data$cor.equation <- NA
  data$cor.equation <- ifelse(data$rep.equation == data$res.equation, 0.5, -0.5)
}

#controle filler mathématique
{
  FM$res.equation <- NA
  
  FM$res.equation[FM$Item=="21"] <- "13"
  FM$res.equation[FM$Item=="22"] <- "12"
  FM$res.equation[FM$Item=="23"] <- "9"
  FM$res.equation[FM$Item=="24"] <- "28"
  FM$res.equation[FM$Item=="25"] <- "4"
  FM$res.equation[FM$Item=="26"] <- "24"
  FM$res.equation[FM$Item=="27"] <- "7"
  FM$res.equation[FM$Item=="28"] <- "21"
  FM$res.equation[FM$Item=="29"] <- "25"
  FM$res.equation[FM$Item=="30"] <- "15"
  
  FM$cor.equation <- NA
  FM$cor.equation <- ifelse(FM$rep.equation == FM$res.equation, 0.5, -0.5)
}

#ajout completion correct
{
  data$NP1.completion <- NA
  data$nbr.completion <- NA  
  
  data$NP1.completion[data$Item=="1"] <-  "sg"
  data$NP1.completion[data$Item=="2"] <-  "pl"
  data$NP1.completion[data$Item=="3"] <-  "pl"
  data$NP1.completion[data$Item=="4"] <-  "pl"
  data$NP1.completion[data$Item=="5"] <-  "sg"
  data$NP1.completion[data$Item=="6"] <-  "pl"
  data$NP1.completion[data$Item=="7"] <-  "sg"
  data$NP1.completion[data$Item=="8"] <-  "pl"
  data$NP1.completion[data$Item=="9"] <-  "pl"
  data$NP1.completion[data$Item=="10"] <- "sg"
  data$NP1.completion[data$Item=="11"] <- "pl"
  data$NP1.completion[data$Item=="12"] <- "pl"
  data$NP1.completion[data$Item=="13"] <- "pl"
  data$NP1.completion[data$Item=="14"] <- "pl"
  data$NP1.completion[data$Item=="15"] <- "sg"
  data$NP1.completion[data$Item=="16"] <- "pl"
  data$NP1.completion[data$Item=="17"] <- "pl"
  data$NP1.completion[data$Item=="18"] <- "sg"
  data$NP1.completion[data$Item=="19"] <- "sg"
  data$NP1.completion[data$Item=="20"] <- "sg"
}

#annotation completion 
{
  data$nbr.completion[grep("ent",data$completion)] <- "pl"
  data$nbr.completion[grep("ont",data$completion)] <- "pl"
  data$nbr.completion[grep("Ont",data$completion)] <- "pl"
  data[is.na(data)] <- "sg"
  #ont
  data$nbr.completion[data$Item=="11" & data$id=="5"] <- "sg" #monte
  data$nbr.completion[data$Item=="11" & data$id=="9"] <- "sg" #monte
  data$nbr.completion[data$Item=="20" & data$id=="10"] <- "sg" #continuer
  data$nbr.completion[data$Item=="1" & data$id=="10"] <- "sg" #contrat
  data$nbr.completion[data$Item=="5" & data$id=="10"] <- "sg" #racontait
  data$nbr.completion[data$Item=="1" & data$id=="12"] <- "sg" #continuer
  data$nbr.completion[data$Item=="1" & data$id=="14"] <- "sg" #contrat
  data$nbr.completion[data$Item=="18" & data$id=="15"] <- "sg" #contestataire
  data$nbr.completion[data$Item=="11" & data$id=="18"] <- "sg" #monta
  data$nbr.completion[data$Item=="3" & data$id=="19"] <- "sg" #contr
  data$nbr.completion[data$Item=="1" & data$id=="28"] <- "sg" #contrat
  data$nbr.completion[data$Item=="10" & data$id=="32"] <- "sg" #racontait
  data$nbr.completion[data$Item=="4" & data$id=="32"] <- "sg" #rencontrer
  data$nbr.completion[data$Item=="18" & data$id=="34"] <- "sg" #contraignant
  data$nbr.completion[data$Item=="5" & data$id=="63"] <- "sg" #racontait
  data$nbr.completion[data$Item=="1" & data$id=="76"] <- "sg" #contrat
  data$nbr.completion[data$Item=="20" & data$id=="80"] <- "sg" #montre
  
  #ent
  data$nbr.completion[data$Item=="2" & data$id=="8"] <- "sg" #entre
  data$nbr.completion[data$Item=="20" & data$id=="10"] <- "sg" #entrainement
  data$nbr.completion[data$Item=="16" & data$id=="12"] <- "sg" #moment
  data$nbr.completion[data$Item=="15" & data$id=="12"] <- "sg" #entrain
  data$nbr.completion[data$Item=="9" & data$id=="13"] <- "sg" #gentil
  data$nbr.completion[data$Item=="3" & data$id=="14"] <- "sg" #documentaire
  data$nbr.completion[data$Item=="20" & data$id=="14"] <- "sg" #entraine
  data$nbr.completion[data$Item=="5" & data$id=="14"] <- "sg" #déroulement
  data$nbr.completion[data$Item=="9" & data$id=="15"] <- "sg" #vient
  data$nbr.completion[data$Item=="18" & data$id=="16"] <- "sg" #representait
  data$nbr.completion[data$Item=="17" & data$id=="16"] <- "sg" #inventé
  data$nbr.completion[data$Item=="12" & data$id=="18"] <- "sg" #entretien
  data$nbr.completion[data$Item=="17" & data$id=="18"] <- "sg" #recemment
  data$nbr.completion[data$Item=="13" & data$id=="22"] <- "sg" #menti
  data$nbr.completion[data$Item=="18" & data$id=="23"] <- "sg" #represente
  data$nbr.completion[data$Item=="6" & data$id=="23"] <- "sg" #somptueusement
  data$nbr.completion[data$Item=="13" & data$id=="24"] <- "sg" #gouvernement
  data$nbr.completion[data$Item=="12" & data$id=="24"] <- "sg" #entreprise
  data$nbr.completion[data$Item=="6" & data$id=="24"] <- "sg" #recemment
  data$nbr.completion[data$Item=="18" & data$id=="25"] <- "sg" #fierement
  data$nbr.completion[data$Item=="3" & data$id=="25"] <- "sg" #entraine
  data$nbr.completion[data$Item=="7" & data$id=="25"] <- "sg" #dernierement
  data$nbr.completion[data$Item=="9" & data$id=="25"] <- "sg" #récemment
  data$nbr.completion[data$Item=="4" & data$id=="27"] <- "sg" #chaleuresement
  data$nbr.completion[data$Item=="3" & data$id=="29"] <- "sg" #entraine
  data$nbr.completion[data$Item=="9" & data$id=="31"] <- "sg" #entreprise
  data$nbr.completion[data$Item=="15" & data$id=="31"] <- "sg" #constamment
  data$nbr.completion[data$Item=="9" & data$id=="32"] <- "sg" #entretenir
  data$nbr.completion[data$Item=="1" & data$id=="32"] <- "sg" #clients
  data$nbr.completion[data$Item=="7" & data$id=="32"] <- "sg" #batiment
  data$nbr.completion[data$Item=="10" & data$id=="33"] <- "sg" #souvent
  data$nbr.completion[data$Item=="12" & data$id=="33"] <- "sg" #entreprise
  data$nbr.completion[data$Item=="19" & data$id=="33"] <- "sg" #patients
  data$nbr.completion[data$Item=="1" & data$id=="35"] <- "sg" #present
  data$nbr.completion[data$Item=="17" & data$id=="37"] <- "sg" #prealablement
  data$nbr.completion[data$Item=="13" & data$id=="37"] <- "sg" #argent
  data$nbr.completion[data$Item=="11" & data$id=="38"] <- "sg" #moment
  data$nbr.completion[data$Item=="18" & data$id=="39"] <- "sg" #represente
  data$nbr.completion[data$Item=="20" & data$id=="40"] <- "sg" #comment
  data$nbr.completion[data$Item=="1" & data$id=="41"] <- "sg" #sent
  data$nbr.completion[data$Item=="3" & data$id=="42"] <- "sg" #entraine
  data$nbr.completion[data$Item=="12" & data$id=="44"] <- "sg" #detournement
  data$nbr.completion[data$Item=="11" & data$id=="48"] <- "sg" #attention
  data$nbr.completion[data$Item=="12" & data$id=="48"] <- "sg" #agissement
  data$nbr.completion[data$Item=="10" & data$id=="49"] <- "sg" #quotidiennement
  data$nbr.completion[data$Item=="5" & data$id=="50"] <- "sg" #mentale
  data$nbr.completion[data$Item=="1" & data$id=="51"] <- "sg" #regulierement
  data$nbr.completion[data$Item=="13" & data$id=="51"] <- "sg" #placements
  data$nbr.completion[data$Item=="4" & data$id=="52"] <- "sg" #gentille
  data$nbr.completion[data$Item=="13" & data$id=="52"] <- "sg" #argent
  data$nbr.completion[data$Item=="20" & data$id=="52"] <- "sg" #visiblement
  data$nbr.completion[data$Item=="13" & data$id=="53"] <- "sg" #vient de battre son record.
  data$nbr.completion[data$Item=="9" & data$id=="53"] <- "sg" #entreprise
  data$nbr.completion[data$Item=="11" & data$id=="56"] <- "sg" #a fait parler d'elle rÃ©cemment.
  data$nbr.completion[data$Item=="6" & data$id=="56"] <- "sg" #l'a Ã©mue aux larmes lors de sa reprÃ©sentation.
  data$nbr.completion[data$Item=="1" & data$id=="56"] <- "sg" #les embobinait et volait leur argent.
  data$nbr.completion[data$Item=="12" & data$id=="56"] <- "sg" #gÃsre avec talent son entreprise.
  data$nbr.completion[data$Item=="13" & data$id=="57"] <- "sg" #A blanchi de lâargent 
  data$nbr.completion[data$Item=="10" & data$id=="58"] <- "sg" #Est trÃss gentil
  data$nbr.completion[data$Item=="12" & data$id=="64"] <- "sg" #dirige cette entreprise
  data$nbr.completion[data$Item=="12" & data$id=="65"] <- "sg" #entreprise
  data$nbr.completion[data$Item=="11" & data$id=="68"] <- "sg" #a inventÃ© la robe-pantalon
  data$nbr.completion[data$Item=="19" & data$id=="71"] <- "sg" #- il manque un \"e\" Ã fiancÃ©e- vient de se faire virer.
  data$nbr.completion[data$Item=="2" & data$id=="71"] <- "sg" #est accusÃ© de harcÃslement sexuel.
  data$nbr.completion[data$Item=="12" & data$id=="73"] <- "sg" #a inventÃ© ce sport
  data$nbr.completion[data$Item=="10" & data$id=="75"] <- "sg" #Est souvent absent
  data$nbr.completion[data$Item=="11" & data$id=="75"] <- "sg" #A jouer dans un film recent
  data$nbr.completion[data$Item=="15" & data$id=="76"] <- "sg" #Volait de lâargent
  data$nbr.completion[data$Item=="2" & data$id=="77"] <- "sg" #argent
  data$nbr.completion[data$Item=="20" & data$id=="78"] <- "sg" #gentil
  data$nbr.completion[data$Item=="2" & data$id=="79"] <- "sg" #le soutient
  data$nbr.completion[data$Item=="6" & data$id=="79"] <- "sg" #a fabriquÃ© ses instruments
  data$nbr.completion[data$Item=="14" & data$id=="79"] <- "sg" #alimentaire
  data$nbr.completion[data$Item=="12" & data$id=="80"] <- "sg" #dirige son entreprise.
  data$nbr.completion[data$Item=="3" & data$id=="80"] <- "sg" #vient de battre son record.
  data$nbr.completion[data$Item=="17" & data$id=="82"] <- "sg" #vient
  data$nbr.completion[data$Item=="14" & data$id=="84"] <- "sg" #argent
  data$nbr.completion[data$Item=="12" & data$id=="85"] <- "sg" #
  data$nbr.completion[data$Item=="6" & data$id=="86"] <- "sg" #
  data$nbr.completion[data$Item=="1" & data$id=="88"] <- "sg" #
  data$nbr.completion[data$Item=="8" & data$id=="89"] <- "sg" #
  data$nbr.completion[data$Item=="18" & data$id=="90"] <- "sg" #
  data$nbr.completion[data$Item=="19" & data$id=="93"] <- "sg" #
  data$nbr.completion[data$Item=="14" & data$id=="96"] <- "sg" #
  data$nbr.completion[data$Item=="12" & data$id=="97"] <- "sg" #
  data$nbr.completion[data$Item=="15" & data$id=="97"] <- "sg" #
  data$nbr.completion[data$Item=="8" & data$id=="99"] <- "sg" #
  data$nbr.completion[data$Item=="2" & data$id=="99"] <- "sg" #
  data$nbr.completion[data$Item=="3" & data$id=="101"] <- "sg" #
  data$nbr.completion[data$Item=="11" & data$id=="101"] <- "sg" #
  data$nbr.completion[data$Item=="3" & data$id=="102"] <- "sg" #
  data$nbr.completion[data$Item=="7" & data$id=="103"] <- "sg" #
  data$nbr.completion[data$Item=="20" & data$id=="103"] <- "sg" #
  data$nbr.completion[data$Item=="18" & data$id=="103"] <- "sg" #
  data$nbr.completion[data$Item=="12" & data$id=="104"] <- "sg" #
  data$nbr.completion[data$Item=="11" & data$id=="104"] <- "sg" #
  data$nbr.completion[data$Item=="20" & data$id=="105"] <- "sg" #
  data$nbr.completion[data$Item=="11" & data$id=="106"] <- "sg" #
  data$nbr.completion[data$Item=="13" & data$id=="106"] <- "sg" #
  data$nbr.completion[data$Item=="12" & data$id=="106"] <- "sg" #
  data$nbr.completion[data$Item=="4" & data$id=="106"] <- "sg" #
  data$nbr.completion[data$Item=="9" & data$id=="106"] <- "sg" #
  data$nbr.completion[data$Item=="18" & data$id=="107"] <- "sg" #
  data$nbr.completion[data$Item=="20" & data$id=="108"] <- "sg" #
  data$nbr.completion[data$Item=="20" & data$id=="109"] <- "sg" #
  data$nbr.completion[data$Item=="15" & data$id=="111"] <- "sg" #
  data$nbr.completion[data$Item=="13" & data$id=="111"] <- "sg" #
  data$nbr.completion[data$Item=="1" & data$id=="111"] <- "sg" #
  data$nbr.completion[data$Item=="2" & data$id=="112"] <- "sg" #
  data$nbr.completion[data$Item=="11" & data$id=="113"] <- "sg" #
  data$nbr.completion[data$Item=="13" & data$id=="115"] <- "sg" #
  data$nbr.completion[data$Item=="10" & data$id=="116"] <- "sg" #
  data$nbr.completion[data$Item=="18" & data$id=="116"] <- "sg" #
  
  
  data$cor.completion <- NA
  data$cor.completion <- ifelse(data$NP1.completion == data$nbr.completion, 0.5, -0.5)
}

#correction equation
{
  data$rep.equation[data$Item=="14" & data$id=="33"] <- "105"
  data$cor.equation[data$Item=="11" & data$id=="36"] <- "NA"
  data$cor.equation[data$Item=="4" & data$id=="74"] <- "NA"
}

#correction completion invalide
#check id 49 (baisé)
{
  data$cor.completion[data$Item=="9" & data$id=="80"] <- "NA"
  data$cor.completion[data$Item=="4" & data$id=="60"] <- "NA"
  data$cor.completion[data$Item=="1" & data$id=="60"] <- "NA"
  data$cor.completion[data$Item=="2" & data$id=="46"] <- "NA"
  data$cor.completion[data$Item=="10" & data$id=="46"] <- "NA"
  data$cor.completion[data$Item=="4" & data$id=="46"] <- "NA"
  data$cor.completion[data$Item=="18" & data$id=="41"] <- "NA"
  data$cor.completion[data$Item=="12" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="17" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="19" & data$id=="45"] <- "NA"
  data$cor.completion[data$Item=="15" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="4" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="19" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="10" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="2" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="9" & data$id=="42"] <- "NA"
  data$cor.completion[data$Item=="20" & data$id=="37"] <- "NA"
  data$cor.completion[data$Item=="16" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="5" & data$id=="35"] <- "NA"
  data$cor.completion[data$Item=="1" & data$id=="47"] <- "NA"
  data$cor.completion[data$Item=="17" & data$id=="46"] <- "NA"
  data$cor.completion[data$Item=="11" & data$id=="53"] <- "NA"
  data$cor.completion[data$Item=="7" & data$id=="46"] <- "NA"
  data$cor.completion[data$Item=="18" & data$id=="46"] <- "NA"
  data$cor.completion[data$Item=="17" & data$id=="33"] <- "NA"
  data$cor.completion[data$Item=="13" & data$id=="35"] <- "NA"
  data$nbr.completion[data$Item=="1" & data$id=="96"] <- "NA" 
  data$nbr.completion[data$Item=="4" & data$id=="98"] <- "NA" 
  data$nbr.completion[data$Item=="20" & data$id=="101"] <- "sg" #
  data$nbr.completion[data$Item=="16" & data$id=="115"] <- "sg" #
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
  
}  

{
data$halfsession <- ifelse(data$helpsession < 11, 0.5, -0.5)

#scindage condition
{
  data$typeverbe <- NA
  data$prompt <- NA
  data$typeverbe[grep("percep",data$Type)] <- "percep"
  data$typeverbe[grep("stat",data$Type)] <- "stat"
  data$prompt[grep("low",data$Type)] <- "high"
  data$prompt[grep("high",data$Type)] <- "low"
  data$vtype <- NA
  data$equation <- NA
  data$vtype <- ifelse(data$typeverbe == "percep", 0.5, -0.5)
  data$equation <- ifelse(data$prompt =="low", 0.5, -0.5)
}

#exclusions temps de réponse
{
  data$RT.equation <- as.numeric(data$RT.equation)
  moy.eq <- mean(data$RT.equation)
  ecart.eq <- sd(data$RT.equation)
  
  data$RT.completion <- as.numeric(data$RT.completion)
  moy.comp <- mean(data$RT.completion)
  ecart.comp <- sd(data$RT.completion)
  
  exclu.eq <- moy.eq+2*ecart.eq
  exclu.comp <- moy.comp+2*ecart.comp
  
  data$RT.equation[data$RT.equation > exclu.eq] <- "NA"
  data$RT.completion[data$RT.completion > exclu.comp] <- "NA"
}

#drop na
library(dplyr)
{
  data <- data %>% 
    filter(!grepl('NA', RT.equation))
  data <- data %>% 
    filter(!grepl('NA', RT.completion))
  data <- data %>% 
    filter(!grepl('NA', cor.equation))
  data <- data %>% 
    filter(!grepl('NA', cor.completion))
}

data$NombreNP1 <- ifelse(data$NP1.completion == "pl", 0.5, -0.5)

}

#graph
require(sciplot)
data$comp.graph <- NA
data$comp.graph <- ifelse(data$cor.completion == "0.5", 1, 0)
bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type, 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data)
dev.print(device = png, file = "1a.png", width = 800)

mean(data$comp.graph[data$typeverbe == "percep" & data$prompt == "high"])
mean(data$comp.graph[data$typeverbe == "percep" & data$prompt == "low"])
mean(data$comp.graph[data$typeverbe == "stat" & data$prompt == "high"])
mean(data$comp.graph[data$typeverbe == "stat" & data$prompt == "low"])

#ajout age
age <- subset(participants, Type!="practice" & Type!="FM" & Field.name!="nationality" & Field.name!="activity" & Field.name!="birth" & Field.name!="L1" & Field.name!="consent" & Field.name!="gender" & Field.name!="academics")
age$rep.equation=as.numeric(age$rep.equation)
age.median <- median(age$rep.equation)
agedessusmedian <- subset(age, age$rep.equation >= age.median)
agedessousmedian <- subset(age, age$rep.equation < age.median)



{
  data$age <- NA
  age$Time.results.were.received <- NULL
  age$Controller.name <- NULL
  age$Item.number <- NULL
  age$Element.number <- NULL
  age$Item <- NULL
  age$Type <- NULL
  age$Field.name <- NULL
  age$RT.equation <- NULL
  age$completion <- NULL
  age$RT.completion <- NULL
  names(age) <- c("V1", "age", "id")
  age$V1 <- NULL
  data <- merge(data, age, by="id")
}

data$age_cent <- scale(data$age.y, scale=T, center=T)

write.csv(data, file = "datacomp1.csv")

################################################################

data$RT.equation <- as.numeric(data$RT.equation)
median.RT.equation <- median(data$RT.equation)
data.slow <- subset(data, data$RT.equation > median.RT.equation)
data.fast <- subset(data, data$RT.equation < median.RT.equation)

bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type (Overall, fast equation), 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.fast)
dev.print(device = png, file = "1a-fast.png", width = 800)

  mean(data.fast$comp.graph[data.fast$typeverbe == "percep" & data.fast$prompt == "high"])
  mean(data.fast$comp.graph[data.fast$typeverbe == "percep" & data.fast$prompt == "low"])
  mean(data.fast$comp.graph[data.fast$typeverbe == "stat" & data.fast$prompt == "high"])
  mean(data.fast$comp.graph[data.fast$typeverbe == "stat" & data.fast$prompt == "low"])

bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type (Overall, slow equation), 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=data.slow)
dev.print(device = png, file = "1a-slow.png", width = 800)

  mean(data.slow$comp.graph[data.slow$typeverbe == "percep" & data.slow$prompt == "high"])
  mean(data.slow$comp.graph[data.slow$typeverbe == "percep" & data.slow$prompt == "low"])
  mean(data.slow$comp.graph[data.slow$typeverbe == "stat" & data.slow$prompt == "high"])
  mean(data.slow$comp.graph[data.slow$typeverbe == "stat" & data.slow$prompt == "low"])


################################################################

#scission age
datadessous <- data[ ! data$id %in% agedessusmedian$id, ]
datadessus <- data[ ! data$id %in% agedessousmedian$id, ]
#dessus mediane
bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type (Upper age), 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datadessus)
dev.print(device = png, file = "1a-upper.png", width = 800)

  mean(datadessus$comp.graph[datadessus$typeverbe == "percep" & datadessus$prompt == "high"])
  mean(datadessus$comp.graph[datadessus$typeverbe == "percep" & datadessus$prompt == "low"])
  mean(datadessus$comp.graph[datadessus$typeverbe == "stat" & datadessus$prompt == "high"])
  mean(datadessus$comp.graph[datadessus$typeverbe == "stat" & datadessus$prompt == "low"])

#dessous mediane
bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type (Lower age), 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datadessous)
dev.print(device = png, file = "1a-lower.png", width = 800)

  mean(datadessous$comp.graph[datadessous$typeverbe == "percep" & datadessous$prompt == "high"])
  mean(datadessous$comp.graph[datadessous$typeverbe == "percep" & datadessous$prompt == "low"])
  mean(datadessous$comp.graph[datadessous$typeverbe == "stat" & datadessous$prompt == "high"])
  mean(datadessous$comp.graph[datadessous$typeverbe == "stat" & datadessous$prompt == "low"])

################################################################

datadessus$RT.equation <- as.numeric(datadessus$RT.equation)
mediandessus.RT.equation <- median(datadessus$RT.equation)
datadessus.slow <- subset(datadessus, datadessus$RT.equation > median.RT.equation)
datadessus.fast <- subset(datadessus, datadessus$RT.equation < median.RT.equation)

bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type (Upper age, fast equation), 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datadessus.fast)
dev.print(device = png, file = "1a-upper-fast.png", width = 800)

  mean(datadessus.fast$comp.graph[datadessus.fast$typeverbe == "percep" & datadessus.fast$prompt == "high"])
  mean(datadessus.fast$comp.graph[datadessus.fast$typeverbe == "percep" & datadessus.fast$prompt == "low"])
  mean(datadessus.fast$comp.graph[datadessus.fast$typeverbe == "stat" & datadessus.fast$prompt == "high"])
  mean(datadessus.fast$comp.graph[datadessus.fast$typeverbe == "stat" & datadessus.fast$prompt == "low"])

bargraph.CI(x.factor=typeverbe, group= prompt,response=comp.graph, col=c("tomato", "dark blue"), xlab="Verb type (Upper age, slow equation), 1a",ylab="NP1 Attachment %",legend=TRUE,  x.leg=3,y.leg=0.8 , cex.leg=1.3, cex.names=1, cex.lab = 1.5, ylim = c(0,1), data=datadessus.slow)
dev.print(device = png, file = "1a-upper-slow.png", width = 800)

  mean(datadessus.slow$comp.graph[datadessus.slow$typeverbe == "percep" & datadessus.slow$prompt == "high"])
  mean(datadessus.slow$comp.graph[datadessus.slow$typeverbe == "percep" & datadessus.slow$prompt == "low"])
  mean(datadessus.slow$comp.graph[datadessus.slow$typeverbe == "stat" & datadessus.slow$prompt == "high"])
  mean(datadessus.slow$comp.graph[datadessus.slow$typeverbe == "stat" & datadessus.slow$prompt == "low"])

################################################################


#modèle linéaire
library(lme4)
library(car)
require(lmerTest)

data$cor.completion <- as.factor(data$cor.completion)
data$Item=as.factor(data$Item)
data$id=as.factor(data$id)

m3=glmer(cor.completion ~ vtype * equation + (vtype||id) + (1|Item),data=data,family=binomial)
#m3=glmer(cor.completion ~ vtype * equation * halfsession * NombreNP1 + (vtype||id) + (1|Item),data=data,family=binomial)
summary(m3)

#test avec age en continu
data$age.y <- as.numeric(data$age.y)
m3=glmer(cor.completion ~ vtype * equation * age_cent + (vtype||id) + (1|Item),data=data,family=binomial)
summary(m3)


#################################################

data$coreq <- NA
data$coreq <- ifelse(data$cor.equation == 0.5, 1, 0)
mean(data$coreq)
