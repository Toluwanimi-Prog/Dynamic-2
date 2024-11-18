library(shiny)
library(bslib)
library(tidyverse)
library(plotly)
library(readxl)

# Define the file path
FILE_PATH <- "GDPDataSetscopy.xlsx"
data <- read_excel(FILE_PATH)


ui <- page_sidebar(
  title = "Transportation Variables Trends",
  theme = bs_theme(bootswatch = "flatly"),
  
  sidebar = sidebar(
    uiOutput("variable_selector"),
    checkboxInput("show_standardized", "Show Standardized Values", value = FALSE)
  ),
  
  card(
    card_header("Transportation Trends During Great Recession (2007-2012)"),
    plotlyOutput("recession_plot", height = "400px")
  ),
  
  card(
    card_header("Transportation Trends During COVID-19 (2019-2022)"),
    plotlyOutput("covid_plot", height = "400px")
  )
)

server <- function(input, output, session) {
  
  # Read data directly from file path
  data <- reactive({
    df <- read_excel(FILE_PATH)
    if (!("Year" %in% names(df))) {
      df <- df %>% rename(Year = 1)
    }
    return(df)
  })
  
  # Define the preferred variables
  preferred_vars <- c(
    "Air transportation"
  )
  
  # Dynamic UI for variable selection
  output$variable_selector <- renderUI({
    req(data())
    vars <- setdiff(names(data()), "Year")
    
    # Try to select preferred variables if they exist in the data
    default_selected <- intersect(preferred_vars, vars)
    if (length(default_selected) == 0) {
      default_selected <- vars[1:min(5, length(vars))]
    }
    
    checkboxGroupInput("variables", "Select Variables:",
                       choices = vars,
                       selected = default_selected)
  })
  
  # Helper function to create plots
  create_crisis_plot <- function(data, year_range, crisis_name) {
    req(input$variables)
    
    # Filter for specific years
    plot_data <- data %>% 
      filter(Year >= year_range[1], Year <= year_range[2])
    
    if (input$show_standardized) {
      # Create standardized data
      plot_data[input$variables] <- scale(plot_data[input$variables])
      plot_data <- plot_data %>%
        pivot_longer(cols = all_of(input$variables),
                     names_to = "Variable", 
                     values_to = "Value")
      y_label <- "Standardized Value\n(mean=0, sd=1)"
    } else {
      plot_data <- plot_data %>%
        pivot_longer(cols = all_of(input$variables),
                     names_to = "Variable", 
                     values_to = "Value")
      y_label <- "GDP in Billion"
    }
    
    # Create the plot
    p <- ggplot(plot_data) +
      # Add crisis period rectangle
      annotate("rect", 
               xmin = year_range[1], xmax = year_range[2],
               ymin = -Inf, ymax = Inf,
               alpha = 0.1, fill = "gray50") +
      # Add crisis label
      annotate("text", 
               x = mean(year_range), 
               y = max(plot_data$Value), 
               label = crisis_name,
               alpha = 0.7, fontface = "bold") +
      # Add the lines for variables
      geom_line(aes(x = Year, y = Value, 
                    color = Variable), 
                size = 1.2) +
      # Add points for each value
      geom_point(aes(x = Year, y = Value, 
                     color = Variable,
                     text = paste("Year:", Year,
                                  "\nVariable:", Variable,
                                  "\nValue:", round(Value, 2))), 
                 size = 2) +
      # Set specific x-axis limits and breaks
      scale_x_continuous(limits = year_range,
                         breaks = year_range[1]:year_range[2]) +
      theme_minimal() +
      labs(y = y_label,  
           x = "Year") + 
      theme(legend.position = "right",
            panel.grid.major = element_line(color = "white"),
            panel.grid.minor = element_line(color = "white"))
    
    # Convert to plotly with custom hover text
    ggplotly(p, tooltip = "text")
  }
  
  # Recession plot
  output$recession_plot <- renderPlotly({
    req(data())
    create_crisis_plot(data(), c(2007, 2012), "Great Recession")
  })
  
  # COVID plot
  output$covid_plot <- renderPlotly({
    req(data())
    create_crisis_plot(data(), c(2019, 2022), "COVID-19 Period")
  })
}

shinyApp(ui, server)
