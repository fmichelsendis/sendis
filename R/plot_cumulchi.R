#' plot cumulative Chi-square function
#'
#' @param df dataframe to consider (no default),
#' @import data.table
#' @import dplyr
#' @import plotly
#' @import splitstackshape
#' @export
#' @examples
#'
#' p<-plot_cumulchi(sendis)
#' print(p)
#'
plot_cumulchi<- function(df){
y_layout<-list(
    title='Chi2 build-up',
    showticklabels = TRUE,
    ticks = "outside",
    tick0 = 0,
    titlefont= list( family='Helvetica',
                     size='14',
                     color='gray'))
x_layout<-list(
    title='Benchmark Cases (arbitrary progression)',
    zeroline = TRUE,
    showline = FALSE,
    showgrid = FALSE,
    showticklabels = FALSE,
    titlefont= list( family='Helvetica',
                     size='14',
                     color='gray')
  )
  m <- list(l = 100,r = 0,b = 20,t = 50,pad = 0)

  #generate calculated columns :
  df<- df %>% mutate(
    COVERE=.data$CALCVAL/.data$EXPVAL,
    RESIDUAL = (.data$CALCVAL-.data$EXPVAL)/sqrt(.data$EXPERR^2 + .data$CALCERR^2))

  df$LIBVERA<-df$LIBVER
  df<-cSplit(as.data.table(df), "LIBVERA", "-")
  setnames(df, old=c("LIBVERA_1","LIBVERA_2"), new=c("LIB", "VER"))
  #tidy up
  df<-df%>%arrange(.data$INST, .data$LIBVER, .data$CASETYPE)

  #create a vector for number of cases calculated for each LIBVER
  d<-dplyr::count(df, .data$INST, .data$LIBVER)  # d has 3 columns : INST, LIBVER and n
  d$NCASES<-d$n  #change name of computed n to NCASES

  #merge to put NCASES in df2, then mutate:
  df2<-merge(df, d, by = c("INST", "LIBVER"))

  df2<-df2%>%select(.data$INST, .data$LIBVER, .data$CASETYPE, .data$FULLID, .data$RESIDUAL, .data$NCASES)%>%
    dplyr::arrange(.data$INST, .data$LIBVER, .data$CASETYPE, .data$FULLID)%>%
    dplyr::group_by(.data$INST, .data$LIBVER)%>%
    dplyr::mutate(
      CUMUL=cumsum(.data$RESIDUAL^2/.data$NCASES),
      CHISQ= sum (.data$RESIDUAL^2/.data$NCASES))

  #plot
  p<-plot_ly(df2, x=~FULLID, y=~CUMUL, color=~LIBVER, type='scatter', mode='markers+lines')%>%
    layout(margin=m, xaxis=x_layout, yaxis=y_layout, showlegend=TRUE)%>%
    config(displayModeBar = 'hover',showLink=FALSE,senddata=FALSE,editable=FALSE,
           displaylogo=FALSE, collaborate=FALSE, cloud=FALSE,
           modeBarButtonsToRemove=c('select2d', 'lasso2d','hoverClosestCartesian','hoverCompareCartesian'))
  return(p)
}
