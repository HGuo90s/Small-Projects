# Math 189 Case Study 2, Video Game Player
# Script created by 02/07/2019
# Last Edited 02/16/2019

data=read.table("videodata.txt",header=T)
datafollow=read.table("followupsurvey.txt",header=T)
# People that should be excluded from the follow-up survey
data.ne.ind<-which(data["like"]==1)
data.naa.ind<-which(data["like"]==5)
length(data.ne.ind)+length(data.naa.ind)
# Scenario 04 Attitude
# new dataset
datafu.ind<-which(is.na(datafollow["relax"])==FALSE)
datafu<-datafollow[datafu.ind,]
length(datafu.ind) # 87 students returned useful answer
# Functions to get probability and number of 1s
get1s=function(data,string) {
  string.ind<-which(data[string]==1)
  return(length(string.ind))
}
getp=function(data,string){
  string.ind<-which(data[string]==1)
  stringnon.ind<-which(data[string]==0)
  prob=0
  prob=length(string.ind)/(length(stringnon.ind)+length(string.ind))
  return(prob)
}
library(boot)
library(moments)
# Types of video games played
get1s(datafu,"action")
getp(datafu,"action")
get1s(datafu,"adv")
getp(datafu,"adv")
get1s(datafu,"sim")
getp(datafu,"sim")
get1s(datafu,"sport")
getp(datafu,"sport")
get1s(datafu,"strategy")
getp(datafu,"strategy")
boot.popaction<-rep(datafu$action,length.out=314)
boot.popadv<-rep(datafu$adv,length.out=314)
boot.popsim<-rep(datafu$sim,length.out=314)
boot.popspo<-rep(datafu$spo,length.out=314)
boot.popstr<-rep(datafu$str,length.out=314)
sample.action<-sample(boot.popaction,size=87,replace=FALSE)
sample.adv<-sample(boot.popadv,size=87,replace=FALSE)
sample.sim<-sample(boot.popsim,size=87,replace=FALSE)
sample.spo<-sample(boot.popspo,size=87,replace=FALSE)
sample.str<-sample(boot.popstr,size=87,replace=FALSE)
B=400 
boot.action<-array(dim=c(B, 91))
boot.adv<-array(dim=c(B, 91))
boot.sim<-array(dim=c(B, 91))
boot.spo<-array(dim=c(B, 91))
boot.str<-array(dim=c(B, 91))
set.seed(901)
for (i in 1:B) {
  boot.action[i,]<-sample(boot.popaction,size=91,replace=FALSE)
}
simul.act<-apply(X=boot.action,MARGIN=1,FUN=mean)
set.seed(902)
for (i in 1:B) {
  boot.adv[i,]<-sample(boot.popadv,size=91,replace=FALSE)
}
simul.adv<-apply(X=boot.adv,MARGIN=1,FUN=mean)
set.seed(903)
for (i in 1:B) {
  boot.sim[i,]<-sample(boot.popsim,size=91,replace=FALSE)
}
simul.sim<-apply(X=boot.sim,MARGIN=1,FUN=mean)
set.seed(904)
for (i in 1:B) {
  boot.spo[i,]<-sample(boot.popspo,size=91,replace=FALSE)
}
simul.spo<-apply(X=boot.spo,MARGIN=1,FUN=mean)
set.seed(905)
for (i in 1:B) {
  boot.str[i,]<-sample(boot.popstr,size=91,replace=FALSE)
}
simul.str<-apply(X=boot.str,MARGIN=1,FUN=mean)
plot(density(simul.act),col="palevioletred",ylim=c(0,20),xlim=c(0,1),lwd=2,
     main="Density of Bootstrapped Probability of Playing Different Types of Video Games",
     xlab="Bootstrapped Sample Proportion")
lines(density(simul.adv),col="lightsteelblue",lwd=2)
lines(density(simul.sim),col="lightgreen",lwd=2)
lines(density(simul.spo),col="wheat",lwd=2)
lines(density(simul.str),col="plum",lwd=2)
legend("topright", legend=c("Action", "Adventure","Simulation","Sports","Strategy"),
       col=c("palevioletred", "lightsteelblue","lightgreen","wheat","plum"), 
       lty=1:1, cex=1)
