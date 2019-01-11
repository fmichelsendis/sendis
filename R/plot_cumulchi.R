#' Plot cumulative Chi-square function
#' 
#' @param df dataframe to consider (no default)
#' @export 
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
 

  #plot
  p<-plot_ly(df, x=~FULLID, y=~CUMUL, color=~LIBVER, type='scatter', mode='markers+lines')%>%
    layout(margin=m, xaxis=x_layout, yaxis=y_layout, showlegend=TRUE)%>%
    config(displayModeBar = 'hover',showLink=FALSE,senddata=FALSE,editable=FALSE,
           displaylogo=FALSE, collaborate=FALSE, cloud=FALSE,
           modeBarButtonsToRemove=c('select2d', 'lasso2d','hoverClosestCartesian','hoverCompareCartesian'))
  return(p)
}
