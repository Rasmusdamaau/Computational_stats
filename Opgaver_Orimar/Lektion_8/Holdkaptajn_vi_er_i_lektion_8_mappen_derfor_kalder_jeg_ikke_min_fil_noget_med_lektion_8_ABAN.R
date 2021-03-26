n <- 100
k <- 20 
brown <- function(t) {
  r <- rnorm(t-1, sd=sqrt(1/t))
  b <- c(0,cumsum(r))
  b
}

s_t <- function(t,x0, mu, sigma, b) {
  s <- x0*exp(sigma* b+ (mu- sigma^2/2)*t)
  s
}
bb <- brown(n)
plot.ts(bb)
t <- seq(1, n, 1)/n
s_t_1 <- s_t(t, 3, 0.05, 1, bb)
plot.ts(s_t_1)
x_t <- log(s_t_1/3)
plot.ts(x_t)

iv <- cumsum(diff(x_t)^2)
plot.ts(iv)


hat_sigma <- function(k, t) {
  aa <- 1/(1/n*k)*sum(diff(x_t[t:(t+k)])^2)
  aa
}
hat_sigma_bla <- c()
for (i in 1:n){
  hat_sigma_bla[i] <- hat_sigma(k,i)
}
plot.ts(hat_sigma_bla)




