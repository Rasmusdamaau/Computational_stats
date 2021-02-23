

sim_BM <- function(T_, delta) {
  tmesh <- 1:delta/delta
  N <- length(tmesh)
  step <- 1/delta
  Norm <- rnorm(N-1)
  B <- c(0,cumsum(sqrt(step) * Norm))
  plot(x = tmesh, y = B, type = "l")
}


set.seed(2)
sim_BM(1,1000)
