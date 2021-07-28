

############################ Dashboard Program ###################

require(RecordLinkage)

d1 <- readxl::read_xlsx("datal.xlsx") # Action Plan
head(d1)
d2 <- readxl::read_xlsx("datsub.xlsx") # Submitted ACtivity
d2 <- d2[, c(2, 3)]
d2

names(d2) <- c('Name2', "key Activity 2")
d2

d1 # ACtion Plan
d2 # SUbmitted REports


d2$Name2[d2$Name2 == "Shamsun Nahar Tanny"] <- "Kazi Shamsun Nahar Tanny"
d2$Name2[d2$Name2 == "Anamul Haque"] <- "Md. Anamul Haque"
d2$Name2[d2$Name2 == "Amdadul Haq Sharif"] <- "Amdadul Haq"


dat <- d1
dat$Submitted <- rep("no", nrow(dat))
dat$Match <- rep(0, nrow(dat))


for(i in 1:nrow(d1)){
  for(j in 1:nrow(d2)){
    if(d1$Name[i] == d2$Name2[j]  && (levenshteinSim(d1$`key Activity`[i], d2$`key Activity 2`[j] ) >= 0.50) ){
      dat$Submitted[i] <- "yes"
      dat$Match[i] <- levenshteinSim(d1$`key Activity`[i], d2$`key Activity 2`[j])
      break # If yes then break the j loop, do not look anymore in j loop
    }else{
      dat$Submitted[i] <- "no"
      dat$Match[i] <- levenshteinSim(d1$`key Activity`[i], d2$`key Activity 2`[j])
    }
  }
}

View(dat)

