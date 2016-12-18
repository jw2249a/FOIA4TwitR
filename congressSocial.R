library(yaml)

# get the awesome congressional Data from https://github.com/unitedstates/congress-legislators

#load the YAML

congSoc <- yaml.load_file("congress-legislators/legislators-social-media.yaml")

# initiate first Value and estalish all possible values for binding

y <- as.data.frame.list(c(congSoc[[1]]$id, congSoc[[1]]$social))
y$instagram_id <- "NA"
y$instagram <- "NA"
y$youtube <- "NA"

# its a for statement

x <- 2
for (i in 1:length(congSoc)) {
  
  # NULLS have problems in Dataframes so fixing it and replacing with NAs
  
  if (sum(grep("NULL", c(congSoc[[x]]$social))) > 0) {
  congSoc[[x]]$social[grep("NULL", c(congSoc[[x]]$social))] <- "NA"
  }
  
  y <- merge(y, as.data.frame.list(c(congSoc[[x]]$id, congSoc[[x]]$social)), all = TRUE)
  x <- x+1
}
y <- data.frame(y$govtrack, y$twitter)
names(y) <- c('govtrack', 'twitter')
write.csv(y, "congressSocial.csv")

