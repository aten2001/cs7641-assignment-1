# 3 by 12
# R Code to make histogram
postscript('./assets/wine_distribution.eps')
par(mfrow=c(4,3))
wh <- read.csv('./data/wine_data/winequality-white.csv')
re <- read.csv('./data/wine_data/winequality-red.csv')
to <- rbind(wh,re)
labels <- labels(wh)[[2]]

plothist <- function(data, column) {
  plotdata = data[column][,1]
  increment = (max(plotdata) - min(plotdata)) / 10
  breaks = c(min(plotdata):max(plotdata))
  hist(plotdata, main=paste("Distribution of ", column))
}

for (l in labels) {
  print(l);
  plothist(to, l)
} 
