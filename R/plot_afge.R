#' Plot C over E vs AFGE
#'
#' @param df dataframe to consider (no default),
#' @import dplyr
#' @import ggplot2
#' @import scales
#' @export
#'
plot_afge<-function(df){
  g<-ggplot(df, aes(x= .data$AFGE)) + 
    geom_point(aes(y= .data$COVERE, colour= .data$LIBVER, 
                   shape= .data$FISS, alpha=0.8)) +
    geom_ribbon(aes(ymin = 1-.data$EXPERR,
                    ymax= 1+.data$EXPERR, alpha=0.2)) +
    labs(x = "Average energy of neutron causing fission (eV)", y = "C/E")+
    scale_x_log10(breaks = trans_breaks("log10", function(x) 10^x),
                  labels = trans_format("log10", math_format(10^.x)))+
    annotation_logticks(sides = "b") +
    theme_bw()+ theme(legend.title = element_blank())
return(g)
}
