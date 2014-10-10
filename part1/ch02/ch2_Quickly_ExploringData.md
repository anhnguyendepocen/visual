---
title: "ch2 Quickly Exploring Data"
output: html_document
---

# 2.1.creating a scatter(산점도)

```r
#기본함수들 보다 ggplot2를 사용하는게 통일된 인터페이스 사용에 좋다
#qplot()은 기본함수와 비슷한 문법, 이 보다 세련된 ggplot()의 그래프 사용 권장
#install.packages("ggplot2")


plot(mtcars$wt,mtcars$mpg)
```

![plot of chunk unnamed-chunk-1](figure/unnamed-chunk-1.png) 

```r
# mtcars = 1974년 미국의 Motor Trend 자료
# mpg = miles per gallon 마일당 연비
# wt  = weight 무게
```


```r
library(ggplot2)
qplot(mtcars$wt,mtcars$mpg)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-21.png) 

```r
qplot(wt, mpg, data=mtcars)
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-22.png) 

```r
ggplot(mtcars, aes(x=wt, y=mpg)) + geom_point()
```

![plot of chunk unnamed-chunk-2](figure/unnamed-chunk-23.png) 


# 2.2.Creating a Line Graph(라인그래프)

```r
#라인 
#32 - 212화씨온도(°F) = 0 - 100 섭씨온도(°C) 
plot(pressure$temperature, pressure$pressure, type="l")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-31.png) 

```r
plot(pressure$temperature, pressure$pressure, type="b")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-32.png) 

```r
plot(pressure$temperature, pressure$pressure, type="c")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-33.png) 

```r
#히스토그램
plot(pressure$temperature, pressure$pressure, type="h")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-34.png) 

```r
plot(pressure$temperature, pressure$pressure, type="n")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-35.png) 

```r
plot(pressure$temperature, pressure$pressure, type="o")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-36.png) 

```r
#포인트
plot(pressure$temperature, pressure$pressure, type="p")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-37.png) 

```r
#s
plot(pressure$temperature, pressure$pressure, type="s")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-38.png) 

```r
plot(pressure$temperature, pressure$pressure, type="l")
points(pressure$temperature, pressure$pressure)
lines(pressure$temperature, pressure$pressure/2, col="red")
lines(pressure$temperature, pressure$pressure/3, col="blue")
points(pressure$temperature, pressure$pressure/2, col="red")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-39.png) 

```r
qplot(pressure$temperature, pressure$pressure, geom="line")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-310.png) 

```r
#위랑같다
qplot(temperature, pressure, data=pressure, geom="line")
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-311.png) 

```r
ggplot(pressure, aes(x=temperature, y=pressure))+ geom_line()
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-312.png) 

```r
#라인과 포인트 함께
qplot(temperature, pressure, data=pressure, geom=c("line","point")) 
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-313.png) 

```r
ggplot(pressure, aes(x=temperature, y=pressure))+ geom_line()+geom_point() 
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-314.png) 


#2.3.Creating a Bar Graph(막대그래프)


```r
#BOD [biochemical oxygen demand] 생화학적산소요구량

barplot(BOD$demand, names.arg=BOD$Time)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-41.png) 

```r
table(mtcars$cyl)
```

```
## 
##  4  6  8 
## 11  7 14
```

```r
barplot(table(mtcars$cyl))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-42.png) 

```r
qplot(BOD$Time, BOD$demand, geom="bar", stat="identity")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-43.png) 

```r
qplot(factor(BOD$Time), BOD$demand, geom="bar", stat="identity")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-44.png) 

```r
qplot(mtcars$cyl)
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-45.png) 

```r
qplot(factor(mtcars$cyl))
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-46.png) 

```r
qplot(Time, demand, data=BOD, geom="bar", stat="identity")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-47.png) 

```r
ggplot(BOD, aes(x=Time, y=demand)) + geom_bar(stat="identity")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-48.png) 

```r
qplot(factor(cyl),data=mtcars)
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-49.png) 

```r
ggplot(mtcars, aes(x=factor(cyl))) + geom_bar()
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-410.png) 

#2.4.Creating a Histogram(히스토그램)


```r
hist(mtcars$mpg)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-51.png) 

```r
hist(mtcars$mpg,breaks=10)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-52.png) 

```r
qplot(mtcars$mpg)
```

```
## stat_bin: binwidth defaulted to range/30. Use 'binwidth = x' to adjust this.
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-53.png) 

```r
qplot(mpg, data=mtcars, binwidth=4)
```

![plot of chunk unnamed-chunk-5](figure/unnamed-chunk-54.png) 

#2.5.Creating a box plot(박스플롯)

```r
plot(ToothGrowth$supp, ToothGrowth$len)

 boxplot(len ~ supp, data= ToothGrowth)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-61.png) 

```r
qplot(ToothGrowth$supp, ToothGrowth$len, geom="boxplot")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-62.png) 

```r
ggplot(ToothGrowth, aes(x=supp, y=len))+ geom_boxplot()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-63.png) 

```r
ggplot(ToothGrowth, aes(x=supp, y=len))+ geom_line()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-64.png) 

```r
ggplot(ToothGrowth, aes(x=supp, y=len))+ geom_point()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-65.png) 

```r
qplot(supp,len, data=ToothGrowth, geom="boxplot")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-66.png) 

```r
ggplot(ToothGrowth, aes(x=supp, y=len))+ geom_point()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-67.png) 

```r
ggplot(ToothGrowth, aes(x=supp, y=len))+ geom_point()+ geom_boxplot()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-68.png) 

```r
ggplot(ToothGrowth, aes(x=supp, y=len))+ geom_boxplot()+ geom_point()
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-69.png) 

```r
qplot(interaction(ToothGrowth$supp, ToothGrowth$dose), ToothGrowth$len, geom="boxplot")
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-610.png) 

#2.6.Plotting a function Curve(함수곡선)


```r
curve(x^3-5*x,from=-4, to=4)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-71.png) 

```r
myfun<- function(xvar){ 1/(1+exp(-xvar+10))}
curve(myfun(x), from=0,to=20)
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-72.png) 

```r
#curve(1-myfun(x), add = TURE, col = "red")
#Error in curve(1 - myfun(x), add = TURE, col = "red") : 
#  object 'TURE' not found

curve(1-myfun(x),  col = "red")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-73.png) 

```r
qplot(c(0,20), fun=myfun, stat="function",geom="line")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-74.png) 

```r
qplot(c(0,20), fun=myfun, stat="function",geom="point")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-75.png) 

```r
ggplot(data.frame(x=c(0,20)),aes(x=x))+ stat_function(fun=myfun, geom="line")
```

![plot of chunk unnamed-chunk-7](figure/unnamed-chunk-76.png) 
