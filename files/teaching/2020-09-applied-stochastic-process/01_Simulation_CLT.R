################################################################################
# This script demonstrates the Law of Large Number and Central Limit Theorem
# 
# Course: Applied Stochastic Process
# Instructor: CHEUNG Ying Lun
# Updated: 16 Sep 2020
################################################################################

rm(list = ls())
set.seed(2243)

#Set parameters
NTrial <- 1000
N <- c(5, 10, 100, 1000)
n_bin <- 5
p_bin <- 0.4

mu <- n_bin * p_bin
sigma <- sqrt(n_bin * p_bin * (1-p_bin))

#Start simulation

X <- matrix(nrow = NTrial, ncol = 4)

for (i in 1:4){
  #Generate random numbers
  X[ ,i] <- replicate(NTrial, mean(rbinom(N[i], n_bin, p_bin)))
}

#Analyze X
summary(X)
apply(X, 2, sd)

#Plot histogram
x <- seq(-5, 5, 0.01)
par(mfrow = c(2,2))
for (i in 1:4) {
  hist(sqrt(N[i]) * (X[ , i] - mu) / sigma, freq = FALSE, main = paste0("N = ",N[i]))
  lines(x, dnorm(x))
}