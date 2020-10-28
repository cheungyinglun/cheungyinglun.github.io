################################################################################
# This script shows the relations among Bernoulli, Binomial, Geometric, Poisson 
# and Exponential distributions.
# 
# Course: Applied Stochastic Process
# Instructor: CHEUNG Ying Lun
# Updated: 16 Sep 2020
################################################################################

rm(list = ls())
set.seed(2155)

# Set parameters

NTrial <- 1000
P <- 0.7
x <- seq(0, 50, by = 1)

# 1. Bernoulli distribution

X_Ber <- rbinom(NTrial, 1, P)
print(paste0("Success rate is ", sum(X_Ber)/NTrial*100, "%"))
hist(X_Ber)

# 2. Binomial distribution

n <- 30
X_Bin <- replicate(NTrial, sum(rbinom(n, 1, P)))
# Find P(X = i)
i <- 20
print(paste0("Theoretical probability of P(X = ", i, ") is ", dbinom(i, n, P)*100, "%"))
print(paste0("Empirical probability of P(X = ", i, ") is ", sum(X_Bin == i)/NTrial *100, "%"))
hist(X_Bin, breaks = x, freq = FALSE)
lines(x, dbinom(x, n, P))

# 3. Poisson distribution

lambda <- 10
n_Po <- 1000
P_Po <- lambda / n_Po
X_Po <- rbinom(NTrial, n_Po, P_Po)
# Find P(X = i)
i <- 4
print(paste0("Theoretical probability of P(X = ", i, ") is ", dpois(i, lambda)*100, "%"))
print(paste0("Empirical probability of P(X = ", i, ") is ", sum(X_Po == i)/NTrial *100, "%"))
hist(X_Po, breaks = x, freq = FALSE)
lines(x, dpois(x, lambda))

# 4. Geometric distribution

X_Geo <- replicate(NTrial, min(which(rbinom(n, 1, P) == 1)))
# Find P(X = i)
i <- 4
print(paste0("Theoretical probability of P(X = ", i, ") is ", dgeom(i, P)*100, "%"))
print(paste0("Empirical probability of P(X = ", i, ") is ", sum(X_Geo == i)/NTrial *100, "%"))
hist(X_Geo, breaks = x, freq = FALSE)
lines(x, dgeom(x, P))

# 5. Exponential distribution

lambda <- 1
n_Exp <- 1000
P_Exp <- lambda / n_Exp
X_Exp <- rgeom(NTrial, P_Exp)/n_Exp
# Find P(X < i)
i <- 1
print(paste0("Theoretical probability of P(X < ", i, ") is ", pexp(i, lambda)*100, "%"))
print(paste0("Empirical probability of P(X < ", i, ") is ", sum(X_Exp <= i)/NTrial *100, "%"))
hist(X_Exp, freq = FALSE)
lines(x/5, dexp(x/5, lambda))
