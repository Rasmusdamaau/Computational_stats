#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
int fibC2(int n) {
  int x = 0;
  int y = 1;
  int z = 1;
  for (int i = 0; i < n; ++i) {
    x = y;
    y = z;
    z = x + y;
  }
  return x;
}



/*** R
fibC2(8)

microbenchmark::microbenchmark(fibC2(8))
*/
