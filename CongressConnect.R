library(yaml)
# File that will connect the social media data to specific congressmen 
# get the awesome congressional Data from https://github.com/unitedstates/congress-legislators

#load the YAML

congData <- yaml.load_file("congress-legislators/legislators-current.yaml")

# initiate first Value and estalish all possible values for binding

y <- as.data.frame.list(c(congData[[1]]$name, congData[[1]]$bio, congData[[1]]$terms, congData[[1]]$id))
y <- list(y$official_full, y$gender, y$party, y$state, y$birthday, y$govtrack)
names(y) <- c('official_full', 'gender', 'party', 'state', 'birthday', 'govtrack')
# its a for statement
w <- NULL
x <- 1
for (i in 1:length(congData)) {
  z <- as.data.frame.list(c(congData[[x]]$name, congData[[x]]$bio, congData[[x]]$terms, congData[[x]]$id))
  z <- list(z$official_full, z$gender, z$party, z$state, z$birthday, z$govtrack)
  names(z) <- c('official_full', 'gender', 'party', 'state', 'birthday', 'govtrack')
  w <- merge(w, z, all = T)
  
  x <- x+1
}
w <- unique.matrix(w)

write.csv(w, "congressConnect.csv")

