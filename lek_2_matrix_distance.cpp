#include <RcppArmadillo.h>
//[[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp;
using namespace arma;

// [[ Rcpp :: export ]]
int totaldist1_cpp(mat X) {
  int result = X.n_rows;
 return result;
}


/*** R
# set.seed(42)
# M <- 1000
# pts <- data.frame(x = runif(M), y = runif(M))
# 
# dmat <- as.matrix(dist(pts))
# 
# totaldist1 <- function(x){
#   rslt <- numeric(nrow(x))
#   for(i in seq_len(nrow(x))){
#     rslt[i] <- sum(x[i,])
#   }
#   return(rslt)
# }

dmat <- matrix(1:9,nrow = 3)

totaldist1_cpp(dmat)


*/
