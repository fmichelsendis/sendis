#' Plot C over E vs EALF.
#'
#' @param df dataframe to consider (no default),
#' @import dplyr
#' @import ggplot2
#' @import scales
#' @export
#' @examples
#'
#' plot_ealf(sendis)
#'
plot_ealf<- function(df){
#   g<-ggplot() +
#     geom_ribbon(df, aes(x= EALF, ymin = 1-EXPERR, ymax= 1+EXPERR), alpha=0.2) +
#     geom_point(df, aes(x= EALF, y= COVERE, colour= LIBVER, shape= FISS), alpha=0.8) +
#     labs(x = "Average energy of neutron causing fission (eV)", y = "C/E")+
#     scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
#                   labels = trans_format("log10", math_format(10^.x)))+
#     annotation_logticks(sides = "b") +
#     theme_bw()+ theme(legend.title = element_blank())
# return(g)
return(0)
}
