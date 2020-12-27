################################################################################
# This script simulates a branching process.
# 
# Course: Applied Stochastic Process
# Instructor: CHEUNG Ying Lun
# Updated: 23 Nov 2020
################################################################################

###################################################
#Initialize
rm(list = ls())
graphics.off()
set.seed(1542)

###################################################
#Set parameters
NTrial <- 500
R0 <- 2.3
Re <- c(0.8, 1.2, 1.8)
InitialT <- 8
FinalT <- 13

###################################################
#Declare a function of branching process
branching <- function(R0, Re, T1, T2) {
  
  #Initialize
  NPath0 <- vector(mode = "integer", length = T1+1)
  NPath0[1] <- 1
  
  NPath1 <- matrix(nrow = T1+T2+1, ncol = length(Re))
  
  #Calculate the parameter of the Geometric distribution
  p0 <- 1 / (R0+1)
  pe <- 1 / (Re+1)
  t <- 1
  
  #Start simulation
  ########
  #Before controlling policies
  while (t <= T1 & NPath0[t]!=0) {
    #NPath0[t+1] <- sum(rgeom(NPath0[t], p0))
    NPath0[t+1] <- rnbinom(1, NPath0[t], p0)
    t <- t+1
  }
  #Terminate if NPath0[t] == 0
  if (NPath0[t]==0) {
    NPath0[t:(T1+1)] <- 0
    NPath1[1:(T1+1), ] <- NPath0
    NPath1[(T1+2):(T1+T2+1), ] <- 0
    return(NPath1)
  }  
  
  ########
  #After controlling policies
  for (iR in 1:length(Re)) {
    NPath1[1:(T1+1), iR] <- NPath0
    t <- 1
    while (t <= T2 & NPath1[t+T1, iR]!=0) {
      #NPath1[t+T1+1, iR] <- sum(rgeom(NPath1[t+T1, iR], pe[iR]))
      NPath1[t+T1+1, iR] <- rnbinom(1, NPath1[t+T1, iR], pe[iR])
      t <- t+1
    }
    if (NPath1[t+T1, iR]==0) {
      NPath1[(t+T1):(T1+T2+1), iR] <- 0
    }
  }
  
  return(NPath1)
}

###################################################
#Simulate the branching process
Ncases <- replicate(NTrial, branching(R0, Re, InitialT, FinalT))

###################################################
#Q1
print(paste("The mean number of new cases today is",
            mean(Ncases[InitialT, 1, ])))
print(paste("The variance of new cases today is",
            var(Ncases[InitialT, 1, ])))
###################################################
#Q2
par(mfrow = c(1,length(Re)))
for (i in 1:length(Re)) {
  plot((-InitialT):FinalT, rowMeans(Ncases[, i, ]), type = "b")
}
###################################################
#Q3
Ncases2 <- Ncases[ , , Ncases[8, 1, ] != 0]
for (i in 1:length(Re)) {
  print(paste("The probability of zero new cases under strategy",
              i,
              "is:",
              mean(Ncases2[(InitialT+FinalT+1), i, ] == 0)*100,
              "%."))
}