Chapter 8 

Thematic Maps

# 들어가기에 앞서...
# 이 챕터에서 언급되는 자료들은 구글드라이브 또는 
# https://github.com/oscarperpinan/spacetime-vis
# 위 주소에서 다운 받을 수 있습니다.

# 그리고 교재 코드(+@)는 
# http://oscarperpinan.github.io/spacetime-vis/
# 에서 받을 수 있습니다.

# 코드를 볼 수 있는 홈페이지에 들어가면 책에 있는 것 보다 더 많은 코드가 있는데
# 복습하시기 전에 두 코드를 비교, 확인해보시길 바랍니다.

# 이 챕터에서 초반에 정의한 객체(변수) 들은 후반부에도 계속 쓰입니다.
# 중간부터 복습 하실 때에는 앞의 코드를 한번 쭉~ 실행시켜 주시는 것이 정신건강에 좋습니다.


install.packages("rJava")
install.packages("raster")
install.packages("rasterVis")
install.packages("rgdal")
install.packages("OpenStreetMap")
install.packages("grid")
install.packages("maptools")
install.packages("gstat")
install.packages("plotKML")
install.packages("lattice")
install.packages("ggplot2")
install.packages("latticeExtra")
install.packages("XML")
install.packages("sp")
install.packages("RColorBrewer")
install.packages("hexbin")
install.packages("rgl")

library("sp")
library("lattice")
library("RColorBrewer")
library("latticeExtra")
library("hexbin")
library("rJava")
library("raster")
library("rasterVis")
library("rgdal")
library("OpenStreetMap")
library("grid")
library("maptools")
library("gstat")
library("plotKML")
library("ggplot2")
library("XML")
library("rgl")
library("colorspace")

8.1 Proportional Symbol Mapping

8.1.1 Introduction

8.1.2 Proportional Symbol with spplot

##################################################################
## 시작 전 초기설정
##################################################################
## Clone or download the repository and set the working directory
## with setwd to the folder where the repository is located.

library(lattice)
library(ggplot2)
library(latticeExtra)

myTheme <- custom.theme.2(pch=19, cex=0.7,
                          region=rev(brewer.pal(9, 'YlOrRd')),
                          symbol = brewer.pal(n=8, name = "Dark2"))
myTheme$strip.background$col='transparent'
myTheme$strip.shingle$col='transparent'
myTheme$strip.border$col='transparent'

xscale.components.custom <- function(...){
  ans <- xscale.components.default(...)
  ans$top=FALSE
  ans}
yscale.components.custom <- function(...){
  ans <- yscale.components.default(...)
  ans$right=FALSE
  ans}
myArgs <- list(as.table=TRUE,
               between=list(x=0.5, y=0.2),
               xscale.components = xscale.components.custom,
               yscale.components = yscale.components.custom)
defaultArgs <- lattice.options()$default.args

lattice.options(default.theme = myTheme,
                default.args = modifyList(defaultArgs, myArgs))

####################################################################

library("sp")

load('NO2sp.RData')

# ?colorRampPalette
airPal = colorRampPalette(c('springgreen1', 'sienna3', 'gray5'))(5)  # 색을 5가지로!! 색파레트에서 지정한 색과 색 사이를 연결해줌
# airPal = colorRampPalette(c('springgreen1', 'sienna3', 'blue'))(5)  # 파랑으로 바꿔봄.

spplot(NO2sp["mean"], col.regions=airPal, cex=sqrt(1:5), edge.col='black', scales=list(draw=TRUE), key.space='right')

NO2df = data.frame(NO2sp)
NO2df$Mean = cut(NO2sp$mean, 5)

library("ggplot2")
ggplot(data=NO2df, aes(long, lat, size=Mean, fill=Mean)) + geom_point(pch=21, col='black') + theme_bw() + scale_fill_manual(values=airPal)


8.1.3 Optimal Classification and Sizes to Improve Discrimination

library("classInt")
# The number of classes is chosen between the Sturges and the Scott rules.

nClasses = 5
intervals = classIntervals(NO2sp$mean, n=nClasses, style = "fisher")
intervals
# Number of classes is not always the same as the proposed number
nClasses = length(intervals$brks) - 1
nClasses

op = options(digits=4)
tab = print(intervals)
options(op)


