## Questionnaire handed to 2015 reproducible workshop participants

## workshop.value: how valuable was today's workshop, 1-5
## Other columns: how interested would you be in a workshop on this subject?,
## 1= definitely would attend, 2= might attend, 3 = not interested.

library(plyr)

qst <- read.csv("questionnaire-2015.csv")

# invert scores so higher is better:
inv <-  function(x) { abs(x-3) }
nqst <- cbind(qst$workshop.value, colwise(inv)(qst[,2:7]))

# which proposed workshop had most votes?
colwise(sum, na.rm=TRUE)(nqst[,2:7])

##   tidyr ggplot2 git bash python markup
## 1    18      23  21   15     11     18
# so, by the votes,: ggplot, then git, then tidyr or markup

