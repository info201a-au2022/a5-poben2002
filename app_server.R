
library(shiny)
library(ggplot2)
library(dplyr)


# Shiny server that displays visualizations of CO2 emission data

# Sourcing the c02 data set
carbon_data <- read.csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")
#View(carbon_data)

# First value: C02 per capita

# Avg C02 per capita across all countries in the most recent year 

avgpercap <- carbon_data %>% group_by(country) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% select(co2_per_capita, year)

#View(avgpercap)
# Highest and lowest country values in most recent year 

maxcountry <- carbon_data  %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(co2_per_capita == max(co2_per_capita, na.rm = TRUE)) %>% 
  select(country, co2_per_capita)
#View(maxcountry)

mincountry <- carbon_data  %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(co2_per_capita == min(co2_per_capita, na.rm = TRUE)) %>% 
  select(country, co2_per_capita)
#View(mincountry)

# Comparing C02 per capita over time for country with highest per capita C02
co2_over_time <- carbon_data %>% group_by(country) %>% filter(country == "Qatar") %>%
  select(co2_per_capita, year)
#View(co2_over_time)

# Second Value: C02 growth percentage 
# Avg C02 growth across all countries in the most recent year 

avggrowth <- carbon_data %>% group_by(country) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% select(co2_growth_prct, year)

#View(avggrowth)
# Highest and lowest country values in most recent year 

maxcountrygrowth <- carbon_data  %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(co2_growth_prct == max(co2_growth_prct, na.rm = TRUE)) %>% 
  select(country, co2_growth_prct)
#View(maxcountrygrowth)

mincountrygrowth <- carbon_data  %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(co2_growth_prct == min(co2_growth_prct, na.rm = TRUE)) %>% 
  select(country, co2_growth_prct)
#View(mincountrygrowth)

# Comparing C02 growth over time for country with highest per capita C02
co2_growth <- carbon_data %>% group_by(country) %>% filter(country == "Qatar") %>%
  select(co2_growth_prct, year)
#View(co2_growth)

# Third Value: Cumulative C02 
# Avg cumulative C02 across all countries in the most recent year 

cum_co2 <- carbon_data %>% group_by(country) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% select(cumulative_co2, year)

#View(cum_co2)
# Highest and lowest country values in most recent year 

maxcountryco2 <- carbon_data  %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(cumulative_co2 == max(cumulative_co2, na.rm = TRUE)) %>% 
  select(country, cumulative_co2)
#View(maxcountryco2)

mincountryco2 <- carbon_data  %>% 
  filter(year == max(year, na.rm = TRUE)) %>% 
  filter(cumulative_co2 == min(cumulative_co2, na.rm = TRUE)) %>% 
  select(country, cumulative_co2)
#View(mincountryco2)

# Comparing C02 per capita over time for country with highest per capita C02
co2_total <- carbon_data %>% group_by(country) %>% filter(country == "Qatar") %>%
  select(cumulative_co2, year)
#View(co2_total)


countries <- carbon_data %>% group_by(country) %>% filter(year == max(year)) %>% select(year)
#View(countries)
# Interactive Visual

target <- c("United States", "China", "India", "Japan", "Russia")
global.total_data1 <- carbon_data %>% group_by(country) %>% 
  filter(year == max(year, na.rm = TRUE)) %>% filter(country %in% target) %>%
  select(cumulative_co2, co2_growth_prct, co2_per_capita)

server <- function(input, output) {
  
  output$scatter <- renderPlot({
    
    # Store the title of the graph in a variable indicating the x/y variables
    title <- paste0("Co2 Emissions Top 5 Countries Dataset: ", input$x_var, " v.s.", input$y_var)
    
    # Create ggplot scatter
    p <- ggplot(global.total_data1) +
      geom_point(mapping = aes_string(x = "country", y = input$y_var), 
                 size = input$size, 
                 color = input$color) +
      labs(x = "country", y = input$y_var, title = title)
    p
  })
}