# Complete Dent set of circle radii(mm)
dent = c(0.64, 1.14, 1.65, 2.79, 4.32, 6.22, 9.65, 12.95, 12.95, 15.11)

# Subset for out dataset
dentAQ = dent[seq_len(nClasses)]
dentAQ

# Link Size and Class:findCols returns te class numver of each point;
# cex is the vector of sizes for each data point
idx = findCols(intervals)
cexNO2 = dentAQ[idx]

NO2sp$classNO2 = factor(names(tab)[idx])

# ggplot2 version
NO2df = data.frame(NO2sp)
ggplot(data=NO2df, aes(long, lat, size=classNO2, fill=classNO2)) + geom_point(pch=21, col='black') + theme_bw() + scale_fill_manual(values=airPal) + scale_size_manual(values=dentAQ*2)

# spplot version

# Definition of an improved key with title and background
NO2key = list(x=0.98, y=0.02, corner=c(1,0), title=expression(NO[2]~~(paste(mu, plain(g))/m^3)), cex.title=0.75, cex=0.7, background='gray92')
NO2key 

pNO2 = spplot(NO2sp["classNO2"], col.regions=airPal, cex=dentAQ, edge.col='black', scales=list(draw=TRUE), key.space=NO2key)
pNO2


8.1.4 Spatial Context with Underlying Layers and Labels

8.1.4.1 Static Image

madridBox = bbox(NO2sp)

# ggmap solution

library("ggmap")
library("jpeg")
library("plyr")


# 아래 get_map 함수가 에러가 날 경우 아래 주소를 참고하고,
# chapter8_revise_script.R 을 열어 해당 코드를 먼저 실행시켜줍니다.
# http://stackoverflow.com/questions/23488022/ggmap-stamen-watercolor-png-error

madridGG <- get_map(c(madridBox), maptype="watercolor", source="stamen") # <-- 여기서 에러주의


# OpenStreetMap solution
library("rJava")
library("raster")
library("rgdal")
library("OpenStreetMap")
ul = madridBox[c(4, 1)] # upper-left
lr = madridBox[c(2, 3)] # lower-right
madridOM = openmap(ul, lr, type="osm") # "stamen-watercolor" 대신 "osm" 사용하세영
madridOM = openproj(madridOM)

NO2df = data.frame(NO2sp)

# ggmap
ggmap(madridGG) + 
	geom_point(data=NO2df, 
		aes(long, lat, size=classNO2, fill=classNO2),
		pch=21, col='black') +
	scale_fill_manual(values=airPal) + 
	scale_size_manual(values=dentAQ*2)

# OpenStreetMap
autoplot(madridOM) +
	geom_point(data=NO2df,
		aes(long, lat, size=classNO2, fill=classNO2),
		pch=21, col="black") +
	scale_fill_manual(values=airPal) +
	scale_size_manual(values=dentAQ*2)

# the 'bb' attribute stores the bounding box of the get_map result
bbMap = attr(madridGG, "bb")

# This information is needed to resize the image with grid.raster
height = with(bbMap, ur.lat - ll.lat)
width = with(bbMap, ur.lon - ll.lon)


library("grid")

# 이거 됐다 안됐다 함.
pNO2 + layer(grid.raster(madridGG,
			width=width, height=height,
			default.units="native"),
		under=TRUE)
dev.off()

tile = madridOM$tile[[1]]
height = with(tile$bbox, p1[2] - p2[2])
width = with = with(tile$bbox, p2[1] - p1[1])

colors = as.raster(matrix(tile$colorData,
				ncol=tile$yres,
				nrow=tile$xres,
				byrow=TRUE))

pNO2 + layer(grid.raster(colors,
			width=width,
			height=height,
			default.units='native'),
		under=TRUE)
dev.off()

8.1.4.2 Vector Data

gpclibPermit()  # maptools 패키지 실행 이전 오류 방지용 명령어
library("maptools") # readShapePoly 실행 전 로드 필수
library("rgdal")

# nomecalles http://www.madrid.org/nomecalles/Callejero_madrid.icm  # <-- 여기서 지도를 볼 수 있고
# Form at http://www.madrid.org/nomecalles/DescargaBDTCorte.icm # <-- 여기서 다운받을 수 있다.

# Madrid districts

