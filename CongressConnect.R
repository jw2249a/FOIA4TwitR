library(yaml)
# File that will connect the social media data to specific congressmen 
# get the awesome congressional Data from https://github.com/unitedstates/congress-legislators

#load the YAML

congData <- yaml.load_file("~/GitHub/congress-legislators/legislators-current.yaml")

# initiate first Value and estalish all possible values for binding

y <- as.data.frame.list(c(congData[[1]]$name, congData[[1]]$bio, congData[[1]]$terms))
y <- data.frame(y$official_full, y$gender, y$party, y$state, y$birthday)

# its a for statement

x <- 1
for (i in congData) {
  z <- as.data.frame.list(c(congData[[x]]$name, congData[[x]]$bio, congData[[x]]$terms))
  z <- data.frame(z$official_full, z$gender, z$party, z$state, z$birthday)
  y <- merge(y, z, all = TRUE)
  
  x <- x+1
}
y <- y[, 1:5]
names(y) <- c('official_full', 'gender', 'party', 'state', 'birthday')
write.csv(y, "congressConnect.csv")

