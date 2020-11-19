################################################################################
# This script provides several simple examples of the Monte Carlo method.
# 
# Course: Applied Stochastic Process
# Instructor: CHEUNG Ying Lun
# Updated: 22 Oct 2020
################################################################################

rm(list = ls())
graphics.off()
set.seed(916)

###################################################
# Q1
###################################################

NTrial <- 5000

# Generate uniform random variables
X <- runif(NTrial, min = -1, max = 1)
Y <- runif(NTrial, min = -1, max = 1)

# Calculate g(X,Y) = 1(X^2 + Y^2 <= 1)
g <- ( X^2 + Y^2 ) <= 1

# Calculate pi = 4 * E(g)
pi_hat <- 4 * mean(g)

# Evaluate the performance
print(paste0("The value of pi_hat is ", pi_hat))
print(paste0("The value of pi is ", pi))


###################################################
# Q2
###################################################

rm(list = ls())

# Set parameter
NTrial <- 5000
set.seed(1625)
p <- 0.2

# Generate random number
X <- rgeom(NTrial, p)+1
#In R, rgeom measures the number of failure before
#the first success, i.e., X = 0 if an event succeed
#in the first round. Therefore, we have to add one
#back to match our definition.

# Perform the transformation
g1 <- X^3
g2 <- cos(X)
g3 <- exp(X-1)
g4 <- log(X)

# Analysze the statistical properties of g
summary(g1)
summary(g2)
summary(g3)
summary(g4)


###################################################
# Q3
###################################################

rm(list = ls())

#Set parameters
NTrial <- 5000
N <- c(10, 20, 100, 1000)
lambda <- 0.2

#Start simulation
S <- matrix(nrow = NTrial, ncol = 4)

for (i in 1:4){
  #Generate random numbers
  S[ ,i] <- replicate(NTrial, sum(rpois(N[i], lambda)))
}

#Analyze X
(mu <- colMeans(S))
(sigma <- apply(S, 2, sd))

#Plot histogram
x <- seq(-5, 5, 0.01)
par(mfrow = c(2,2))
for (i in 1:4) {
  hist((S[ , i] - mu[i]) / sigma[i], freq = FALSE, main = paste0("N = ",N[i]))
  lines(x, dnorm(x))
}


