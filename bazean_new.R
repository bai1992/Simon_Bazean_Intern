# bazean
setwd("~/Downloads")
ef<-read.table('EagleFord_Well Meta.txt',sep="\t",fileEncoding="UCS-2LE",header = TRUE,fill = TRUE)
options(scipen=999)
#View(ef)

library(dplyr)

## For the first part, I use pipe and summarise to get the sum value of each 'index'.
ef_sum<-ef %>% 
  group_by(operator_name) %>% 
  summarise(sum_oil=sum(cum_oil)) %>% 
  na.omit()
#ef_sum
ef_sum[1:10,]
## For the second part, similarily, I use mean to get the average value.
ef_avg<-ef %>% 
  group_by(well_name) %>% 
  summarise(avg_oil=mean(cum_oil)) %>% 
  na.omit()
#ef_avg
ef_avg[1:10,]

## For the last part, I will first find the unique operator and well combinations;
## then, I will count the number of wells in each operator and remove the total value;
## Last, I use left join to merge the data with wells numbers in each operator and 
## the sum_oil data to get the average oil drills of each well in each company.
uniq<-ef %>% 
  distinct(operator_name,well_name)
count<- uniq %>% 
  group_by(operator_name) %>% 
  summarise(count=n())
count<-count[-1,]

full<-left_join(x = ef_sum, y = count, by = "operator_name", all.x = TRUE)

most<-full %>% 
  mutate(avg=sum_oil/count) %>% 
  arrange(desc(avg))
most[1:10,]
## As it showed, the company "MOSBACHER PROD. CO.-TRANSCO EXP."  are likely to drill the most productive wells going forward.
## We can see that most top 10 only invested in 1 or some wells, this would increase risks.
## Therefore, I would like to say that "PLAINS EXPLORATION & PROD. CO." is more safe to invest to bring a big return, since
## it has more than 200 wells and still drill 170880.55 as number 6 in the ranking, which is pretty good.
