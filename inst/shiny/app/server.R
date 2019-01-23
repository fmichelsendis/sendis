#############################################
#                                           #
#   SERVER SENDIS                           #
#                                           #  
#############################################

server <- function(input, output, session){
  addClass(selector = "body", class = "sidebar-collapse")

##################
  
  # userFile<-reactive({
  #   inFile <- input$file1
  #   if (!is.null(inFile)){
  #     udf<-fread(inFile$datapath)
  #     mydata<-sendis::compile_to_sendis(udf)
  #     return(mydata)
  #     }
  # })
  
  output$plotUserFile<-renderPlotly({
    ##udf<-userFile() 
    ##validate(need(dim(udf)[1]!=0, "Upload a valid csv"))  
    #plot_ly(udf, x = ~FULLID, y=~CALCVAL, type='scatter', mode='markers', color=~INST) 
   })
  
  
  
  

  output$plot_isotopes<-renderPlotly({ 
    
    
    lib_list<-input$LIBS
    inst<-input$INST
    isotope<-input$ISOTOPE
    reaction= input$REACTION
    
    reaction_name<-paste0(isotope, "_",reaction)
    
    
    # Prepping data using exps data frame, cleaning to get only numerical columns
    # exp_df is a dataframe with only numerical values, a subset of the exps data
    data(sendis)
    r<-filter(sendis, INST==inst, LIBVER%in%lib_list, MODEL=="Only") %>%
      select(FULLID, LIBVER, INST, EALF, RESIDUAL)%>%
     unique()
    
    data(mats)
    mats<-mats%>%
      mutate(ISOTOPE=paste0(X,A))%>%
      select(-MAT)
    
    data(sens)
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
    
    p<-plot_ly(df, x=~KSENSTOT, y=~RESIDUAL, color=~LIBVER, text=~FULLID)
    p
    
  })
  
  
  
#############@
  
  
output$plot_cumul<-renderPlotly({ 
  df<-sendis
  #if (!is.null(input$file1)) df<-userFile()  
  if("All" %in% input$CASETYPE3) df<-filter(df, INST==input$INST3, LIBVER %in% input$LIB3)
  else df<-filter(df, INST==input$INST3, LIBVER %in% input$LIB3, CASETYPE%in% input$CASETYPE3)
    df<-filter(df, df$RESIDUAL<= input$MAXRES)
    sendis::plot_cumulchi(df)
    })
    
#####################
  
  output$libs<-renderText({
    df<-sendis
    df1<-filter(df, INST==input$INST4)
    df1<- df1[order(df1$LIBVER),]
    text<-paste(unique(df1$LIBVER), " ; ")
    text
  })
  
  #########################################################################
  
  output$plot_histo<-renderPlotly({ 
    #df<-userFile()
    df<-sendis
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
    #df<-userFile()
    df<-sendis
    df<-df%>%
      filter(df, INST==input$INST4, LIBVER==input$LIBVER4)%>%
      select(SHORTID, MODEL, EXPVAL, EXPERR, CALCVAL, CALCERR, COVERE)%>%
      mutate(COVERE=round(COVERE,5))%>%
      arrange(SHORTID)
    
    validate(
      need(dim(df)[1]>0,"No entries found for this combination of library and institution")
    )
     
    if(dim(df)[1]>0) datatable(df, options=list(columnDefs = list(list(visible=FALSE, targets=c(0))))) 
    df
  })
 

session$onSessionEnded(stopApp)
 
} #end of server function

 