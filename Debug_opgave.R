set.seed(42)
M <- 1000
pts <- data.frame(x = runif(M), y = runif(M))

close_ids <- function(dist, bound) {
  closeid <- which(dist < bound & dist > 0)
  # if (all(!(dist < bound & dist > 0))) {
  #   closeid <- NA
  # }
  return(closeid)
}

close_data <- function(dist, bound, id, data) {
  closeid <- close_ids(dist, bound)
  if (!all(!(dist < bound & dist > 0))) {
  closedata <- data.frame(
    id1 = id, id2 = closeid,
    x1 = data$x[id], y1 = data$y[id],
    x2 = data$x[closeid], y2 = data$y[closeid]
  )
  return(closedata)
  }
}

close_pts <- function(data, bound) {
  rslt <- NULL
  dmat <- as.matrix(dist(data))
  for (i in 1:nrow(data)) {
    dist <- dmat[, i]
    rslt_i <- close_data(dist, bound, i, data)
    rslt <- rbind(rslt, rslt_i)
  }
  return(rslt)
}


pts_small <- head(pts, n = 10)
close_pts(pts_small, bound = 0.4)

close_pts(pts_small, bound = 0.2)


test <- which(c(1,2,3) > c(2,3,4))
is.integer(str(test))
