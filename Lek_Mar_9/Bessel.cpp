#include <Rcpp.h>
#include <boost/math/common_factor.hpp>  // included in BH  
#include <boost/math/special_functions/bessel.hpp>
#include <cmath>
#include <math.h>



// [[Rcpp::depends(BH)]]    

using namespace Rcpp;

// [[Rcpp::export]]
double besselI_cpp(double x, double v){
  return boost::math::cyl_bessel_i(v,x);
}
