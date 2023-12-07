library(shiny)

options(shiny.maxRequestSize= 9*1024^2)
shinyServer(function(input,output){
  data <- reactive({
    file1 <- input$file
    if(is.null(file1)){return()}
    read.table(file= file1$datapath, 
               sep= input$sep, 
               header= input$header, 
               stringsAsFactors = input$stringAsFactors #, integerAsFactors = input$integerAsFactor
    )
  })
  
  output$perform <- renderTable({
    if(is.null(data())){return()}
    aktual <- read.csv("aktual.csv")
    xtab <- table(data()$Y, aktual$Y)
    p <- caret::confusionMatrix(xtab, positive = "YES")
    
    all <- data.frame(rbind("values"= format(round(p$overall[1:2], 3))))
    byclass <- data.frame(rbind(("values"= p$byClass[c(1,2,5:7)])))
    
    tab <- data.frame(cbind(all, byclass))
    rownames(tab) <- ''
    tab
  })
  
  output$tb <- renderUI({
    if(is.null(data()))
      h4('Powered by', tags$img(src= 'homepage.png', heigth= 1000, width= 1000))
    else
      tabsetPanel(
                  tabPanel('Performance', tableOutput('perform'))
                  )   
    })
})
