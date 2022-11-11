
library(shiny)
library(base64enc)
library(shinyjs)

# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
    
    hide("predictdiv")
    hide("loadingpage")
    hide("predictionpage")
    
    
    
    base64 <- reactive({
        inFile <- input$upload
        if(!is.null(inFile)){
            dataURI(file = inFile$datapath, mime = "image/png")
        }
    })

    output$image <- renderUI({
        if(!is.null(base64())){
            tags$div(
                tags$img(src= base64(), width="100%"),
                style = "width: 400px;"
            )
        }
    })

    
    observeEvent(input$upload,
                 if(!is.null(base64()))
                     {toggle("predictdiv")})
    
    observeEvent(input$predict,
                 {hide("intro")
                 hide("try")
                 hide("choose_image")
                 hide("predictdiv")
                 toggle("loadingpage")
                 
                 for (i in 1:100) {
                     updateProgressBar(
                         session = session,
                         id = "progressbar",
                         value = i, total = 100,
                         title = ""
                     )
                     Sys.sleep(0.1)
                 }
                 #print(input$upload$datapath)
                 results <- extract_features(input$upload$datapath)
                 #print(results)
                 output$info <- renderValueBox({
                     valueBox(
                         results$second, '', icon = icon("recycle"),
                         color = "green"
                     )
                 })
                
                 
                 
                 hide("loadingpage")
                 toggle("predictionpage")
                 
                 
                 }
                 
                 )
    
    
    extract_features <- function(img_path) {
        img <- image_load(img_path, target_size = c(224,224))
        x <- image_to_array(img)
        x <- array_reshape(x, c(1, dim(x)))
        x <- imagenet_preprocess_input(x)
        prediction <- predict(model, x)
        results <- list()
        
        
        max_pred <- max(prediction)
        results$first <- max_pred
        
        for (i in 1:10)
        {if (prediction[1,i] == max_pred)
        {
            
            if (i == 1)
            {results$second <- "Fabric"}
            else if (i ==2)
            {results$second <- "Foliage"}
            else if (i ==3)
            {results$second <- "Glass"}
            else if (i ==4)
            {results$second <- "Leather"}
            else if (i ==5)
            {results$second <- "Metal"}
            else if (i ==6)
            {results$second <- "Paper"}
            else if (i ==7)
            {results$second <- "Plastic"}
            else if (i ==8)
            {results$second <- "Stone"}
            else if (i ==9)
            {results$second <- "Water"}
            else if (i ==10)
            {results$second <- "Wood"}
        }}
        return(results)
    }
    
    
    

})
