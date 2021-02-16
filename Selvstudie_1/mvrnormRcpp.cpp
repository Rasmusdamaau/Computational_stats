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
  mat mu_reppet = mat(d,0);
  for (int i = 0;i<n;i++){
    mu_reppet.insert_cols(i, mu);
  }
  mat output = mu_reppet + output_pre_mu;
  return output;
}


/*** R
mvrnormRcpp(mu = c(1,2), Sigma = matrix(c(3,1,1,4), nrow = 2, ncol = 2), n = 5)
*/
