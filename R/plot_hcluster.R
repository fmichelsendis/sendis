#' Plot hierarchical clustering
#'
#' @param df dataframe to consider (no default),
#' @import dplyr
#' @import ggplot2
#' @import scales
#' @import stats
#' @export
#'
plot_hc<- function(df, dmethod="euclidean", clustering="single", k){
  d<- dist(df, method = dmethod)
  hc <- hclust(d,method = clustering)
  memb<- cutree(hc, k)
  plot(hc)
  rect.hclust(hc, k = k, border = 2:6)
}