unzip("Distritos.zip") # Distritos de Madrid.zip 대신 Distritos.zip을 사용.
# distritosMadrid = readShapePoly("Distritos de Madrid/200001442") # 200001331 대신 200001442를 사용(버전업이 됐나봐요)
distritosMadrid = readShapePoly("200001442.shp") # 위 코드 대신 이 코드 사용.
proj4string(distritosMadrid) = CRS("+proj=utm +zone=30")
distritosMadrid = spTransform(distritosMadrid, CRS=CRS("+proj=longlat +ellps=WGS84"))

## Madrid streets
unzip('Callejero_ Ejes de viales.zip')
# streets = readShapeLines('Callejero_ Ejes de viales/call2013.shp') # call2011 대신 call2013을 사용(이 역시 버전업 인듯)
streets = readShapeLines("call2013.shp") # call2011 대신 call2013을 사용.
streetsMadrid = streets[streets$CMUN=='079',]
proj4string(streetsMadrid) = CRS("+proj=utm +zone=30")
streetsMadrid = spTransform(streetsMadrid, CRS=CRS("+proj=longlat +ellps=WGS84"))

windowsFonts(Constantia=windowsFont("Constantia")) # <-- fontfamily 에러 방지용 코드. 자신이 원하는 폰트(윈도우에 있어야 됨)를 사용

spDistricts = list("sp.polygons", distritosMadrid, fill="gray97", lwd=0.3)
spStreets = list("sp.lines", streetsMadrid, lwd=0.05)
spNames = list(sp.pointLabel, NO2sp, 
		labels=substring(NO2sp$codEst, 7), 
		cex=0.6, fontfamily="Constantia")

spplot(NO2sp["classNO2"], col.regions=airPal, cex=dentAQ,
	edge.col="black", alpha=0.8,
	sp.layout=list(spDistricts, spStreets, spNames),
	scales=list(draw=TRUE),
	key.space=NO2key)

# 갑자기 또 안됨;;;
pNO2 + layer(sp.pointLabel(NO2sp,
				labels=substring(NO2sp$codEst, 7),
				cex=0.8, fontfamily="Constantia")
		) +
	layer_({
		sp.polygons(distritosMadrid, fill="gray97", lwd=0.3)
		sp.lines(streetsMadrid, lwd=0.05)
	})				
dev.off()

8.1.5 Spatial Interpolation

library("gstat")

############################################ 일단 안됨

airGrid = spsample(NO2sp, type="regular", n=1e5) # 10만개의 샘플을 추출
gridded(airGrid) = TRUE
# identical(proj4string(NO2sp), proj4string(airGrid))???
airKrige = krige(mean ~ 1, NO2sp, airGrid) ## <-- 안됨

# png(filename="airMadrid_krige.png",res=600,height=4000,width=4000) ## <-- 이게 왜 있지?
spplot(airKrige["var1.pred"],
		col.regions=colorRampPalette(airPal)) +
	layer({
		sp.polygons(distritosMadrid, fill="transparent", lwd=0.3)
		sp.lines(streetsMadrid, lwd=0.07)
		sp.points(NO2sp, pch=21, alpha=0.8, fill = "gray50", col="black")
		})
dev.off()

############################################ 일단ㅋ 안ㅋ됨ㅋ


8.1.6 Export to Other Formats

8.1.6.1 GeoJSON and OpenStreetMap

library("rgdal")
writeOGR(NO2sp, "NO2.geojson", "NO2sp", driver = "GeoJSON")


8.1.6.2 Keyhole Markup Language
# 웹 브라우저에 2차원 또는 3차원으로 지도를 그리는 것.

library("rgdal")
writeOGR(NO2sp, dsn='NO2_mean.kml', layer='mean', driver='KML')

library("plotKML")
plotKML(NO2sp["mean"], points_names=NO2sp$codEst)


8.1.7 Additional Information with Tooltips and Hyperlinks

# 모든 코드 실행 안됨.

library("XML")

