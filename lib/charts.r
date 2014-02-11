plothist <- function(below_average, above_average, column) {
  plotdata = table(data[column][,1])
  below_average_counts <- table(below_average[column][,1])
  above_average_counts <- table(above_average[column][,1])
  counts <- table(below_average_counts, above_average_counts)
  barplot(counts, main=paste("Distribution of ", column), col=c('green', 'red'))
}

# Graph for wine distribution of data
png('./assets/wine_distribution.png', 1024, 720)
par(mfrow=c(4,3))
wh <- read.csv('./data/wine_data/winequality-white.csv')
re <- read.csv('./data/wine_data/winequality-red.csv')
to <- rbind(wh,re)
above_average <- to[to$quality >= 6, ]
below_average <- to[to$quality < 6, ]
print("ZOMG")
labels <- labels(wh)[[2]]

for (l in labels) {
  print(l);
  plothist(below_average,above_average, l)
} 

plotmushroom <- function(poisonous, edible, column) {
  poisonous_counts <- table(poisonous[column][,1])
  edible_counts <- table(edible[column][,1])
  counts <- rbind(poisonous_counts, edible_counts)
  barplot(counts, col=c("green", "red"), main=column)
}

# Graphics for mushroom distribution of data
png('./assets/mushroom_distribution.png', 1024, 720)
par(mfrow=c(4,6))
mushroom <- read.csv('./data/agaricus-lepiota/agaricus-lepiota.csv')
poisonous <- mushroom[mushroom$class == 'p', ]
edible <- mushroom[mushroom$class == 'e', ]
labels <- labels(mushroom)[[2]]

for (l in labels) {
  plotmushroom(poisonous, edible, l)
} 
