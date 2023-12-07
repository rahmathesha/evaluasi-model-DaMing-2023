library(shiny)

shinyUI(fluidPage(
  titlePanel("Evaluasi Model Prediktif", windowTitle = "DaMing23"),
  sidebarLayout(
    sidebarPanel(
      fileInput("file", "Upload the file"),
      helpText("Default max. file size is 5MB"),
      tags$hr(),
      h5(helpText("Select parameters below")),
      checkboxInput(inputId = "header", label = "Header", value = TRUE),
      checkboxInput(inputId = "stringAsFactors", label = "stringAsFactors", value=TRUE),
      #checkboxInput(inputId = "integerAsFactor", label = "integerAsFactors", value=FALSE),
      br(), #break spase
      radioButtons(inputId = "sep", 
                   label = "Separator", 
                   choices = c(Comma= ",", Semicolon= ";", Tab= "\t", Space= ""), selected= ",")
    ),
    mainPanel(
      uiOutput("tb")
    )
  )
))
