#############################################
#                                           #    
#               APP SENDIS                  #
#  Author: F.Michel-Sendis                  #
#                                           #  
#############################################

if (system.file(package="DT") == "")          install.packages("DT")
if (system.file(package="data.table") == "")  install.packages("data.table")
if (system.file(package="dplyr") == "")       install.packages("dplyr")
if (system.file(package="shiny") == "")       install.packages("shiny")
if (system.file(package="stringr") == "")     install.packages("stringr")
if (system.file(package="plotly") == "")      install.packages("plotly")
if (system.file(package="ggplot2") == "")     install.packages("ggplot2")
if (system.file(package="shinydashboard") == "") install.packages("shinydashboard")
if (system.file(package="shinythemes") == "") install.packages("shinythemes")
if (system.file(package="shinyjs") == "")     install.packages("shinyjs")
if (system.file(package="splitstackshape") == "") install.packages("splitstackshape")
if (system.file(package="testthat") == "")    install.packages("testthat")
if (system.file(package="devtools") == "")    install.packages("devtools")  


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
library(sendis)
})

#sens<-sendis::sens%>%arrange(ISOTOPE)
df<-sendis::sendis
 