old = setwd('images')
for (i in 1:nrow(NO2df))
{
  codEst = NO2df[i, "codEst"]
  ## Webpage of each station
  codURL = as.numeric(substr(codEst, 7, 8))
  rootURL = 'http://www.mambiente.munimadrid.es'
  stationURL = paste(rootURL,
                      '/opencms/opencms/calaire/contenidos/estaciones/estacion',
                      codURL, '.html', sep='')
  content = htmlParse(stationURL, encoding='utf8')
  ## Extracted with http://www.selectorgadget.com/
  xPath = '//*[contains(concat( " ", @class, " " ), concat( " ", "imagen_1", " " ))]'
  imageStation = getNodeSet(content, xPath)[[1]]
  imageURL = xmlAttrs(imageStation)[1]
  imageURL = paste(rootURL, imageURL, sep='')
  download.file(imageURL, destfile=paste(codEst, '.jpg', sep=''))
}
setwd(old)

print(pNO2 + layer_(sp.polygons(distritosMadrid, fill='gray97', lwd=0.3)))

library(gridSVG)

NO2df = as.data.frame(NO2sp)

tooltips = sapply(seq_len(nrow(NO2df)), function(i){
  codEst = NO2df[i, "codEst"]
  ## Information to be attached to each line
  stats = paste(c('Mean', 'Median', 'SD'),
                 signif(NO2df[i, c('mean', 'median', 'sd')], 4),
                 sep=' = ', collapse='<br />')
  ## Station photograph 
  imageURL = paste('images/', codEst, '.jpg', sep='')
  imageInfo = paste("<img src=", imageURL,
                     " width='100' height='100' />", sep='')
  ## Text to be included in the tooltip
  nameStation = paste('<b>', 
                       as.character(NO2df[i, "Nombre"]),
                       '</b>', sep='')
  info = paste(nameStation, stats, sep='<br />')
  ## Tooltip includes the image and the text
  paste(imageInfo, info, sep='<br />')
})
grid.garnish('points.panel', title=tooltips,  grep=TRUE, group=FALSE)

## Webpage of each station
rootURL = 'http://www.mambiente.munimadrid.es'
urlList = sapply(seq_len(nrow(NO2df)), function(i){
  codEst = NO2df[i, "codEst"]
  codURL = as.numeric(substr(codEst, 7, 8))
  stationURL = paste(rootURL,
                      '/opencms/opencms/calaire/contenidos/estaciones/estacion',
                      codURL, '.html', sep='')
})

grid.hyperlink('points.panel', urlList, grep=TRUE, group=FALSE)

## Add jQuery and jQuery UI scripts
grid.script(file='http://code.jquery.com/jquery-1.8.3.js')
grid.script(file='http://code.jquery.com/ui/1.9.2/jquery-ui.js')
## Simple JavaScript code to initialize the tooltip
grid.script(file='js/myTooltip.js')
## Produce the SVG graphic: the results of grid.garnish,
## grid.hyperlink and grid.script are converted to SVG code
grid.export('figs/airMadrid.svg')

htmlBegin = '<!DOCTYPE html>
<html>
<head>
<title>Tooltips with jQuery and gridSVG</title>
<link rel="stylesheet" type="text/css" href="http://code.jquery.com/ui/1.9.2/themes/smoothness/jquery-ui.css" />
<meta charset="utf-8">
</head>
<body>'

htmlEnd = '</body> </html>'

svgText = paste(readLines('figs/airMadrid.svg'), collapse='\n')

writeLines(paste(htmlBegin, svgText, htmlEnd, sep='\n'),
           'airMadrid.html')



8.2 Choropleth Maps
(등치 지역도)

##################################################################
## 시작하기 전에 해야할 초기 설정.
##################################################################
## Clone or download the repository and set the working directory
## with setwd to the folder where the repository is located.

library("lattice")
library("ggplot2")
library("latticeExtra")

myTheme <- custom.theme.2(pch=19, cex=0.7,
                          region=rev(brewer.pal(9, 'YlOrRd')),
                          symbol = brewer.pal(n=8, name = "Dark2"))
myTheme$strip.background$col='transparent'
myTheme$strip.shingle$col='transparent'
myTheme$strip.border$col='transparent'

xscale.components.custom <- function(...){
    ans <- xscale.components.default(...)
    ans$top=FALSE
    ans}
yscale.components.custom <- function(...){
    ans <- yscale.components.default(...)
    ans$right=FALSE
    ans}
myArgs <- list(as.table=TRUE,
               between=list(x=0.5, y=0.2),
               xscale.components = xscale.components.custom,
               yscale.components = yscale.components.custom)
