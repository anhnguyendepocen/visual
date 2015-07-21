

# 6.1
library(sand)
data(lazega)
A <- get.adjacency(lazega)
v.attrs <- get.data.frame(lazega, what="vertices")

#.6.2
library(ergm)
lazega.s <- network::as.network(as.matrix(A), directed = FALSE)
network::set.vertex.attribute(lazega.s, "Office", v.attrs$Office)
network::set.vertex.attribute(lazega.s, "Practice", v.attrs$Practice)
network::set.vertex.attribute(lazega.s, "Gender", v.attrs$Gender)
network::set.vertex.attribute(lazega.s, "Seniority", v.attrs$Seniority)

#6.2.2 Specifying a Model
# 6.3
my.ergm.bern <-formula(lazega.s ~ edges)
my.ergm.bern
?formula
# 6.4
summary.statistics(my.ergm.bern)
?summary.statistics

#6.5
my.ergm <- formula(lazega.s ~ edges + kstar(2) + kstar(3) + triangle)
summary.statistics(my.ergm)

#6.6
my.ergm <- formula(lazega.s ~ edges + gwesp(1, fixed = TRUE))
summary.statistics(my.ergm)

#6.7
lazega.ergm <- formula(lazega.s ~ edges + gwesp(log(3), fixed = TRUE)
 + nodemain("Seniority")
 + nodemain ("Practice")
 + match ("Practice")
 + match ("Gender")
 + match ("Office"))

#6.8
set.seed(42)
lazega.ergm.fit <- ergm(lazega.ergm)

#6.9
anova.ergm(lazega.ergm.fit)

#6.10
summary.ergm(lazega.ergm.fit)

#6.11
gof.lazega.ergm <- gof(lazega.ergm.fit)

#6.12
par(mfrow=c(1,3))
plot(gof.lazega.ergm)


#6.13
library(mixer)
setSeed(42)
fblog.sbm <- mixer(as.matrix(get.adjacency(fblog)), qmin=2, qmax=15)

#6.14
fblog.sbm.output <- getModel(fblog.sbm)
names(fblog.sbm.output)

# 6.15
fblog.sbm.output$q

#6.16
fblog.sbm.output$alphas

# 6.17
fblog.sbm.output$Taus[, 1:3]

#6.18
my.ent <- function(x)  { -sum(x*log(x,2))}
apply(fblog.sbm.output$Taus[, 1:3], 2, my.ent)

# 6.19
log(fblog.sbm.output$q, 2)

# 6.20
summary(apply(fblog.sbm.output$Taus, 2, my.ent))

#6.21
plot(fblog.sbm, classes = as.factor(V(fblog)$PolParty))

#6.22
summary(lazega)

#6.23
library(eigenmodel)
set.seed(42)
A <- get.adjacency(lazega, sparse = FALSE)
lazega.leig.fit1 <- eigenmodel_mcmc(A, R=2, S=11000, burn = 1000)

#6.24
same.prac.op <- v.attr.lazega$Office %o% v.attr.lazega$Office #%o% o is alphabet
same.prac <- matrix(as.numeric(same.prac.op %in% c(1,4,9)), 36, 36)
same.prac <- array(same.prac, dim=c(36,36,1))

#6.25
lazega.leig.fit2 <- eigenmodel_mcmc(A, same.prac, R=2, S=11000, burn=10000)

#6.26
same.off.op <- v.attr.lazega$Office %o% v.attr.lazega$Office
same.off <- matrix(as.numeric(same.off.op %in% c(1,4,9)), 36, 36)
same.off <- array(same.off, dim=c(36, 36, 1))
lazega.leig.fit3 <- eigenmodel_mcmc(A, same.off, R=2, S=11000, burn = 10000)

#6.27
lat.sp.1 <- eigen(lazega.leig.fit1$ULU_postmean)$vec[, 1:2]
lat.sp.2 <- eigen(lazega.leig.fit2$ULU_postmean)$vec[, 1:2]
lat.sp.3 <- eigen(lazega.leig.fit3$ULU_postmean)$vec[, 1:2]

#6.28
colbar <- c("red", "dodgerblue", "goldenrod")
v.colors <- colbar[V(lazega)$Office]
v.shapes <- c("circle", "square") [V(lazega)$Practice]
v.size <- 3.5*sqrt(V(lazega)$Years)
v.label <- V(lazega)$Seniority
plot(lazega, layout=lat.sp.1, vertex.color=v.colors, vertex.shape = v.shapes, vertex.size = v.size,
     vertex.label=v.label)

#6.29
apply(lazega.leig.fit1$L_postsamp, 2, mean)
apply(lazega.leig.fit2$L_postsamp, 2, mean)
apply(lazega.leig.fit3$L_postsamp, 2, mean)

#6.30
perm.index <- sample(1:630)
nfolds <- 5
nmiss <- 630/nfolds
Avec <- A[lower.tri(A)]
Avec.pred1 <- numeric(length(Avec))

#6.31
for(i in seq(1, nfolds))   {
  #index of missing values.
  miss.index <- seq(((i-1) * nmiss +1), (i * nmiss), 1)
  A.miss.index <- perm.index[miss.index]
  
  #Fill a new Atemp appropriately with NA's.
  Avec.temp <- Avec
  Avec.temp [A.miss.index] <- rep("NA", length(A.miss.index))
  Avec.temp <- as.numeric(Avec.temp)
  Atemp <- matrix(0, 36, 36)
  Atemp[lower.tri(Atemp)] <- Avec.temp
  Atemp <- Atemp + t(Atemp)
  
  #Now fit model and predict.
  Y <- Atemp
  
  model1.fit <- eigenmodel_mcmc(Y, R=2, S=11000, burn =10000)
  model1.pred <- model1.fit$Y_postmean
  model1.pred.vec <- model1.pred[lower.tri(model1.pred)]
  Avec.pred1[A.miss.index] <- model1.pred.vec[A.miss.index]
}

#6.32
library(ROCR)
pred1 <- prediction(Avec.pred1, Avec)
perf1 <- performance(pred1, "tpr", "fpr")
plot(perf1, col="blue", lwd=3)

# 6.33
perf1.auc <- performance(pred1, "auc")
slot(perf1.auc, "y.values")



