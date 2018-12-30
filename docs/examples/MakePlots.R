library(sendis)
library(dplyr)
library(plotly)

#
#  Raw code for generating example plots 
#

# Plot 1

df<-sendis%>%
  select(-FISS, -FORM, -SPEC, -LIB, -VER)%>%
  build_splitcolumns()%>%
  mutate(EVALCASE = paste0(CASETYPE,"-",CASE))%>%
  #df<-sendis%>% #build_splitcolumns()%>%
  filter(LIBVER=="JEFF-2.2"|LIBVER=="JEFF-3.3", INST=="NEA", FISS=="PU")%>% 
  #filter(INST=="NRG")%>%
  group_by(EVALCASE)%>%
  mutate(
    MEAN_EXP_ERR = mean(EXPERR),
    MEAN_EALF = mean(EALF)
    )%>%
  arrange(CASETYPE)
  
df<-ungroup(df)

num<-df%>%select(EVALCASE)%>%unique()%>%mutate(NUM = 1:n())

df<-merge(df, num)

df<-merge(df, sens, all.x=TRUE, all.y =FALSE)%>%select(-REACTION)

  
p2<-ggplot(df, aes(x=EVALCASE, y=COVERE)) + 
  geom_boxplot(aes(colour= LIBVER), position=position_dodge(0.0)) + 
  geom_hline(yintercept =  1, lty = "dotted") +
  geom_ribbon(aes(x= NUM, ymin = 1-MEAN_EXP_ERR, ymax=1+MEAN_EXP_ERR),
              fill="gray",
              alpha=0.2) +
  labs(x = "", y="C/E") + 
  scale_y_continuous(
    sec.axis = dup_axis(),
    # sec.axis = dup_axis(
    #   trans = ~.*1e+5-1e+5,
    #name = TeX(\\Delta \\, (pcm)")),
    breaks = seq(-0.94, 1.12, by = 0.01),
    position = "bottom"
    )+
  coord_flip() + 
  theme_bw()
 
p2 
ggsave(plot = p2, 
       filename = "docs/examples/plot1.png", 
       dpi=400)
 
 
## Plot 2
df<-sendis%>%filter(LIB=="JEFF", INST=="NEA", FISS!="MIX") 
df$ZERO<-0

g<-ggplot(df, aes(x=ZERO, y= RESIDUAL, shape= FISS, colour= SPEC)) +
  geom_jitter(width=0.001, height=0) +
  facet_grid(.~VER)+
  geom_hline(yintercept =  3, lty = "dotted") +
  geom_hline(yintercept = -3, lty = "dotted") +
  ylim(-25,25)+
  scale_x_continuous(breaks = seq(-10, 10, by = 20))+
  labs(y = "Normalized bias",
       x = "JEFF release number", 
       title = "") +
  theme_bw()+
  theme(
    legend.title = element_blank(),
    panel.grid = element_blank()
    )

g 
ggsave(plot = g, 
       filename = "docs/examples/plot2.png", 
       dpi=400)

 
 

# First plot 
df<-filter(sendis, INST=="NEA", VER!="2.2")
p1<-plot_cumulchi(df)%>%
  layout(
    xaxis = list(
      title = "Benchmark suite"),
    yaxis = list(
      title = TeX("\\chi^2")))%>%
  config(mathjax = "cdn")
#orca prints plot to png :
orca(p1, "plotly1.png")

### iframe for plotly widgets
# use in Rmd : 
# htmlwidgets::saveWidget(p, "test.html")
# <iframe src="myplot.html" width="90%" height="450" id="igraph" scrolling="no" seamless="seamless" frameBorder="0"> </iframe>
 