defaultArgs <- lattice.options()$default.args

lattice.options(default.theme = myTheme,
                default.args = modifyList(defaultArgs, myArgs))

############################################################ 초기 설정 끝


votes2011 = read.csv("votes2011.csv",
                      colClasses=c("factor", "factor", "numeric", "numeric"))
head(votes2011)

##################################################################
## Administrative boundaries
##################################################################

library(sp)
library(maptools)

old = setwd(tempdir())
download.file('http://goo.gl/TIvr4', 'mapas_completo_municipal.rar') # 다운로드 에러남
system2('unrar', c('e', 'mapas_completo_municipal.rar'))
espMap = readShapePoly(esp_muni_0109) # 될리가 없지
Encoding(levels(espMap$NOMBRE)) <- "latin1"


provinces = readShapePoly(fn="spain_provinces_ag_2")
setwd(old)

## dissolve repeated polygons
espPols = unionSpatialPolygons(espMap, espMap$PROVMUN)

## Extract Canarias islands from the SpatialPolygons object
canarias = sapply(espPols@polygons, function(x)substr(x@ID, 1, 2) %in% c("35",  "38"))
peninsulaPols = espPols[!canarias]
islandPols = espPols[canarias]

## Shift the island extent box to position them at the bottom right corner
dy = bbox(peninsulaPols)[2,1] - bbox(islandPols)[2,1]
dx = bbox(peninsulaPols)[1,2] - bbox(islandPols)[1,2]
islandPols2 = elide(islandPols, shift=c(dx, dy))
bbIslands = bbox(islandPols2)

## Bind Peninsula (without islands) with shifted islands
espPols = rbind(peninsulaPols, islandPols2)

## Match polygons and data using ID slot and PROVMUN column
IDs = sapply(espPols@polygons, function(x)x@ID)
idx = match(IDs, votes2011$PROVMUN)

##Places without information
idxNA = which(is.na(idx))

##Information to be added to the SpatialPolygons object
dat2add = votes2011[idx, ]

## SpatialPolygonsDataFrame uses row names to match polygons with data
row.names(dat2add) = IDs
espMapVotes = SpatialPolygonsDataFrame(espPols, dat2add)

## Drop those places without information
espMapVotes = espMapVotes[-idxNA, ]

##################################################################
## Map
##################################################################

library(colorspace)  

classes = levels(factor(espMapVotes$whichMax))
nClasses = length(classes)

qualPal = rainbow_hcl(nClasses, start=30, end=300)

## distance between hues
step = 360/nClasses 
## hues equally spaced
hue = (30 + step*(seq_len(nClasses)-1))%%360 
qualPal = hcl(hue, c=50, l=70)

pdf(file="figs/whichMax.pdf")
spplot(espMapVotes["whichMax"], col='transparent', col.regions=qualPal)
dev.off()

pdf(file="figs/pcMax.pdf")
quantPal = rev(heat_hcl(16))
spplot(espMapVotes["pcMax"], col='transparent', col.regions=quantPal)
dev.off()

##################################################################
## Categorical and quantitative variables combined in a multivariate choropleth map
##################################################################

classes = levels(factor(espMapVotes$whichMax))
nClasses = length(classes)
step = 360/nClasses
multiPal = lapply(1:nClasses, function(i){
    rev(sequential_hcl(16, h = (30 + step*(i-1))%%360))
    })

pList = lapply(1:nClasses, function(i){
    ## Only those polygons corresponding to a level are selected
    mapClass = espMapVotes[espMapVotes$whichMax==classes[i],]
    pClass = spplot(mapClass['pcMax'], col.regions=multiPal[[i]],
                     col='transparent',
                     ## labels only needed in the last legend
                     colorkey=(if (i==nClasses) TRUE else list(labels=rep('', 6))),
                     at = seq(0, 100, by=20))
})

p = Reduce('+', pList)

