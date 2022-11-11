library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(shinyjs)
library(sodium)
library(lubridate)


dashboardPage(
    
    dashboardHeader(title = span("Recycle Me!", style = "font-weight: bold; font-family: 'Helvetica';")),
    dashboardSidebar(sidebarMenu(
        tags$head(tags$style(HTML('.logo {
                              background-color: #0c4e3f !important;
                              }
                              .navbar {
                              background-color: #0c4e3f !important;
                              }
                              '))),
        id = "tabs",
        menuItem("Trash Classifier", tabName = "classifier", icon = icon("trash"))
        
        
    )),
    dashboardBody(
        tags$head(tags$style(HTML('.value-box {min-height: 45px;} .value-box-icon {height: 45px; line-height: 45px;} .value-box-content {padding-top: 0px; padding-bottom: 0px;}'))),
        tags$head(tags$style(HTML('

                                /* body */
                                .content-wrapper, .right-side {
                                background-color: #c8d4d0;
                                }
                                
                                '))),
        
        
        tabItems(
            tabItem(
                tabName = 'classifier',
                div(align = "center",img(src = "logo.jpeg", height = 200, width = 1000)),
                br(),
                br(),
                div(id = "intro", align = 'center', h2("Make recycling easier by uploading a picture of your trash and our AI will tell you which material it's made up of!")),
                br(),
                div(id = "try", align = 'center', h2("Try it now!")),
                br(),
                br(),
                div(id = 'choose_image', align = 'center', fluidRow( 
                    fileInput("upload", "Choose an image (Accepted file types: png, jpg, jpeg)", accept = c('image/png', 'image/jpeg', 'image/jpg')),
                    uiOutput("image")
                )),
                br(),
                useShinyjs(),
                div(id = "predictdiv", align = 'center', actionBttn(
                    inputId = "predict",
                    label = "Predict!",
                    color = "success",
                    size = "lg"
                )),
    
                
                div(
                    align = "center", id = "loadingpage",
                    br(),
                    h2("Please wait for a while...", align = "center"),
                    h3("We are working as fast as possible to predict which material best suits your image.", align = "center"),
                    br(),
                    br(),
                    br(),
                    br(),
                    align = "center",
                    progressBar(
                        id = "progressbar",
                        value = 0,
                        total = 100,
                        title = "",
                        display_pct = TRUE
                    ),
                ),
                div(
                    align = "center", id = "predictionpage",
                    h2("Our result shows that the material in your image is..."),
                    br(),
                    br(),
                    valueBoxOutput("info", width = 12)
                    
                    
                ),
                
                
                
                
                
            )
            
            
           
        
        
        
        
        
        
        
    )))


