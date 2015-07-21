install.packages("reshape2")
install.packages("dplyr")
install.packages("ggplot2")

library(reshape2)
library(dplyr)
library(ggplot2)

acc <- read.csv("요일별_시간대별_교통사고.csv", header=T)
acc

# 목표 : 요일별로 교통사고 사망자의 시간별 분포를 살펴보자!





### step 1. 필요없는 행을 지우고, 필요한 행만 추출하자.
# tip1) filter(데이터, 행조건, ...)
# tip2) 데이터 %>% filter(행조건, ...)
acc <- filter(acc, 구분=="사망자수")
acc
acc <- filter(acc, 요일!="합계")
acc

### step 2. 필요없는 열을 지우자.
# tip1) select(데이터, 열이름, -열이름,...)
# tip2) 데이터 %>% select(열이름, -열이름,...)
acc <- select(acc, -구분, -합계)
acc



### step 3. 목적에 맞게 데이터를 롱포맷으로 변환하자.
# tip) melt(데이터, id= ~~, measured= ~~ )
acc_long <- melt(acc, id="요일")
acc_long


### step 4. 데이터를 시각화하자.
# tip) ggplot() + geom_xx()
ggplot(data=acc_long, aes(x=variable, y=value))+geom_point()
ggplot(data=acc_long, aes(x=variable, y=value))+geom_line()

ggplot(data=acc_long, aes(x=variable, y=value, group=요일))+geom_line()
ggplot(data=acc_long, aes(x=variable, y=value, group=요일, colour=요일))+geom_line(aes(size=3))







