# bazean
setwd("~/Downloads")
ef<-read.table('EagleFord_Production.txt',sep="\t",fileEncoding="UCS-2LE",header = TRUE)
options(scipen=999)
View(ef)
##After viewing data, I think the 'index' should be treated as 'company code', since
## if we treat 'api' as 'company code', then there are too many companies which are impossible.
## I also use unique function to remove the duplicated values.
ef_new<-unique(ef[c("date", "index", "volume_oil_formation_bbls","volume_gas_formation_mcf")])
library(dplyr)

## For the first part, I use pipe and summarise to get the sum value of each 'index'.
ef_sum<-ef_new %>% 
  group_by(index) %>% 
  summarise(sum_oil=sum(volume_oil_formation_bbls))
ef_sum
## For the second part, similarily, I use mean to get the average value.
ef_avg<-ef_new %>% 
  group_by(index) %>% 
  summarise(avg_oil=mean(volume_oil_formation_bbls))
ef_avg

## I will use descending order to process the data from second part in order to
## select the one with most highest production per well.
oil_order<-ef_avg[order(-ef_avg$avg_oil),]
oil_order[1,]
## As it showed, the index 1 are likely to drill the most productive wells going forward.
