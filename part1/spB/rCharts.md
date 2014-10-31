---
title: "rCharts"

output: slidy_presentation
---



## install & test

#install.packages("devtools")
#require(devtools)
#install_github('rCharts', 'ramnathv')


```r
require(rCharts)
```

```
## Loading required package: rCharts
```

```r
head(iris)
```

```
##   Sepal.Length Sepal.Width Petal.Length Petal.Width Species
## 1          5.1         3.5          1.4         0.2  setosa
## 2          4.9         3.0          1.4         0.2  setosa
## 3          4.7         3.2          1.3         0.2  setosa
## 4          4.6         3.1          1.5         0.2  setosa
## 5          5.0         3.6          1.4         0.2  setosa
## 6          5.4         3.9          1.7         0.4  setosa
```

```r
names(iris)
```

```
## [1] "Sepal.Length" "Sepal.Width"  "Petal.Length" "Petal.Width" 
## [5] "Species"
```

```r
names(iris) = gsub("\\.", "", names(iris))
names(iris)
```

```
## [1] "SepalLength" "SepalWidth"  "PetalLength" "PetalWidth"  "Species"
```


```r
require(rCharts)
require(knitr)
opts_chunk$set(comment = NA, results = "test", comment = NA, tidy = F)
r1 <- rPlot(SepalLength ~ SepalWidth | Species, data = iris, color = 'Species', type = 'point')
r1$save('test.html', cdn = TRUE)
r1$show('iframesrc', cdn = TRUE)
```

