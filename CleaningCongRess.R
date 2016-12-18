library(stringr)
#Time to clean this filthy Data
#going to merge the files into a single directory

connectData <- read.csv('congressConnect.csv')[, 2:7]
twitData <- read.csv('congressSocial.csv')[, 2:3]
freeCAUC <- read.csv('HouseFreedomCaucus.csv', as.is = 2)[, 2]
pgresCAUC <- read.csv('ProgressiveCaucus.csv', header = F, as.is = 1)


# the 1-2 subset merge

connectData <- subset(unique(connectData), govtrack %in% twitData$govtrack)

mergedataset <- merge(twitData, connectData, by = 'govtrack')
  
mergedataset <- mergedataset[!is.na(mergedataset$twitter), ]
mergedataset$official_full <- as.character(mergedataset$official_full)
fixed <- function(p) paste(word(p, 1), word(p, -1))
mergedataset$official <- fixed(mergedataset$official_full)

# fixing so I can add the Progressive Caucus Members

w <- as.character(pgresCAUC$V1)
one <- word(w, 1)
two <- word(w, -1)
three <- paste(one, two)
l <- sapply(mergedataset$official, function(r) any(r %in% three)) 
mergedataset$ProgCauc <- as.numeric(l)

# manually fix mistransfers

mergedataset$ProgCauc[c(494, 253, 84, 470, 225, 132, 57, 128, 158, 417, 85, 153, 176, 214, 470, 152, 514)] <- "1"
mergedataset$ProgCauc[302] <- "0"

w <- as.character(freeCAUC)
one <- word(w, 1)
two <- word(w, -1)
three <- paste(one, two)
l <- sapply(mergedataset$official, function(r) any(r %in% three)) 
mergedataset$FreeCauc <- as.numeric(l)
sum(as.numeric(l))

mergedataset[c(519, 463, 186, 370, 446, 238), 10] <- 1
sum(as.numeric(mergedataset$FreeCauc))
write.csv(mergedataset, "CleaningCongRess.csv")