# Normality check of the density graph of means
skewness(simul.act)
skewness(simul.adv)
skewness(simul.sim)
skewness(simul.spo)
skewness(simul.str)
kurtosis(simul.act)
kurtosis(simul.adv)
kurtosis(simul.sim)
kurtosis(simul.spo)
kurtosis(simul.str)
# Statistical difference
# Strategy vs Action
sdstr=sd(simul.str)
nstr=length(simul.str)
meanstr=mean(simul.str)
errorstr<-qnorm(0.975)*sdstr/sqrt(nstr)
leftstr<-meanstr-errorstr
rightstr<-meanstr+errorstr
leftstr
rightstr
sdact=sd(simul.act)
nact=length(simul.act)
meanact=mean(simul.act)
erroract<-qnorm(0.975)*sdact/sqrt(nact)
leftact<-meanact-erroract
rightact<-meanact+erroract
leftact
rightact
# Simulation vs Adventure
sdadv=sd(simul.adv)
nadv=length(simul.adv)
meanadv=mean(simul.adv)
erroradv<-qnorm(0.975)*sdadv/sqrt(nadv)
leftadv<-meanadv-erroradv
rightadv<-meanadv+erroradv
leftadv
rightadv
sdsim=sd(simul.sim)
nsim=length(simul.sim)
meansim=mean(simul.sim)
errorsim<-qnorm(0.975)*sdsim/sqrt(nsim)
leftsim<-meansim-errorsim
rightsim<-meansim+errorsim
leftsim
rightsim
t.test(simul.str,simul.act)
t.test(simul.sim,simul.adv)
# Reasons to play video games
get1s(datafu,"relax")
getp(datafu,"relax")
get1s(datafu,"coord")
getp(datafu,"coord")
get1s(datafu,"challenge")
getp(datafu,"challenge")
get1s(datafu,"master")
getp(datafu,"master")
get1s(datafu,"bored")
getp(datafu,"bored")
get1s(datafu,"graphic")
getp(datafu,"graphic")
boot.poprel<-rep(datafu$relax,length.out=314)
boot.popgra<-rep(datafu$graphic,length.out=314)
boot.popcoord<-rep(datafu$coord,length.out=314)
boot.popcha<-rep(datafu$challenge,length.out=314)
boot.popma<-rep(datafu$master,length.out=314)
boot.popbo<-rep(datafu$bored,length.out=314)
sample.relax<-sample(boot.poprel,size=87,replace=FALSE)
sample.gra<-sample(boot.popgra,size=87,replace=FALSE)
sample.coord<-sample(boot.popcoord,size=87,replace=FALSE)
sample.cha<-sample(boot.popcha,size=87,replace=FALSE)
sample.ma<-sample(boot.popma,size=87,replace=FALSE)
sample.bo<-sample(boot.popbo,size=87,replace=FALSE)
B=400 
boot.relax<-array(dim=c(B, 91))
boot.gra<-array(dim=c(B, 91))
boot.coord<-array(dim=c(B, 91))
boot.cha<-array(dim=c(B, 91))
boot.ma<-array(dim=c(B, 91))
boot.bo<-array(dim=c(B, 91))
set.seed(1001)
for (i in 1:B) {
  boot.relax[i,]<-sample(boot.poprel,size=91,replace=FALSE)
}
simul.relax<-apply(X=boot.relax,MARGIN=1,FUN=mean)
set.seed(1002)
for (i in 1:B) {
  boot.gra[i,]<-sample(boot.popgra,size=91,replace=FALSE)
}
simul.gra<-apply(X=boot.gra,MARGIN=1,FUN=mean)
set.seed(1003)
for (i in 1:B) {
  boot.coord[i,]<-sample(boot.popcoord,size=91,replace=FALSE)
}
simul.coord<-apply(X=boot.coord,MARGIN=1,FUN=mean)
set.seed(1004)
for (i in 1:B) {
  boot.cha[i,]<-sample(boot.popcha,size=91,replace=FALSE)
}
simul.cha<-apply(X=boot.cha,MARGIN=1,FUN=mean)
set.seed(1005)
for (i in 1:B) {
  boot.ma[i,]<-sample(boot.popma,size=91,replace=FALSE)
}
simul.ma<-apply(X=boot.ma,MARGIN=1,FUN=mean)
set.seed(1006)
for (i in 1:B) {
  boot.bo[i,]<-sample(boot.popbo,size=91,replace=FALSE)
}
simul.bo<-apply(X=boot.bo,MARGIN=1,FUN=mean)
plot(density(simul.relax),col="palevioletred",ylim=c(0,30),xlim=c(0,1),lwd=2,
     main="Density of Bootstrapped Sample Proportion of Reasons to Play Games",
     xlab="Bootstrapped Sample Proportion")
