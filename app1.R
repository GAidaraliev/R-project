library(shiny)
library(dplyr)
df = load(file='C:/Users/Gali/Desktop/DataScienceTechInstitute/17. Big data with R/Airbnb_cleansed.Rdata')

# Define UI for application that draws a histogram
ui <- fluidPage(
  
  # Application title
  titlePanel("Visit frequency of the different quarters according to time"),
  
  # Sidebar with a select input for a neighborhood and a slider input for dates 
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "neighbourhood",
                  label = "Filter by neighbourhood",
                  choices = test2$neighbourhood_cleansed),
      sliderInput(inputId = "Dates",
                  label = "Time:",
                  min = min(test2$first_review),
                  max = max (test2$first_review),
                  value = c(min(test2$first_review), max(test2$first_review))),
      
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  output$distPlot <- renderPlot({
    # Determine different positions of the slider
    Dates<-input$Dates
    test2 <- test2 %>% filter(test2$first_review > min(Dates) & test2$first_review < max(Dates))
    # Display the visit frequency of the different neighborhoods according to time
    # Default position of a slider (all neighborhoods)
    if(input$neighbourhood == ""){
    hist(test2$first_review,breaks = "month", col="lavender", 
         main = "The general frequency of all neighbourhoods",xlab="Date")
    }else if(input$neighbourhood != ""){
      hist(test2$first_review[test2$neighbourhood_cleansed == input$neighbourhood],breaks = "month", col="grey", 
           main = input$neighbourhood,xlab="Date") 
    } 
  })
}


# Run the application 
shinyApp(ui = ui, server = server)

