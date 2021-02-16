#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
NumericVector Ax1(NumericMatrix A, NumericVector x){
  int nr = A.nrow(), nc = A.ncol();
  NumericVector y(nr); // y is initalized to zero
  for (int i=0; i<nr; i++){ // loop over rows
    for (int j=0; j<nc; j++){
      y[i] += A(i,j) * x[j]; // find inner product
    }
  }
  return y;
}

// [[Rcpp::export]]
Rcpp::NumericVector Ax2(Rcpp::NumericMatrix A, Rcpp::NumericVector x) {
  int nr = A.nrow();
  int  nc = A.ncol();
  Rcpp::NumericVector a(nc);
  Rcpp::NumericVector y(nr);
  for (int i = 0; i < nr; i++){
    a(i) = A(i,)
    for (int j = 0; j < nc; j++) {
      y += 
    }
  }
}



/*** R
Ax1(matrix(c(1,1,1,1), nrow = 2, ncol = 2), c(1,1))
*/