## Function to add a title to a legend
addTitle = function(legend, title){
  titleGrob = textGrob(title, gp=gpar(fontsize=8), hjust=1, vjust=1)
  ## retrieve the legend from the trellis object
  legendGrob = eval(as.call(c(as.symbol(legend$fun), legend$args)))
  ## Layout of the legend WITH the title
  ly = grid.layout(ncol=1, nrow=2,
                    widths=unit(0.9, 'grobwidth', data=legendGrob))
  ## Create a frame to host the original legend and the title
  fg = frameGrob(ly, name=paste('legendTitle', title, sep='_'))
  ## Add the grobs to the frame
  pg = packGrob(fg, titleGrob, row=2)
  pg = packGrob(pg, legendGrob, row=1)
  }

## Access each trellis object from pList...
for (i in seq_along(classes)){
  ## extract the legend (automatically created by spplot)...
  lg = pList[[i]]$legend$right
  ## ... and add the addTitle function to the legend component of each trellis object
  pList[[i]]$legend$right = list(fun='addTitle',
                                  args=list(legend=lg, title=classes[i]))
}

## List of legends
legendList = lapply(pList, function(x){
  lg = x$legend$right
  clKey = eval(as.call(c(as.symbol(lg$fun), lg$args)))
  clKey
})

## Function to pack the list of legends in a unique legend
## Adapted from latticeExtra::: mergedTrellisLegendGrob
packLegend = function(legendList){
  N = length(legendList)
  ly = grid.layout(nrow = 1,  ncol = N)
  g = frameGrob(layout = ly, name = "mergedLegend")
  for (i in 1:N) g = packGrob(g, legendList[[i]], col = i)
  g
}

## The legend of p will include all the legends
p$legend$right = list(fun = 'packLegend',  args = list(legendList = legendList))

png(filename="figs/mapLegends.png")
canarias = provinces$PROV %in% c(35, 38)
peninsulaLines = provinces[!canarias,]

p +
  layer(sp.polygons(peninsulaLines,  lwd = 0.1)) +
  layer(grid.rect(x=bbIslands[1,1], y=bbIslands[2,1],
                  width=diff(bbIslands[1,]),
                  height=diff(bbIslands[2,]),
                  default.units='native', just=c('left', 'bottom'),
                  gp=gpar(lwd=0.5, fill='transparent')))
dev.off()


8.3 Raster Maps

8.3.1 Quantitave Data


##################################################################
## Quantitative data
##################################################################

pdf(file="figs/leveplotSISavOrig.pdf")
library(raster)
library(rasterVis)
SISav <- raster("SISav")
levelplot(SISav)
dev.off()

library(maps)
library(mapdata)
library(maptools)

ext <- as.vector(extent(SISav))
boundaries <- map('worldHires',
                  xlim=ext[1:2], ylim=ext[3:4],
                  plot=FALSE)
boundaries <- map2SpatialLines(boundaries,
                               proj4string=CRS(projection(SISav)))

pdf(file="figs/leveplotSISavBoundaries.pdf")
levelplot(SISav) + layer(sp.lines(boundaries, lwd=0.5))
dev.off()

##################################################################
## Hill shading
##################################################################

old <- setwd(tempdir())
download.file('http://biogeo.ucdavis.edu/data/diva/msk_alt/ESP_msk_alt.zip', 'ESP_msk_alt.zip')
unzip('ESP_msk_alt.zip', exdir='.')

DEM <- raster('ESP_msk_alt')

slope <- terrain(DEM, 'slope')
aspect <- terrain(DEM, 'aspect')
hs <- hillShade(slope=slope, aspect=aspect,
                angle=20, direction=30)

setwd(old)

png(filename="figs/hillShading.png",res=300,height=2000,width=2000)
## hillShade theme: gray colors and semitransparency
hsTheme <- modifyList(GrTheme(), list(regions=list(alpha=0.6)))

levelplot(SISav, panel=panel.levelplot.raster,
          margin=FALSE, colorkey=FALSE) +
  levelplot(hs, par.settings=hsTheme, maxpixels=1e6) +
  layer(sp.lines(boundaries, lwd=0.5))
dev.off()

##################################################################
## Excursus: 3D visualization
##################################################################

library(rgl)
plot3D(DEM, maxpixels=5e4)

writeSTL('figs/DEM.stl')

##################################################################
## Diverging palettes
##################################################################

meanRad <- cellStats(SISav, 'mean')
SISav <- SISav - meanRad

