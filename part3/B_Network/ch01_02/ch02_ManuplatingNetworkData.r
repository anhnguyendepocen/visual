
###2.2 Creating Network Graphs
##2.2.1 Undirected and Directed Graphs

#2.1
library(igraph)
?igraph
g <- graph.formula(1-2, 1-3, 2-3, 2-4, 3-5, 4-5, 4-6, 4-7, 5-6, 6-7)

#2.2
V(g)

#2.3
E(g)

#2.4
str(g)

#2.5
plot(g)

#2.6
dg <- graph.formula(1-+2, 1-+3, 2++3)
plot(dg)

#2.7
dg <- graph.formula(Sam+-Mary, Sam+-Tom, Marry++Tom)
str(dg)

#2.8
#V(dg)$name <- c("Sam", "Mary", "Tom")

#2.2.2 Representations for Graphs
#2.9
E(dg)
#2.10
get.adjacency(g)

##2.2.3 Operations on Graphs
#2.11
h <- induced.subgraph(g, 1:5)
str(h)

#2.12
h <- g - vertices(c(6,7))

#2.13
h <- h + vertices(c(6,7))
g <- h + edges(c(4,6),c(4,7),c(5,6),c(6,7))

#2.14
h1 <- h
h2 <- graph.formula(4-6, 4-7, 5-6, 6-7)
g <- graph.union(h1,h2)
                                                                 
###2.3 Decorating Network Graphs
##2.3.1 Vertex, Edge, and Graph Attributes
#2.15
V(dg)$name
#2.16
V(dg)$gender <- c("M","F","M")
#2.17
V(g)$color <- "red"
#2.18
is.weighted(g)
wg <- g
E(wg)$weight <- runif(ecount(wg))
is.weighted(wg)
#2.19
g$name <- "Toy Graph"

##2.3.2 Using Data Frames
#2.20
library(sand)
?sand
g.lazega <- graph.data.frame(elist.lazega, directed="FALSE", vertices=v.attr.lazega)
g.lazega$name <= "Lazega Lawyers"
#2.21
vcount(g.lazega)
#2.22
ecount(g.lazega)
#2.23
list.vertex.attributes(g.lazega)

###2.4 Talking About Graphs
##2.4.1 Basic Graph Concepts
#2.24
is.simple(g)
#2.25
mg <- g + edge(2,3)
str(mg)
is.simple(mg)
#2.26
E(mg)$weight <- 1
wg2 <- simplify(mg)
is.simple(wg2)
#2.27
str(wg2)
#2.28
E(wg2)$weight
#2.29
neighbors(g, 5)
#2.30
degree(g)
#2.31
degree(dg, mode="in")
#2.32
degree(dg, mode="out")
#2.33
clusters(g)
#2.34
is.connected(dg, mode="weak")
#2.34
is.connected(dg, mode="strong")
#2.35
diameter(g, weights=NA)

##2.4.2 Special Types of Graphs
#2.36
g.full <- graph.full(7)
g.ring <- graph.ring(7)
g.tree <- graph.tree(7, children=2, mode="undirected")
g.star <- graph.star(7, mode="undirected")
par(mfrow=c(2,2))
plot(g.full)
plot(g.ring)
plot(g.tree)
plot(g.star)
#2.37
is.dag(dg)
#2.38
g.bip <- graph.formula(actor1:actor2:actor3,
                       movie1:movie2, actor1:actor2 - movie1,
                       actor2:actor3, movie2)
V(g.bip)$type <- grepl("^movie", V(g.bip)$name)
str(g.bip, v=T)
#2.39
proj <- bipartite.projection(g.bip)
str(proj[[1]])
str(proj[[2]])
