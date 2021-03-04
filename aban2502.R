library(tidyverse)

sim_BM <- function(T_, delta) {
  tmesh <- seq(from = 0, to = T_, by = delta)
  N <- length(tmesh)
  step <- delta
  Norm <- rnorm(N)
  B <- c(0,cumsum(sqrt(step) * Norm[-length(Norm)]))
  output <- data.frame(B = B, Norm = Norm)
  return(output)
  # plot(x = tmesh, y = B, type = "l")
}



b <- function(t, X_t) {
  1
}

sigma <- function(t, X_t) {
  X_t
}

msigma <- function(t, X_t){
  1
}

Euler_scheme <- function(delta, T_ = 1, b, sigma, x_0 = 0) {
  N_n <- ceiling(T_ / delta)
  tmesh <- seq(from = 0, to = T_, by = delta)
  sim_BM_result <- sim_BM(T_, delta)
  B <- sim_BM_result$B
  Norm <- sim_BM_result$Norm
  X <- c(x_0)
  X_2 <- c(x_0)
  step <- delta * T_
  for (k in 2:(N_n-1)) {
    X[k] <- X[k-1] + b(k,X[k-1])*step + sigma(k,X[k-1])*(B[k] - B[k-1])
    X_2[k] <- exp(-step) * X_2[k-1] + sqrt(-1/2 * (1- exp(2*step))) * Norm[k]
  }
  output <- data.frame(sim_sol = X, real_sol = X_2)
  return(output)
}


delta <- 1/1000

result <- Euler_scheme(delta=delta, T_=1, b=b, sigma=sigma, x_0=1)
ggplot(data = result, aes(x=seq_len(nrow(result)), y = sim_sol)) +
  geom_line(color = "red") +
  geom_line(aes(x=seq_len(nrow(result)), y = real_sol))




Milstein_scheme <- function(delta, T_ = 1, b, sigma, msigma, x_0 = 0) {
  N_n <- ceiling(T_ / delta)
  tmesh <- seq(from = 0, to = T_, by = delta)
  sim_BM_result <- sim_BM(T_, delta)
  B <- sim_BM_result$B
  Norm <- sim_BM_result$Norm
  X <- c(x_0)
  X_2 <- c(x_0)
  step <- delta * T_
  for (k in 2:(N_n-1)) {
    X[k] <- X[k-1] + b(k,X[k-1])*step + sigma(k,X[k-1])*(B[k] - B[k-1])+
      1/2*sigma(k,X[k-1])*msigma(k, X[k-1])*((B[k]-B[k-1])^2-step)
    X_2[k] <- tan( atan(x_0)+tmesh[k]+ B[k])
  }
  output <- data.frame(sim_sol = X, real_sol = X_2)
  return(output)
}


set.seed(1)

delta <- 1/1000

mm <- Milstein_scheme(delta=delta, T_=1, b=b, sigma=sigma, msigma=msigma, x_0=1)
ggplot(data = mm, aes(x=seq_len(nrow(mm)), y = sim_sol)) +
  geom_line(color = "red") +
  geom_line(aes(x=seq_len(nrow(mm)), y = real_sol))