png(filename="figs/xyplotSISav.png",res=300,height=2000,width=2000)
xyplot(layer ~ y, data = SISav,
       groups=cut(x, 5),
       par.settings=rasterTheme(symbol=plinrain(n=5, end=200)),
       xlab = 'Latitude', ylab = 'Solar radiation (scaled)',  
       auto.key=list(space='right', title='Longitude', cex.title=1.3))
dev.off()

pdf(file="figs/showDivPal.pdf")
divPal <- brewer.pal(n=9, 'PuOr')
divPal[5] <- "#FFFFFF"

showPal <- function(pal, labs=pal, cex=0.6, ...){
  barplot(rep(1, length(pal)), col=pal,
          names.arg=labs, cex.names=cex,
          axes=FALSE, ...)
}

showPal(divPal)
dev.off()

pdf(file="figs/divPal_SISav_naive.pdf")
divTheme <- rasterTheme(region=divPal)

levelplot(SISav, contour=TRUE, par.settings=divTheme)
dev.off()

rng <- range(SISav[])
## Number of desired intervals
nInt <- 15
## Increment correspondent to the range and nInt
inc0 <- diff(rng)/nInt
## Number of intervals from the negative extreme to zero
n0 <- floor(abs(rng[1])/inc0)
## Update the increment adding 1/2 to position zero in the center of an interval
inc <- abs(rng[1])/(n0 + 1/2)
## Number of intervals from zero to the positive extreme
n1 <- ceiling((rng[2]/inc - 1/2) + 1)
## Collection of breaks
breaks <- seq(rng[1], by=inc, length= n0 + 1 + n1)

## Midpoints computed with the median of each interval
idx <- findInterval(SISav[], breaks, rightmost.closed=TRUE)
mids <- tapply(SISav[], idx, median)
## Maximum of the absolute value both limits
mx <- max(abs(breaks))
mids

pdf(file="figs/showBreak2Pal.pdf")
break2pal <- function(x, mx, pal){
  ## x = mx gives y = 1
  ## x = 0 gives y = 0.5
  y <- 1/2*(x/mx + 1)
  rgb(pal(y), maxColorValue=255)
}

## Interpolating function that maps colors with [0, 1]
## rgb(divRamp(0.5), maxColorValue=255) gives "#FFFFFF" (white)
divRamp <- colorRamp(divPal)
## Diverging palette where white is associated with the interval
## containing the zero
pal <- break2pal(mids, mx, divRamp)
showPal(pal, round(mids, 1))
dev.off()

pdf(file="figs/divPalSISav.pdf")
levelplot(SISav, par.settings=rasterTheme(region=pal),
          at=breaks, contour=TRUE)
dev.off()

pdf(file="figs/divPalSISav_regions.pdf")
divTheme <- rasterTheme()

divTheme$regions$col <- pal
levelplot(SISav, par.settings=divTheme, at=breaks, contour=TRUE)
dev.off()

library(classInt)

cl <- classIntervals(SISav[],
                     ## n=15, style='equal')
                     ## style='hclust')
                     ## style='sd')
                     style='kmeans')
## style='quantile')
cl
breaks <- cl$brks

pdf(file="figs/divPalSISav_classInt.pdf")
idx <- findInterval(SISav[], breaks, rightmost.closed=TRUE)
mids <- tapply(SISav[], idx, median)
mids
mx <- max(abs(breaks))
pal <- break2pal(mids, mx, divRamp)
divTheme$regions$col <- pal
levelplot(SISav, par.settings=divTheme, at=breaks, contour=TRUE)
dev.off()

##################################################################
## Categorical data
##################################################################

library(raster)
## China and India  
ext <- extent(65, 135, 5, 55)

pop <- raster('875430rgb-167772161.0.FLOAT.TIFF')
pop <- crop(pop, ext)
pop[pop==99999] <- NA

landClass <- raster('241243rgb-167772161.0.TIFF')
landClass <- crop(landClass, ext)

landClass[landClass %in% c(0, 254)] <- NA
## Only four groups are needed:
## Forests: 1:5
## Shublands, etc: 6:11
## Agricultural/Urban: 12:14
## Snow: 15:16
landClass <- cut(landClass, c(0, 5, 11, 14, 16))
## Add a Raster Atribute Table and define the raster as categorical data
landClass <- ratify(landClass)
## Configure the RAT: first create a RAT data.frame using the
## levels method; second, set the values for each class (to be
## used by levelplot); third, assign this RAT to the raster
## using again levels
rat <- levels(landClass)[[1]]
rat$classes <- c('Forest', 'Land', 'Urban', 'Snow')
levels(landClass) <- rat

