#############################################
#                                           #    
#               APP SENDIS                  #
#  Author: F.Michel-Sendis                  #
#                                           #  
#############################################
suppressPackageStartupMessages({
library(DT)
library(data.table)
library(tidyverse)
library(shiny) 
library(stringr)
library(plotly)
library(ggplot2)
library(shinydashboard)
library(shinythemes)
library(shinyjs)  
library(splitstackshape)
library(devtools)
})
sens<-sendis::sens%>%arrange(ISOTOPE)
df<-sendis::sendis
 