lines(density(simul.gra),col="lightsteelblue",lwd=2)
lines(density(simul.coord),col="lightgreen",lwd=2)
lines(density(simul.cha),col="wheat",lwd=2)
lines(density(simul.ma),col="plum",lwd=2)
lines(density(simul.bo),col="lightskyblue",lwd=2)
legend("topright", legend=c("Relaxation", "Eye/Hand Coordination","Mental Challenge",
                            "Feeling of Mastery","Bored","Graphics and Realism"),
       col=c("palevioletred", "lightgreen","wheat","plum","lightskyblue","lightsteelblue"), 
       lty=1:1, cex=1)
# KS-test for Eye-hand Coordination
ks.test(simul.coord,simul.cha,alternative="greater")

# Reasons not enjoying games
get1s(datafu,"time")
getp(datafu,"time")
get1s(datafu,"frust")
getp(datafu,"frust")
get1s(datafu,"lonely")
getp(datafu,"lonely")
get1s(datafu,"rules")
getp(datafu,"rules")
get1s(datafu,"cost")
getp(datafu,"cost")
get1s(datafu,"boring")
getp(datafu,"boring")
get1s(datafu,"friends")
getp(datafu,"friends")
get1s(datafu,"point")
getp(datafu,"point")
boot.poptime<-rep(datafu$time,length.out=314)
boot.popfrust<-rep(datafu$frust,length.out=314)
boot.poplonely<-rep(datafu$lonely,length.out=314)
boot.poprules<-rep(datafu$rules,length.out=314)
boot.popcost<-rep(datafu$cost,length.out=314)
boot.popboring<-rep(datafu$boring,length.out=314)
boot.popfriends<-rep(datafu$friends,length.out=314)
boot.poppoint<-rep(datafu$point,length.out=314)
sample.time<-sample(boot.poptime,size=87,replace=FALSE)
sample.frust<-sample(boot.popfrust,size=87,replace=FALSE)
sample.lonely<-sample(boot.poplonely,size=87,replace=FALSE)
sample.rules<-sample(boot.poprules,size=87,replace=FALSE)
sample.cost<-sample(boot.popcost,size=87,replace=FALSE)
sample.boring<-sample(boot.popboring,size=87,replace=FALSE)
sample.friends<-sample(boot.popfriends,size=87,replace=FALSE)
sample.point<-sample(boot.poppoint,size=87,replace=FALSE)
B=400 
boot.time<-array(dim=c(B, 91))
boot.frust<-array(dim=c(B, 91))
boot.lonely<-array(dim=c(B, 91))
boot.rules<-array(dim=c(B, 91))
boot.cost<-array(dim=c(B, 91))
boot.boring<-array(dim=c(B, 91))
boot.friends<-array(dim=c(B, 91))
boot.point<-array(dim=c(B, 91))
set.seed(1010)
for (i in 1:B) {
  boot.time[i,]<-sample(boot.poptime,size=91,replace=FALSE)
}
simul.time<-apply(X=boot.time,MARGIN=1,FUN=mean)
set.seed(1011)
for (i in 1:B) {
  boot.frust[i,]<-sample(boot.popfrust,size=91,replace=FALSE)
}
simul.frust<-apply(X=boot.frust,MARGIN=1,FUN=mean)
set.seed(1012)
for (i in 1:B) {
  boot.lonely[i,]<-sample(boot.poplonely,size=91,replace=FALSE)
}
simul.lonely-apply(X=boot.lonely,MARGIN=1,FUN=mean)
set.seed(1013)
for (i in 1:B) {
  boot.rules[i,]<-sample(boot.poprules,size=91,replace=FALSE)
}
simul.rules<-apply(X=boot.rules,MARGIN=1,FUN=mean)
set.seed(1014)
for (i in 1:B) {
  boot.cost[i,]<-sample(boot.popcost,size=91,replace=FALSE)
}
simul.cost<-apply(X=boot.cost,MARGIN=1,FUN=mean)
set.seed(1015)
for (i in 1:B) {
  boot.boring[i,]<-sample(boot.popboring,size=91,replace=FALSE)
}
simul.bor<-apply(X=boot.boring,MARGIN=1,FUN=mean)
set.seed(1016)
for (i in 1:B) {
  boot.friends[i,]<-sample(boot.popfriends,size=91,replace=FALSE)
}
simul.fri<-apply(X=boot.friends,MARGIN=1,FUN=mean)
set.seed(1017)
for (i in 1:B) {
  boot.point[i,]<-sample(boot.poppoint,size=91,replace=FALSE)
}
simul.poi<-apply(X=boot.point,MARGIN=1,FUN=mean)
plot(density(simul.time),col="palevioletred",ylim=c(0,65),xlim=c(-0.1,1),lwd=2,
     main="Density of Bootstrapped Sample Proportion of Reasons not Enjoying Games",
     xlab="Bootstrapped Sample Proportion")
