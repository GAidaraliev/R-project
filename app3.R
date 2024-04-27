library(shiny)
library(ggplot2)
df = load(file='C:/Users/Gali/Desktop/DataScienceTechInstitute/17. Big data with R/Airbnb_cleansed.Rdata')

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("Relationship between prices and apartment features"),

    # Sidebar with a radio buttons for different apartment features 
    sidebarLayout(
        sidebarPanel(
          radioButtons(inputId = "feature",
                       label = "Choice of the feature",
                       choiceValues = c("bedrooms", "bathrooms","beds"),
                       choiceNames = c("Bedrooms","Bathrooms","Beds"))
        ),

        # Show a plot of the generated distribution
        mainPanel(
           plotOutput("distPlot")
        )
    )
)

# Define server logic required to draw a box plot
server <- function(input, output) {

    output$distPlot <- renderPlot({
      # Display the relationship between prices and apartment features
      if(input$feature == "bedrooms"){
        ggplot(data = test2) +
          geom_boxplot(aes(x=factor(bedrooms),y=log_price, fill=factor(bedrooms))) + xlab("bedrooms") + ggtitle("The relationship between log-prices and number of bedrooms") + theme(
            plot.title = element_text(color="black", size=14, face="bold.italic", hjust = 0.5)) + guides(fill = guide_legend(title = "Bedroom"))
      } else if (input$feature == "bathrooms"){
        ggplot(data = test2) +
          geom_boxplot(aes(x=factor(bathrooms),y=log_price, fill=factor(bathrooms))) + xlab("bathrooms") + ggtitle("The relationship between log-prices and number of bathrooms") + theme(
            plot.title = element_text(color="black", size=14, face="bold.italic", hjust = 0.5)) + guides(fill = guide_legend(title = "Bathroom"))
      } else if (input$feature == "beds"){
        ggplot(data = test2) +
          geom_boxplot(aes(x=factor(beds),y=log_price, fill=factor(beds))) + xlab("beds") + ggtitle("The relationship between log-prices and number of beds") + theme(
            plot.title = element_text(color="black", size=14, face="bold.italic", hjust = 0.5)) + guides(fill = guide_legend(title = "Bed"))
      }
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
