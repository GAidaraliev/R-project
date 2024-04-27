library(shiny)
df = load(file='C:/Users/Gali/Desktop/DataScienceTechInstitute/17. Big data with R/Airbnb_cleansed.Rdata')

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("The renting price per city quarter"),

    # Sidebar with a select input for neighborhood and a check box for adding a density line  
    sidebarLayout(
        sidebarPanel(
          selectInput(inputId = "neighbourhood",
                      label = "Filter by neighbourhood",
                      choices = test2$neighbourhood_cleansed)
        ,
        h5("Density estimation:"),
        # Add or not a density line
        checkboxInput(inputId = "density",
                      label = 'Enable density estimation',
                      value = FALSE)),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$distPlot <- renderPlot({
      # Display the renting price per city quarter
      # Default position of a slider (all neighborhoods)
      if(input$neighbourhood == ""){
        hist(test2$price, freq = FALSE,  col="lavender", xlab="Price", xlim= c(0,1000), ylim= c(0,0.019), 
             main = paste("The mean price =", round(mean(test2$price),2),"$ for all neighborhoods"))
        if(input$density) {lines(density(test2$price),col='blue',lwd=2)}  
      }else if(input$neighbourhood != ""){
        hist(test2$price[test2$neighbourhood_cleansed == input$neighbourhood], freq = FALSE,  col="grey",
             xlab="Price", xlim= c(0,1000), ylim= c(0,0.019), main = paste("The mean price =", 
                round(mean(test2$price[test2$neighbourhood_cleansed == input$neighbourhood]),2),"$ for",input$neighbourhood ) )
        if(input$density) {lines(density(test2$price[test2$neighbourhood_cleansed == input$neighbourhood]),col='red',lwd=2)}
      }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
