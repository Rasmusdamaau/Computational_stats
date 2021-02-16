#include <RcppArmadillo.h>
//[[Rcpp::depends(RcppArmadillo)]]

using namespace Rcpp ;
using namespace arma ;

// [[Rcpp::export]]
mat mvrnormRcpp(colvec mu, mat Sigma, int n) {
  int d = mu.size();
  mat std_norm = mat(d,n,fill::randn);
  mat chol_sigma = chol(Sigma);
  mat output_pre_mu = chol_sigma.t() * std_norm;
  output_pre_mu.each_col() + mu;
  return output_pre_mu;
}


// [[Rcpp::export]]
mat simcpp(mat A, mat Sigma, int n) {
  vec mu = vec(Sigma.n_rows);
  mu.fill(0);
  mat errors = mvrnormRcpp(mu, Sigma, n);
  mat simdata = mat(mu.size(),n,fill::zeros);
  for (int i = 1; i < n; i++){
    simdata.col(i) = A * simdata.col(i-1) + errors.col(i);
  }
  return simdata;
}


/*** R
simcpp(matrix(c(0.7,0.2,0.2,0.7),2,2), matrix(c(2,1,1,4), nrow = 2, ncol = 2), 50)
*/
