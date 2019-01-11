#' Plot scree plot for clustering analysis
#' 
#' @param df dataframe to consider (no default)
#' @export 
plot_scree<- function(df, cmax=20, nstart=20){
  set.seed(6613) 
  
  wss<-0
  bss<-0
  tss<-0
  
  # Explore 1 to cmax cluster centers
  for (i in 1:cmax) {
    km <- kmeans(df, centers = i, nstart=nstart)
    # Save total within sum of squares to wss variable
    wss[i] <- km$tot.withinss
    bss[i] <- km$betweenss 
    tss[i] <- km$totss
  }
  
  scree_df <- data.frame("Clusters" = 1:cmax, "WSS" = wss, "BSS" = bss, "TSS"=tss)
  
  p<-ggplot(scree_df, aes(x=Clusters, y=WSS/TSS))+
    geom_point()+
    geom_line()+
    geom_hline(yintercept = 0.2, colour='red', linetype='dashed')+
    theme_minimal()
  
return(p)

}

