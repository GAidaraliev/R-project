library(shiny)
library(dplyr)
library(leaflet)
df = load(file='C:/Users/Gali/Desktop/DataScienceTechInstitute/17. Big data with R/Airbnb_cleansed.Rdata')

# Define UI for application that draws a histogram
ui <- fluidPage(

    # Application title
    titlePanel("The number of apartments per owner"),

    # Sidebar with a text input for a owner's ID 
    sidebarLayout(
        sidebarPanel(
          textInput(inputId = "name",
                      label = "Enter the owner's ID",
                      placeholder = "Enter ID")
        ),

        # Show a map of the selected apartments
        mainPanel(
          leafletOutput("map")
        )
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
      output$map <- renderLeaflet({
        # Display the number of apartments per owner
        # The number of all  apartments and their geo-positions
        if(input$name == ""){
          leaflet(test2 %>% select(longitude,neighbourhood_cleansed,latitude,price)) %>%
            setView(lng = 2.29, lat = 48.902,zoom = 10) %>%
            addTiles() %>% 
            addMarkers(
              clusterOptions = markerClusterOptions()
            )
          # The number of apartments for the selected owner  
        }else if(input$name != ""){
          test3 <- test2 %>% filter(host_id == input$name)
          leaflet(test3 %>% select(longitude,neighbourhood_cleansed,latitude,price)) %>%
            setView(lng = 2.29, lat = 48.902,zoom = 10) %>%
            addTiles() %>% 
            addMarkers(
              clusterOptions = markerClusterOptions()
            )
        } 
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
