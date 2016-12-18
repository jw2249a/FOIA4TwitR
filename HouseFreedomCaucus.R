library(XML)
library(stringr)
# import that freedom caucause and export that csv, like a boss
theurl <- "http://www.pewresearch.org/fact-tank/2015/10/20/house-freedom-caucus-what-is-it-and-whos-in-it/"
tables <- readHTMLTable(theurl)
n.rows <- unlist(lapply(tables, function(t) dim(t)[1]))
tables <- tables[[which.max(n.rows)]]
y <- as.character(tables$Member)
x <- 1
for (i in y) {
y[x] <- gsub(",", "", y[x])
fname <- word(y[x], -1)
lname <- word(y[x], 1)
y[x] <- paste(fname, lname)
x <- x+1  
}

write.csv(y, "HouseFreedomCaucus.csv")
