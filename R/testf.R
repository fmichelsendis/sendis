#' Test function.
#'
#' @param df1 dataframe to consider (no default).
#' @import dplyr
#' @export
#' @examples
#' head(sendis)
#' testf(sendis)
#'
testf<- function(df1){

d<-df1%>%
  dplyr::filter(.data$INST=="NEA")%>%
  dplyr::mutate(NEW = .data$LIBVER)

return(dim(d))
}
