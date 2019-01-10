 
#############################################
#                                           #
#  UI  SENDIS                               #
#                                           #  
#############################################

#dtitle<-tags$a(href='http://www.sendis.org',
#       tags$img(src='sendis.png', height='20'))

dtitle<-tags$img(src='./sendis.png', height='22')

header <- dashboardHeader(title=dtitle)
                           

sidebar <- dashboardSidebar(disable = TRUE, width = 250)

tBoxHeight<-'750px'
gHeight<-'700px'
gBoxPlotsHeight<-'460px'

body <- dashboardBody(
              useShinyjs(),
              tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")),
              fluidPage(withMathJax(),
              tabBox(title=tagList(shiny::icon("send-o"), "v0.2"), width=12, 
                     tabPanel(tag('h4',"Sens Isotopes"),
                             fluidRow(
                               column(4,
                                      box(title = tag('b', "Filter Selection"), status="warning", 
                                          collapsible = TRUE, width = 12,
                                          fluidRow(
                                            column(6, selectInput('ISOTOPE',tag('h5', 'Isotope'),
                                                                  choices=unique(sens$ISOTOPE), multiple=F, 
                                                                  selected="U235"
                                                                  )),
                                            column(6, offset=0, selectInput('REACTION',tag('h4', 'Reaction'),
                                                                            unique(sens$REACTION), 
                                                                            multiple=FALSE)),
                                            column(4, offset=0, selectInput('INST',tag('h4', 'Institution'),
                                                                            unique(df$INST), 
                                                                            multiple=FALSE, selected="NEA"))
                                            # column(4, offset=0, selectInput('LIBVER',tag('h4', 'Library'),
                                            #                                 unique(df$LIBVER), 
                                            #                                 multiple=FALSE, selected="JEFF-3.3"))
                                            ),
                                          fluidRow(  
                                            column(12, 
                                                   selectizeInput('LIBS', tag('h4', 'Libraries (multiple choice)'), choices =c(unique(df$LIBVER)), 
                                                                  multiple=TRUE,  
                                                                  options = list(placeholder = 'Click to select libraries (multiple choice)',
                                                                                 onInitialize = I('function() { this.setValue("JEFF-3.3"); }'
                                                                                 ))
                                                   ))
                                          )
                                          # fluidRow(
                                          #   column(6, offset=0, 
                                          #          radioButtons("", label = h5("Select X axis"),
                                          #                       choices = list("Total Sensitivity" = "KSENSTOT", "Case Type" = "CASETYPE"), 
                                          #                       selected = "CASETYPE",inline = TRUE)),
                                          #   column(6, offset=0, 
                                          #          radioButtons("XAXIS", label = h5("Select X axis"),
                                          #                       choices = list("Total Sensitivity" = "KSENSTOT", "Case Type" = "CASETYPE"), 
                                          #                       selected = "CASETYPE",inline = TRUE))
                                          # )
                                          # fluidRow(
                                          #   column(12, offset=0, sliderInput("KSENS_TRESH",
                                          #                                    label = h4("Sensitivity Treshold"), min = 0,
                                          #                                    max = 1, value = c(0, 0.5)))
                                          #   )
                                        
                                          )
                                      ),
                               column(8,
                                      
                                      fluidRow(
                                        box(width=12, title='Group per Isotope', status="warning",
                                            solidHeader = TRUE,
                                            plotlyOutput('plot_isotopes'))
                                      )
                                      
                               )
                             )
                    ),          
                    tabPanel(tag('h4',"Performance"),
                            fluidRow(
                               column(4,
                                      fluidRow(
                                        box(title = tag('b', "Filter Selection"), status="warning", collapsible = TRUE, width = 12,
                                            fluidRow(
                                              column(6, offset=0, selectInput('INST3',tag('h4', 'Institution'),
                                                                              choices =c('All', unique(df$INST)), 
                                                                              multiple=FALSE, selected="NEA")),
                                              
                                              column(6, selectizeInput('CASETYPE3',tag('h4', 'Case Family'),
                                                                     choices = c('All', unique(df$CASETYPE)), multiple=TRUE,
                                                                     options = list(placeholder = 'Click to select case families',
                                                                                    onInitialize = I('function() { this.setValue("All"); }'))
                                                                     ))
                                            ),
                                            
                                            fluidRow(  
                                              column(12, 
                                                     sliderInput("MAXRES", label = h4("Maximum Residual"), min = 0, 
                                                                 max = 10, value = 5)
                                            
                                              )),
                                            
                                            fluidRow(  
                                              column(12, 
                                                     selectizeInput('LIB3', tag('h4', 'Libraries (multiple choice)'), choices =c(unique(df$LIBVER)), 
                                                                    multiple=TRUE,  
                                                                    options = list(placeholder = 'Click to select libraries (multiple choice)',
                                                                                   onInitialize = I('function() { this.setValue("JEFF-3.3"); }'))
                                                     ))))),
                                        fluidRow(
                                        box(title = tag('b', "Figure of Merit - Definition"), solidHeader = FALSE, status="info", collapsible = FALSE, width = 12,
                                         helpText('$$\\chi^2_i\\equiv\\frac{1}{N}\\sum_1^i\\frac{(k_C-k_E)^2}{{\\sigma_E^2 + \\sigma_C^2}}$$'),
                                         helpText('$$\\chi^2\\equiv\\chi^2_N$$')
                                         )
                                      )
                                      ),
                               column(8,
                                      fluidRow(
                                        box(width=12, title='Cumulative \\(\\chi^2\\) build-up', status="warning",
                                            solidHeader = TRUE,
                                            plotlyOutput('plot_cumul'))
                                   ))
                               )
                              
                            
                            ),
                                          
                                          
                                
                    
                    tabPanel(tag('h4',"Data"),
                             
                             box(width=0, title="Data Tables", color="gray", status="primary",solidHeader = TRUE, 
                                 
                                 fluidRow(
                                   
                                   column(3, offset=0, selectInput('INST4',tag('h4', 'Institution'),
                                                                   choices = unique(df$INST), multiple=FALSE, selected="NEA")),
                                   
                                   column(3, offset=0, selectInput('LIBVER4',tag('h4', 'Library'),
                                                                   choices = unique(df$LIBVER), multiple=FALSE, selected="JEFF-3.3T4"))
                                   
                                 ),
                                 fluidRow(
                                   column(12, 
                                          tag('b', '  Results from this institution are only available for the following libraries:'),
                                   textOutput('libs')),
                                   column(12, tag('hr', " "))
                                 ),
                                 
                                 fluidRow(
                                   
                                       
                                   column(4,  
                                          
                                          box(width=0, title="Suite ", color="gray", status="warning",solidHeader = TRUE,
                                          collapsible=TRUE,
                                          
                                          plotlyOutput('plot_histo')
                                          
                                          )
                                          
                                          ),
                                   
                                   column(8,  
                                          
                                          box(width=0, title="Data", color="gray", status="warning",solidHeader = TRUE,
                                              collapsible=TRUE,
                                              
                                          dataTableOutput('table')))
                                   )
                                 
                             )
                    )
                    

)))

dashboardPage(
  skin="black",
  header,
  #dashboardHeader(disable = FALSE),
  sidebar,
  body)