lines(density(simul.frust),col="lightsteelblue",lwd=2)
lines(density(simul.lonely),col="lightgreen",lwd=2)
lines(density(simul.rules),col="wheat",lwd=2)
lines(density(simul.cost),col="plum",lwd=2)
lines(density(simul.bor),col="lightskyblue",lwd=2)
lines(density(simul.fri),col="chocolate1",lwd=2)
lines(density(simul.poi),col="cyan",lwd=2)
legend("topright", legend=c("Too much Time", "Frustrating","Lonely","Too many Rules",
                            "Costs too much","Boring","Friends don't play","Pointless"),
       col=c("palevioletred","lightsteelblue","lightgreen","wheat","plum","lightskyblue",
             "chocolate1","cyan"), lty=1:1, cex=1)
# Normality Check
skewness(simul.time)
kurtosis(simul.time)
skewness(simul.cost)
kurtosis(simul.cost)
skewness(simul.poi)
kurtosis(simul.poi)
skewness(simul.frust)
kurtosis(simul.frust)
t.test(simul.time,simul.cost)
# Extended discussion
pedu=8/91
sim=rbinom(91,1,pedu)
boot.popedu<-rep(sim,length.out=314)
sample.edu<-sample(boot.popedu,size=91,replace=FALSE)
B=400 
boot.edu<-array(dim=c(B, 91))
set.seed(1201)
for (i in 1:B) {
  boot.edu[i,]<-sample(boot.popedu,size=91,replace=FALSE)
}
simul.edu<-apply(X=boot.edu,MARGIN=1,FUN=mean)
plot(density(simul.relax),col="palevioletred",ylim=c(0,30),xlim=c(0,1),lwd=2,
     main="Density of Bootstrapped Sample Proportion of Reasons to Play Games",
     xlab="Bootstrapped Sample Proportion")
lines(density(simul.gra),col="lightsteelblue",lwd=2)
lines(density(simul.coord),col="lightgreen",lwd=2)
lines(density(simul.cha),col="wheat",lwd=2)
lines(density(simul.ma),col="plum",lwd=2)
lines(density(simul.bo),col="lightskyblue",lwd=2)
lines(density(simul.edu),col="cyan",lwd=2)
legend("topright", legend=c("Relaxation", "Eye/Hand Coordination","Mental Challenge",
                            "Feeling of Mastery","Bored","Graphics and Realism",
                            "Educational"),
       col=c("palevioletred", "lightgreen","wheat","plum","lightskyblue","lightsteelblue"
             ,"cyan"), 
       lty=1:1, cex=1)
# KS-Test
ks.test(simul.coord,simul.edu,alternative="greater")
ks.test(simul.edu,simul.cha,alternative="greater")