```
## <iframe srcdoc=' &lt;!doctype HTML&gt;
## &lt;meta charset = &#039;utf-8&#039;&gt;
## &lt;html&gt;
##   &lt;head&gt;
##     
##     &lt;script src=&#039;//ramnathv.github.io/rCharts/libraries/widgets/polycharts/js/polychart2.standalone.js&#039; type=&#039;text/javascript&#039;&gt;&lt;/script&gt;
##     
##     &lt;style&gt;
##     .rChart {
##       display: block;
##       margin-left: auto; 
##       margin-right: auto;
##       width: 800px;
##       height: 400px;
##     }  
##     &lt;/style&gt;
##     
##   &lt;/head&gt;
##   &lt;body &gt;
##     
##     &lt;div id = &#039;chart2e5967875327&#039; class = &#039;rChart polycharts&#039;&gt;&lt;/div&gt;    
##     &lt;script type=&#039;text/javascript&#039;&gt;
##     var chartParams = {
##  &quot;dom&quot;: &quot;chart2e5967875327&quot;,
## &quot;width&quot;:    800,
## &quot;height&quot;:    400,
## &quot;layers&quot;: [
##  {
##  &quot;x&quot;: &quot;SepalWidth&quot;,
## &quot;y&quot;: &quot;SepalLength&quot;,
## &quot;data&quot;: {
##  &quot;SepalLength&quot;: [    5.1,    4.9,    4.7,    4.6,      5,    5.4,    4.6,      5,    4.4,    4.9,    5.4,    4.8,    4.8,    4.3,    5.8,    5.7,    5.4,    5.1,    5.7,    5.1,    5.4,    5.1,    4.6,    5.1,    4.8,      5,      5,    5.2,    5.2,    4.7,    4.8,    5.4,    5.2,    5.5,    4.9,      5,    5.5,    4.9,    4.4,    5.1,      5,    4.5,    4.4,      5,    5.1,    4.8,    5.1,    4.6,    5.3,      5,      7,    6.4,    6.9,    5.5,    6.5,    5.7,    6.3,    4.9,    6.6,    5.2,      5,    5.9,      6,    6.1,    5.6,    6.7,    5.6,    5.8,    6.2,    5.6,    5.9,    6.1,    6.3,    6.1,    6.4,    6.6,    6.8,    6.7,      6,    5.7,    5.5,    5.5,    5.8,      6,    5.4,      6,    6.7,    6.3,    5.6,    5.5,    5.5,    6.1,    5.8,      5,    5.6,    5.7,    5.7,    6.2,    5.1,    5.7,    6.3,    5.8,    7.1,    6.3,    6.5,    7.6,    4.9,    7.3,    6.7,    7.2,    6.5,    6.4,    6.8,    5.7,    5.8,    6.4,    6.5,    7.7,    7.7,      6,    6.9,    5.6,    7.7,    6.3,    6.7,    7.2,    6.2,    6.1,    6.4,    7.2,    7.4,    7.9,    6.4,    6.3,    6.1,    7.7,    6.3,    6.4,      6,    6.9,    6.7,    6.9,    5.8,    6.8,    6.7,    6.7,    6.3,    6.5,    6.2,    5.9 ],
## &quot;SepalWidth&quot;: [    3.5,      3,    3.2,    3.1,    3.6,    3.9,    3.4,    3.4,    2.9,    3.1,    3.7,    3.4,      3,      3,      4,    4.4,    3.9,    3.5,    3.8,    3.8,    3.4,    3.7,    3.6,    3.3,    3.4,      3,    3.4,    3.5,    3.4,    3.2,    3.1,    3.4,    4.1,    4.2,    3.1,    3.2,    3.5,    3.6,      3,    3.4,    3.5,    2.3,    3.2,    3.5,    3.8,      3,    3.8,    3.2,    3.7,    3.3,    3.2,    3.2,    3.1,    2.3,    2.8,    2.8,    3.3,    2.4,    2.9,    2.7,      2,      3,    2.2,    2.9,    2.9,    3.1,      3,    2.7,    2.2,    2.5,    3.2,    2.8,    2.5,    2.8,    2.9,      3,    2.8,      3,    2.9,    2.6,    2.4,    2.4,    2.7,    2.7,      3,    3.4,    3.1,    2.3,      3,    2.5,    2.6,      3,    2.6,    2.3,    2.7,      3,    2.9,    2.9,    2.5,    2.8,    3.3,    2.7,      3,    2.9,      3,      3,    2.5,    2.9,    2.5,    3.6,    3.2,    2.7,      3,    2.5,    2.8,    3.2,      3,    3.8,    2.6,    2.2,    3.2,    2.8,    2.8,    2.7,    3.3,    3.2,    2.8,      3,    2.8,      3,    2.8,    3.8,    2.8,    2.8,    2.6,      3,    3.4,    3.1,      3,    3.1,    3.1,    3.1,    2.7,    3.2,    3.3,      3,    2.5,      3,    3.4,      3 ],
## &quot;PetalLength&quot;: [    1.4,    1.4,    1.3,    1.5,    1.4,    1.7,    1.4,    1.5,    1.4,    1.5,    1.5,    1.6,    1.4,    1.1,    1.2,    1.5,    1.3,    1.4,    1.7,    1.5,    1.7,    1.5,      1,    1.7,    1.9,    1.6,    1.6,    1.5,    1.4,    1.6,    1.6,    1.5,    1.5,    1.4,    1.5,    1.2,    1.3,    1.4,    1.3,    1.5,    1.3,    1.3,    1.3,    1.6,    1.9,    1.4,    1.6,    1.4,    1.5,    1.4,    4.7,    4.5,    4.9,      4,    4.6,    4.5,    4.7,    3.3,    4.6,    3.9,    3.5,    4.2,      4,    4.7,    3.6,    4.4,    4.5,    4.1,    4.5,    3.9,    4.8,      4,    4.9,    4.7,    4.3,    4.4,    4.8,      5,    4.5,    3.5,    3.8,    3.7,    3.9,    5.1,    4.5,    4.5,    4.7,    4.4,    4.1,      4,    4.4,    4.6,      4,    3.3,    4.2,    4.2,    4.2,    4.3,      3,    4.1,      6,    5.1,    5.9,    5.6,    5.8,    6.6,    4.5,    6.3,    5.8,    6.1,    5.1,    5.3,    5.5,      5,    5.1,    5.3,    5.5,    6.7,    6.9,      5,    5.7,    4.9,    6.7,    4.9,    5.7,      6,    4.8,    4.9,    5.6,    5.8,    6.1,    6.4,    5.6,    5.1,    5.6,    6.1,    5.6,    5.5,    4.8,    5.4,    5.6,    5.1,    5.1,    5.9,    5.7,    5.2,      5,    5.2,    5.4,    5.1 ],
## &quot;PetalWidth&quot;: [    0.2,    0.2,    0.2,    0.2,    0.2,    0.4,    0.3,    0.2,    0.2,    0.1,    0.2,    0.2,    0.1,    0.1,    0.2,    0.4,    0.4,    0.3,    0.3,    0.3,    0.2,    0.4,    0.2,    0.5,    0.2,    0.2,    0.4,    0.2,    0.2,    0.2,    0.2,    0.4,    0.1,    0.2,    0.2,    0.2,    0.2,    0.1,    0.2,    0.2,    0.3,    0.3,    0.2,    0.6,    0.4,    0.3,    0.2,    0.2,    0.2,    0.2,    1.4,    1.5,    1.5,    1.3,    1.5,    1.3,    1.6,      1,    1.3,    1.4,      1,    1.5,      1,    1.4,    1.3,    1.4,    1.5,      1,    1.5,    1.1,    1.8,    1.3,    1.5,    1.2,    1.3,    1.4,    1.4,    1.7,    1.5,      1,    1.1,      1,    1.2,    1.6,    1.5,    1.6,    1.5,    1.3,    1.3,    1.3,    1.2,    1.4,    1.2,      1,    1.3,    1.2,    1.3,    1.3,    1.1,    1.3,    2.5,    1.9,    2.1,    1.8,    2.2,    2.1,    1.7,    1.8,    1.8,    2.5,      2,    1.9,    2.1,      2,    2.4,    2.3,    1.8,    2.2,    2.3,    1.5,    2.3,      2,      2,    1.8,    2.1,    1.8,    1.8,    1.8,    2.1,    1.6,    1.9,      2,    2.2,    1.5,    1.4,    2.3,    2.4,    1.8,    1.8,    2.1,    2.4,    2.3,    1.9,    2.3,    2.5,    2.3,    1.9,      2,    2.3,    1.8 ],
## &quot;Species&quot;: [ &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;setosa&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;versicolor&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot;, &quot;virginica&quot; ] 
## },
## &quot;facet&quot;: &quot;Species&quot;,
## &quot;color&quot;: &quot;Species&quot;,
## &quot;type&quot;: &quot;point&quot; 
## } 
## ],
## &quot;facet&quot;: {
##  &quot;type&quot;: &quot;wrap&quot;,
## &quot;var&quot;: &quot;Species&quot; 
## },
## &quot;guides&quot;: [],
## &quot;coord&quot;: [],
## &quot;id&quot;: &quot;chart2e5967875327&quot; 
## }
##     _.each(chartParams.layers, function(el){
##         el.data = polyjs.data(el.data)
##     })
##     var graph_chart2e5967875327 = polyjs.chart(chartParams);
## &lt;/script&gt;
##     
##     &lt;script&gt;&lt;/script&gt;    
##   &lt;/body&gt;
## &lt;/html&gt; ' scrolling='no' frameBorder='0' seamless class='rChart  polycharts  ' id='iframe-chart2e5967875327'> </iframe>
##  <style>iframe.rChart{ width: 100%; height: 400px;}</style>
```

