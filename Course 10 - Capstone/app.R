library(shiny)
library(ggplot2)
library(markdown)
library(shinythemes)
library(RColorBrewer)

## Source the predictor
source("predictor.R")

#Server component
server <- shinyServer(function(input, output, session) {
    
    predicted_text1 <- reactive(predictNext(input$userInput)[1])
    output$predict1 <- predicted_text1
    observeEvent(input$word1, { 
        updateTextInput(session, "userInput",
                        value = paste(input$userInput, predicted_text1()))
    })
    
    predicted_text2 <- reactive(predictNext(input$userInput)[2])
    output$predict2 <- predicted_text2
    observeEvent(input$word2, { 
        updateTextInput(session, "userInput",
                        value = paste(input$userInput, predicted_text2()))
    })
    
    predicted_text3 <- reactive(predictNext(input$userInput)[3])
    output$predict3 <- predicted_text3
    observeEvent(input$word3, { 
        updateTextInput(session, "userInput",
                        value = paste(input$userInput, predicted_text3()))
    })
    
    predicted_text4 <- reactive(predictNext(input$userInput)[4])
    output$predict4 <- predicted_text4
    observeEvent(input$word4, { 
        updateTextInput(session, "userInput",
                        value = paste(input$userInput, predicted_text4()))
    })
    
    predicted_text5 <- reactive(predictNext(input$userInput)[5])
    output$predict5 <- predicted_text5
    observeEvent(input$word5, { 
        updateTextInput(session, "userInput",
                        value = paste(input$userInput, predicted_text5()))
    })

})

## UI component
ui <- shinyUI(fluidPage(
    theme = shinytheme("cerulean"),
    titlePanel("Swiftkey word prediction"),
    
    mainPanel(tabsetPanel(
        tabPanel("Prediction",
                 sidebarLayout(
                     mainPanel(
                         h4("Enter text here"),
                         h2(textAreaInput("userInput", NULL, value = "hello", cols = 30, rows = 3))),
                     
                     sidebarPanel(
                         width = 4,
                         flowLayout(
                             actionButton("word1", label = textOutput("predict1")),
                             actionButton("word2", label = textOutput("predict2")),
                             actionButton("word3", label = textOutput("predict3")),
                             actionButton("word4", label = textOutput("predict4")),
                             actionButton("word5", label = textOutput("predict5"))
                         )
                     )
                 )),
       
         tabPanel("Directions", includeMarkdown("Directions.html"))
    ))
))

# 2. APP -----------------------------------------------------------------------

# Run the application 
shinyApp(ui = ui, server = server)