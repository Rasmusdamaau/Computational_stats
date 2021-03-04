#include <Rcpp.h>

using namespace Rcpp ;


// [[Rcpp::export]]
NumericVector EM_cpp(double alpha, double sigma, double Deltat, NumericVector DeltaW, double S1) {
  int N = DeltaW.size();
  NumericVector Y(N+1);
  Y[0] = S1;
  for (int i = 0; i < N; ++i) {
    Y[i+1] = Y[i] + alpha * Y[i] * Deltat + sigma * Y[i] * DeltaW[i];
    }
  return Y;
}


/*** R
N <- 2^7
T <- 1
Deltat <- T/N
W <- numeric(N+1)
t <- seq(0, T, length.out = N+1)
DeltaW <- rnorm(N, 0, sqrt(Deltat))
W <- c(0, cumsum(DeltaW))

S <- numeric(N+1)
S[1] <- 1
alpha <- 1
sigma <- 1
S <- S[1]*exp((alpha-.5*sigma^2)*t+sigma*W)
  
EM_R <- function(alpha, sigma, Deltat, DeltaW, S1){
  Y <- numeric(N+1)
  Y[1] <- S1
  for(i in 1:N){
    Y[i+1] <- Y[i] + alpha*Y[i]*Deltat + sigma*Y[i]*DeltaW[i]
  }
  return(Y)
}
microbenchmark::microbenchmark(
  res_R <- EM_R(alpha, sigma, Deltat, DeltaW, S[1]),
  res_cpp <- EM_cpp(alpha, sigma, Deltat, DeltaW, S[1]),
  times = 10
)
res_R <- EM_R(alpha, sigma, Deltat, DeltaW, S[1])
res_cpp <- EM_cpp(alpha, sigma, Deltat, DeltaW, S[1])
all.equal(res_R, res_cpp)
Y <- res_R
matplot(t, cbind(S,Y), type = "l", col = 1:2)
*/