```r
# <iframe width = "800" height = "600" src='r1.html'></iframe>
```


<iframe width = 100% height = 60% src='test.html'></iframe>



## Polycharts


```r
head(mtcars)
```

```
                   mpg cyl disp  hp drat    wt  qsec vs am gear carb
Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1
```

```r
r2 <- rPlot(mpg ~ wt, data = mtcars, type = 'point')
r2$save('r2.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='r2.html'></iframe>


### rCharts Polychart: Adding horizontal or vertical lines to a plot


<http://stackoverflow.com/questions/20107947/rcharts-polychart-adding-horizontal-or-vertical-lines-to-a-plot>



```r
mtcars$avg <- mean(mtcars$mpg)
mtcars$sdplus <- mtcars$avg + sd(mtcars$mpg)
mtcars$sdneg <-  mtcars$avg - sd(mtcars$mpg)
p1 <- rPlot(mpg~wt, data=mtcars, type='point')

p1$layer(y='avg', copy_layer=T, type='line', color=list(const='red'))
p1$layer(y='sdplus', copy_layer=T, type='line', color=list(const='green'))
p1$layer(y='sdneg', copy_layer=T, type='line', color=list(const='green'))

p1$save('p1.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='p1.html'></iframe>

### 다양한 polycharts

<https://rpubs.com/kohske/12331>

- point


```r
p2 <- rPlot( mpg ~ qsec, data = mtcars, color = "cyl", size = "disp", type = "point")

p2$layer(tooltip = "#! function(i) {return 'gear ' + i.gear + ' level';} !#", copy_layer = TRUE)

# p$show("inline", include_assets = FALSE) 

p2$save('p2.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='p2.html'></iframe>


- line + point


```r
d <- expand.grid(x = 1:10, g = letters[1:3])
d$y <- rnorm(nrow(d))
p3 <- rPlot( y ~ x, data = d, color = "g", type = "line")
p3$layer(y ~ x, data = d, color = "g", type = "point")
p3$set(title = "line + point")
# p3$show("inline", include_assets = FALSE)
p3$save('p3.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='p3.html'></iframe>

- area


```r
d <- expand.grid(x = 1:10, g = letters[1:3])
d$y <- runif(nrow(d))
p4 <- rPlot( y ~ x, data = d, color = "g", type = "area")
# p4$guides("#! {y: {title: 'hoge', scale: {type: 'log'}}}")
p4$guides(x = list(title = "XXXX"), y = list(title = "YYYY"))
# p4$show("inline", include_assets = FALSE)
p4$save('p4.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='p4.html'></iframe>


- bar


```r
hair_eye <- as.data.frame(HairEyeColor)

p5 <- rPlot(Freq ~ Hair | Sex, color = "Eye", data = hair_eye, type = "bar", position = "dodge")

p5$save('p5.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='p5.html'></iframe>


- 극좌표



```r
d <- expand.grid(x = 1:10, g = letters[1:3])
d$y <- runif(nrow(d))

p6 <- rPlot(y ~ x | g, color = "x", data = d, type = "bar")

p6$params$layers[[1]]$x <- NULL # x 삭제
p6$coord(type = "polar") # 파이차트

p6$guides(x = list(position = "none", padding = 0), y = list(numticks=10)) # 축 변경

p6$save('p6.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='p6.html'></iframe>



## Morris


```r
data(economics, package = "ggplot2")
econ <- transform(economics, date = as.character(date))
m1 <- mPlot(x = "date", y = c("psavert", "uempmed"), type = "Line", data = econ)
m1$set(pointSize = 0, lineWidth = 1)
m1$save('m1.html', cdn = TRUE)
```

```
Loading required package: reshape2
```

<iframe width = 100% height = 60% src='m1.html'></iframe>

### 다양한 polycharts

<https://rpubs.com/kohske/12406>

- line 1


```r
# plot 생성
m2 <- mPlot(y ~ x, data = data.frame(x = paste(2001:2005), y = rnorm(1:5)), type = "Line", smooth = FALSE)
# grid & axes 설정
m2$set(grid = FALSE, axes = FALSE)
# line color
m2$set(lineColors = list("skyblue"))
# p$show("inline", include_assets = FALSE)
m2$save('m2.html', cdn = TRUE)
## Loading required package: reshape2
```

<iframe width = 100% height = 60% src='m2.html'></iframe>

- line 2


```r
d <- data.frame(x = paste(2001:2010), y1 = runif(10), y2 = runif(10))
m3 <- mPlot(x = "x", y = c("y1", "y2"), data = d, type = "Line", labels = c("line 1", "line 2"))
m3$save('m3.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='m3.html'></iframe>

- 시계열 영역 차트


```r
d <- data.frame(x = paste(2001:2010), y1 = runif(10), y2 = runif(10), y3 = runif(10))

m4 <- mPlot(x = "x", y = c("y1", "y2", "y3"), data = d, type = "Area", smooth=FALSE, pointSize = 10, lineWidth = 5)

# event 옵션추가
m4$set(events = paste(c(2004, 2008)), eventStrokeWidth = 10)
m4$save('m4.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='m4.html'></iframe>

- 사용자정의 popup tooltip


```r
d <- data.frame(x = paste(2001:2010), y1 = runif(10), y2 = runif(10), ch = letters[1:10])
m5 <- mPlot(x = "x", y = c("y1", "y2"), data = d, type = "Line", labels = c("line 1", "line 2"))
# tooltip 에 대한 콜백함수 설정
m5$set(hoverCallback = "#! function (index, options, content) {return options.data[index].ch;} !#")
m5$save('m5.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='m5.html'></iframe>



- bar 1


```r
d <- data.frame(x = paste(2001:2010), y1 = runif(10), y2 = runif(10), y3 = runif(10))
m6 <- mPlot(x = "x", y = c("y1", "y2", "y3"), data = d, type = "Bar", barColors = c("red", "green", "blue"))
m6$save('m6.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='m6.html'></iframe>


- bar 2 ; stacked


```r
d <- data.frame(x = paste(2001:2010), y1 = runif(10), y2 = runif(10), y3 = runif(10))

m7 <- mPlot(x = "x", y = c("y1", "y2", "y3"), data = d, type = "Bar", stacked = TRUE, barColors = c("red", "green", "blue"))

m7$save('m7.html', cdn = TRUE)
```

<iframe width = 100% height = 60% src='m7.html'></iframe>


- 도넛차트


```r
d <- data.frame(label = c("'92 live", "'95 secret", "'98 age", "'02 garden"), value = c(32, 30, 25, 38))
m8 <- mPlot(x = NULL, y = NULL, data = d, type = "Donut", formatter = "#! function (y) { return('rate'+y+'%!!'); } !#")

m8$save('m8.html', cdn = TRUE)
```

```
The following `from` values were not present in `x`: x
```

<iframe width = 100% height = 60% src='m8.html'></iframe>




## nvd3

### Why?????????????


```r
hair_eye = as.data.frame(HairEyeColor)
r3 <- nPlot(Freq ~ Hair, group = 'Eye',data = subset(hair_eye, Sex =="Female",type = 'multiBarChart'))
r3$chart(color = c('brown', 'blue', '#594c26', 'green'))
r3$save('r3.html', cdn = TRUE)
```

<iframe width = 100% height = 60%  src='r3.html'></iframe>



## xCharts


```r
library(reshape2)
uspexp <- melt(USPersonalExpenditure)
names(uspexp)[1:2] = c("category", "year")
x1 <- xPlot(value ~ year, group = "category", data = uspexp, type = "line-dotted")
x1$save('x1.html', cdn = TRUE)
```

<iframe width = 100% height = 60%  src='x1.html'></iframe>



## Rickshaw


```r
head(USPersonalExpenditure)
```

```
                      1940   1945  1950 1955  1960
Food and Tobacco    22.200 44.500 59.60 73.2 86.80
Household Operation 10.500 15.500 29.00 36.5 46.20
Medical and Health   3.530  5.760  9.71 14.0 21.10
Personal Care        1.040  1.980  2.45  3.4  5.40
Private Education    0.341  0.974  1.80  2.6  3.64
```

```r
usp = reshape2::melt(USPersonalExpenditure)
head(usp)
```

```
                 Var1 Var2  value
1    Food and Tobacco 1940 22.200
2 Household Operation 1940 10.500
3  Medical and Health 1940  3.530
4       Personal Care 1940  1.040
5   Private Education 1940  0.341
6    Food and Tobacco 1945 44.500
```

```r
tail(usp)
```

```
                  Var1 Var2 value
20   Private Education 1955  2.60
21    Food and Tobacco 1960 86.80
22 Household Operation 1960 46.20
23  Medical and Health 1960 21.10
24       Personal Care 1960  5.40
25   Private Education 1960  3.64
```

```r
tt <- as.POSIXct(paste0(usp$Var2, "-01-01"))
tt
```

```
 [1] "1940-01-01 KST" "1940-01-01 KST" "1940-01-01 KST" "1940-01-01 KST"
 [5] "1940-01-01 KST" "1945-01-01 KST" "1945-01-01 KST" "1945-01-01 KST"
 [9] "1945-01-01 KST" "1945-01-01 KST" "1950-01-01 KST" "1950-01-01 KST"
[13] "1950-01-01 KST" "1950-01-01 KST" "1950-01-01 KST" "1955-01-01 KST"
[17] "1955-01-01 KST" "1955-01-01 KST" "1955-01-01 KST" "1955-01-01 KST"
[21] "1960-01-01 KST" "1960-01-01 KST" "1960-01-01 KST" "1960-01-01 KST"
[25] "1960-01-01 KST"
```

```r
usp$Var2 <- as.numeric(as.POSIXct(paste0(usp$Var2, "-01-01")))
usp$Var2 
```

```
 [1] -946803600 -946803600 -946803600 -946803600 -946803600 -788950800
 [7] -788950800 -788950800 -788950800 -788950800 -631184400 -631184400
[13] -631184400 -631184400 -631184400 -473414400 -473414400 -473414400
[19] -473414400 -473414400 -315648000 -315648000 -315648000 -315648000
[25] -315648000
```

```r
pp4 <- Rickshaw$new()

pp4$layer(value ~ Var2, group = "Var1", data = usp, type = "area")
pp4$set(slider = TRUE)

pp4$save('pp4.html', cdn = TRUE)
```

<iframe width = 100% height = 60%  src='pp4.html'></iframe>



## Leaflet

<http://leafletjs.com/>




```r
map3 <- Leaflet$new()
map3$setView(c(37.5414623,127.0722618), zoom = 17)
map3$marker(c(37.5414623,127.0722618), bindPopup = "<p> Hi. I'm Here! </p>")

map3$save('map3.html', cdn = TRUE)
```

<iframe width = 100% height = 60%  src='map3.html'></iframe>




## Interactive Controls and rCharts 1

참고 : <http://rcharts.io/icontrols/#.VE4CJCKsV8E>


```r
n1 <- rPlot(mpg ~ wt, data = mtcars, color = "gear", type = "point")
n1$save('n1.html', cdn = TRUE)
```

<iframe width = 100% height = 60%  src='n1.html'></iframe>



```r
n1$addControls("x", value = "wt", values = names(mtcars))
n1$addControls("y", value = "wt", values = names(mtcars))
n1$addControls("color", value = "gear", values = names(mtcars))
n1$save('n2.html', cdn = TRUE)
```

<http://stackoverflow.com/questions/21820197/nplot-in-rcharts-does-not-work-with-addcontrols>

- The addControls method has not been implemented for all libraries. It only works for nvd3, polychart and dimple. 

<iframe width = 100% height = 60%  src='n2.html'></iframe>



## Interactive Controls and rCharts 2

### rCharts dimple with Angular Controls

참고 : <http://bl.ocks.org/timelyportfolio/6459298#code.R>


```r
data <- read.delim(
"http://pmsi-alignalytics.github.io/dimple/data/example_data.tsv"
)

#eliminate . to avoid confusion in javascript
colnames(data) <- gsub("[.]","",colnames(data))
d1 <- dPlot(
x ="Month" ,
y = "UnitSales",
data = data,
type = "area"
)

d1$xAxis(orderRule = "Date")
d1$addControls("y", value = "UnitSales", values = names(data))
d1$addControls("groups", value = "", values = names(data))
d1$save('d1.html', cdn = TRUE)
```

<iframe width = 100% height = 60%  src='d1.html'></iframe>



## Interactive Controls and rCharts 3

참고 : <http://www.r-bloggers.com/interactive-charts-with-rcharts/>