pdf(file="figs/landClass.pdf")
library(rasterVis)

pal <- c('palegreen4', # Forest
         'lightgoldenrod', # Land
         'indianred4', # Urban
         'snow3')      # Snow

catTheme <- modifyList(rasterTheme(),
                       list(panel.background = list(col='lightskyblue1'),
                            regions = list(col= pal)))

levelplot(landClass, maxpixels=3.5e5, par.settings=catTheme,
          panel=panel.levelplot.raster)
dev.off()

pdf(file="figs/populationNASA.pdf")
pPop <- levelplot(pop, zscaleLog=10, par.settings=BTCTheme,
                  maxpixels=3.5e5, panel=panel.levelplot.raster)
pPop
dev.off()

pdf(file="figs/histogramLandClass.pdf")
s <- stack(pop, landClass)
names(s) <- c('pop', 'landClass')
histogram(~log10(pop)|landClass, data=s,
          scales=list(relation='free'))
dev.off()

##################################################################
## Multivariate legend
##################################################################

library(colorspace)
## at for each sub-levelplot is obtained from the global levelplot
at <- pPop$legend$bottom$args$key$at
classes <- rat$classes
nClasses <- length(classes)

pList <- lapply(1:nClasses, function(i){
  landSub <- landClass
  ## Those cells from a different land class are set to NA...
  landSub[!(landClass==i)] <- NA
  ## ... and the resulting raster mask the population raster
  popSub <- mask(pop, landSub)
  ## The HCL color wheel is divided in nClasses
  step <- 360/nClasses
  ## and a sequential palette is constructed with a hue from one
  ## the color wheel parts
  cols <- rev(sequential_hcl(16, h = (30 + step*(i-1))%%360))
  
  pClass <- levelplot(popSub, zscaleLog=10, at=at,
                      maxpixels=3.5e5,
                      ## labels only needed in the last legend
                      colorkey=(if (i==nClasses) TRUE else list(labels=list(labels=rep('', 17)))),
                      col.regions=cols, margin=FALSE)
})

png(filename="figs/popLandClass.png",res=300,height=2000,width=2000)
p <- Reduce('+', pList)
## Function to add a title to a legend
addTitle <- function(legend, title){
  titleGrob <- textGrob(title, gp=gpar(fontsize=8), hjust=0.5, vjust=1)
  ## retrieve the legend from the trellis object
  legendGrob <- eval(as.call(c(as.symbol(legend$fun), legend$args)))
  ## Layout of the legend WITH the title
  ly <- grid.layout(ncol=1, nrow=2,
                    widths=unit(0.9, 'grobwidth', data=legendGrob))
  ## Create a frame to host the original legend and the title
  fg <- frameGrob(ly, name=paste('legendTitle', title, sep='_'))
  ## Add the grobs to the frame
  pg <- packGrob(fg, titleGrob, row=2)
  pg <- packGrob(pg, legendGrob, row=1)
}

## Access each trellis object from pList...
for (i in seq_len(nClasses)){
  ## extract the legend (automatically created by spplot)...
  lg <- pList[[i]]$legend$right
  ## ... and add the addTitle function to the legend component of each trellis object
  pList[[i]]$legend$right <- list(fun='addTitle',
                                  args=list(legend=lg, title=classes[i]))
}

## List of legends
legendList <- lapply(pList, function(x){
  lg <- x$legend$right
  clKey <- eval(as.call(c(as.symbol(lg$fun), lg$args)))
  clKey
})

## Function to pack the list of legends in a unique legend
## Adapted from latticeExtra::: mergedTrellisLegendGrob
packLegend <- function(legendList){
  N <- length(legendList)
  ly <- grid.layout(nrow = 1,  ncol = N)
  g <- frameGrob(layout = ly, name = "mergedLegend")
  for (i in 1:N) g <- packGrob(g, legendList[[i]], col = i)
  g
}

## The legend of p will include all the legends
p$legend$right <- list(fun = 'packLegend',  args = list(legendList = legendList))


p
dev.off()
