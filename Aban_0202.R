install.packages("Rcpp")
library(Rcpp)
library(microbenchmark)
cppFunction('double add(double x, double y){return x+y;}')
add(1, 2)


fibR <- function(n){
  if (n==0) return(0)
  if (n==1) return(1)
  return( fibR( n-1 ) + fibR( n-2 ) )
}


cppFunction(
  "int fibC(const int x) {
if (x == 0) return(0);
if (x == 1) return(1);
return (fibC(x - 1)) + fibC(x - 2);
}")
fibC(8)



fibR2 <- function(n) {
  x = 0; y = 1; z = 1
  for (i in 1:n){
    x = y
    y = z
    z = x + y
  }
  x
}
fibR2(8)


cppFunction( "int fibC2(const int n){
             int x = 0; 
             int y = 1; 
             int z = 1; 
             for(int i=0; i < n; i++){
             x = y;
             y = z;
             z = x+y;
             }
             return x;
}")

fibC2(8)
f1 <- sapply(1:10, fibR2)
f2 <- sapply(1:10, fibC2)

all.equal( f1, f2 )

n <- 30
microbenchmark(fibR(n), fibC(n) ,fibR2(n),
               fibC2(n), times=20)



// [[ Rcpp :: export ]]

cppFunction("NumericVector Ax1_(NumericMatrix A , NumericVector x){
  int nr=A.nrow(), nc=A.ncol();
  NumericVector y(nr);
  for(int i=0; i<nr; i++){
    for(int j=0; j<nc; j++){
      y[i]+=A(i,j) * x[j]; 
    }
  }
  return y;
}")

cppFunction("NumericVector Ax2_(NumericMatrix A , NumericVector x){
  int nr=A.nrow(), nc=A.ncol();
  NumericVector y(nr);
  for(int i=0; i<nc; i++){
    for(int j=0; j<nr; j++){
    y[j]+=A(j,i)*x[i];
    }
  }
    return y;
}")


A <- matrix(1:30, ncol=3)
x=c(1, 2, 3)
y <- as.numeric(A %*% x)
y1 <- Ax1_(A,x)
y2 <- Ax2_(A,x)

y1 == y2

microbenchmark(Ax1_(A,x), Ax2_(A,x), times=1000)

