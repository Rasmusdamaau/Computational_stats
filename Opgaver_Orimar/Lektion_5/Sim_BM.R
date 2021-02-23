

sim_BM <- function(T_, delta) {
  tmesh <- seq(from = 0, to = T_, by = delta)
  N <- length(tmesh)
  step <- delta
  Norm <- rnorm(N-1)
  B <- c(0,cumsum(sqrt(step) * Norm))
  return(B)
  # plot(x = tmesh, y = B, type = "l")
}


set.seed(2)

b <- function(t, X_t) {
  -X_t
}

sigma <- function(t, X_t) {
  1
}

Euler_scheme <- function(delta, T_ = 1, b, sigma, x_0 = 0) {
  N_n <- ceiling(T_ / delta)
  tmesh <- seq(from = 0, to = T_, by = delta)
  B <- sim_BM(T_, delta)
  X <- c(x_0)
  for (k in 2:(N_n-1)) {
    X[k] <- X[k-1] + b(k,X[k-1])*delta + sigma(k,X[k-1])*(B[k] - B[k-1])
  }
  return(X)
}


Euler_scheme(delta = 1/1000, T_ = 1, b = b, sigma = sigma, x_0 = 0)
