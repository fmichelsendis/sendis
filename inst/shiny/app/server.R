#############################################
#                                           #
#   SERVER SENDIS                           #
#                                           #  
#############################################

server <- function(input, output, session){
  addClass(selector = "body", class = "sidebar-collapse")

##################

  output$plot_isotopes<-renderPlotly({ 
    
    
    lib_list<-input$LIBS
    inst<-input$INST
    isotope<-input$ISOTOPE
    reaction= input$REACTION
    
    reaction_name<-paste0(isotope, "_",reaction)
    
    
    # Prepping data using exps data frame, cleaning to get only numerical columns
    # exp_df is a dataframe with only numerical values, a subset of the exps data
    
    r<-filter(sendis, INST==inst, LIBVER%in%lib_list, MODEL=="Only") %>%
      select(FULLID, LIBVER, INST, EALF, RESIDUAL)%>%
      unique()
    
    mats<-fread("data/mats_used.csv")
    mats<-mats%>%
      mutate(ISOTOPE=paste0(NAME,A))%>%
      select(-V1, -M2, -MAT, -M, -N)
    
    s<-sens%>%
      mutate(IR = paste0(ISOTOPE, "_", REACTION))%>%
      merge(mats, by = "ISOTOPE")%>%
      na.omit()
    
    # analysis is done on generic name df :
    # keep onlu U-235 data and only KSENSTOT, spread by reaction : 
    df<-filter(s, ISOTOPE==isotope)%>%
      select(-ISOTOPE, -KSENS1, -KSENS2, -KSENS3)%>%
      filter(REACTION == reaction)  
    
    # making long data wider : 
    #df<-df%>% 
    #  spread(key = IR, value= KSENSTOT)%>%
    #  select(-REACTION, -Z, -A, -NAME)%>% 
    #  unique() 
    
    #replace all NA's with 0 : 
    df[is.na(df)] <- 0
    
    # Extremely important : group_by and summarize : 
    #df<-df %>% group_by(FULLID) %>% summarise_all(funs(sum))
    
    # merge with residuals :
    df<-merge(df, r, by=  "FULLID", all.y = FALSE)
    
    # revert rownames to columns 
    # df<-df%>%mutate(FULLID=rownames(.))
    
    #quo_var <- quo(reaction_name)
    #quo_var <- reaction_name
    p<-plot_ly(df, x=~KSENSTOT, y=~RESIDUAL, color=~LIBVER, text=~FULLID)
    p
    
    #g<-ggplot(df, aes(x=!!quo_var, y=RESIDUAL, color=LIBVER))+geom_point() 
    #g
  
  })
  
  
  
#############@
  
  
output$plot_cumul<-renderPlotly({ 
    
# selecting data 
    if("All" %in% input$CASETYPE3) df<-filter(df, INST==input$INST3, LIBVER %in% input$LIB3)
    else df<-filter(df, INST==input$INST3, LIBVER %in% input$LIB3, CASETYPE%in% input$CASETYPE3)
    df<-filter(df, df$RESIDUAL<= input$MAXRES)
    
    sendis::plot_cumulchi(df)
    
    })
    
#####################
  
  output$libs<-renderText({
    
    df1<-filter(df, INST==input$INST4)
    df1<- df1[order(df1$LIBVER),]
    text<-paste(unique(df1$LIBVER), " ; ")
    text
  })
  
  #########################################################################
  
  output$plot_histo<-renderPlotly({ 
    df1<-filter(df, INST==input$INST4, LIBVER==input$LIBVER4)
    # validate(
    #    need(dim(df1)[1]>0,"No entries found for this combination of libraries and institution")
    #  )
    m <- list(
      l = 140,
      r = 20,
      b = 00,
      t = 100,
      pad = 3
    )
    titlefont<-list( family='Helvetica',
                     size='12',
                     color='gray')
   

    if(dim(df1)[1]>0){
      N<-dim(df1)[1]
      title<-paste(N,"different cases in", input$INST4,"suite", "<br> Distribution per case family", sep=" ")
      
    p<-plot_ly(df1, y=~CASETYPE) %>%
      layout(margin = m, yaxis=list(title=''),title=title, font=titlefont)%>% 
      config(displayModeBar = FALSE)
    p 
    }
    else plotly_empty()
  })
  
  ###################################################
  
  output$table<-renderDataTable({ 
    
    df1<-filter(df, INST==input$INST4, LIBVER==input$LIBVER4)
    df2<-subset(df1, select=c('SHORTID', 'MODEL', 'EXPVAL', 'EXPERR', 'CALCVAL', 'CALCERR', 'COVERE'))
    validate(
      need(dim(df2)[1]>0,"No entries found for this combination of library and institution")
    )
    df2<-arrange(df2, SHORTID)%>%mutate(COVERE=round(COVERE,5))
    
    if(dim(df2)[1]>0) datatable(df2, options=list(columnDefs = list(list(visible=FALSE, targets=c(0))))) 
    df2
  })
 

session$onSessionEnded(stopApp)
 
} #end of server function

 