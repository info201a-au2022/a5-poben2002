library(shiny)
library(ggplot2)
library(bslib)
library(shinyWidgets)

# List of columns

#select_values <- colnames(global.total_data1)
#View(select_values)
# Variable that stores select_values and allows user to 
# choose what y variable will be displayed on the scatterplot on the y axis
y_input <- selectInput(
  "y_var",
  label = "Y Variable",
  choices = list("cumulative_co2", "co2_growth_prct", "co2_per_capita"),
  selected = "cyl"
)

# Create a variable `color_input` as a `selectInput()` that allows users to
# select a color from a list of choices
color_input <- selectInput(
  "color",
  label = "Color",
  choices = list("Red" = "red", "Blue" = "blue", "Green" = "green", "Yellow" = "yellow")
)

# Create a variable `size_input` as a `sliderInput()` that allows users to
# select a point size to use in your `geom_point()`
size_input <- sliderInput(
  "size",
  label = "Size of point", min = 1, max = 10, value = 5
)

# Create a variable `ui` that is a `fluidPage()` ui element. 
# It should contain:

#Intro tab
intro_panel <- tabPanel(
  "Introduction",
  titlePanel("Carbon Emission Data"),
  setBackgroundColor("aliceblue"),
  theme = bs_theme(version = 4, bootswatch = "minty"),
  # A page header with a descriptive title
  h1("CO2 Emissions Exploration"),
  p("This website displays data analysis of different Co2 emmission statistics 
    of different countries. The three values that are calculated to be displayed
    are the carbon emission per capita, carbon growth percent and cumulative co2 
    counts of different countries worldwide in the most recent year (2021). For the
    carbon growth percent of different countries, the measure is annual percentage
    growth in total production based emissions of carbon dioxide, excluding land use change and
    based on territorial emissions. The co2 per capita stat is measured by annual total
    production based emissions of carbon dioxide exluding land use change, measured in tonnes
    per person. The cumulative co2 value is measured by total cumulative production based emissions
    of carbon dioxide measured in million tonnes. With 
    these statistics, the countries with the highest and lowest of those values are calculated, 
    as well the average per country and the change of these values over time."),

  h2("Calculated Values"),
  p("The first value automatically generated was the average C02 per capita across all countries in the most recent year. 
    Some interesting values found was that the country with currently the highest Co2 per capita was", strong("Qatar"), 
    " and the country with currently the lowest Co2 per capita is ", strong("Democratic Republic of Congo"), ". I also
      found that by grouping by country and year, the Co2 per capita of most countries has been increasing as the years increased."),
  
    p("The second value automatically generated was the average growth percentage of Co2 of all countries in the most recent year. 
    Some interesting values found was that the country with currently the highest Co2 growth percentage was", strong("Libya"), 
      " and the country with currently the lowest Co2 growth percentage was ", strong("Bosnia and Herzegovina"), ". I also
      found that by grouping by country and year, the Co2 percentage started growing exponentially in the 1970s"),
      
  p("The third value automatically generated was the cumulative C02 values across all countries in the most recent year. 
    Some interesting values found was that the world has a cumulative co2 value of ", strong("1736930 million tonnes"), 
    " and the country with currently the lowest cumulative co2 is ", strong("Tuvalu"), ".I also
      found that by grouping by country and year, the cumulative co2 of most countries has been increasing as the years increased.")
)
main_content <- mainPanel(
  plotOutput("scatter")
)
  Chart_panel <- tabPanel(
    "Co2 Emissions Chart",
    titlePanel("Co2 Interactive Visualization"),
    theme = bs_theme(version = 4, bootswatch = "minty"),
    setBackgroundColor("aliceblue"),
    
  h2("Chart Comparing Top 5 Carbon Emmission Countries with Carbon Emmission statistics"),
  # Your y input
  y_input,
  
  # Your color input
  color_input,
  
  # Your size input
  size_input, 
  
  main_content,
  
  #Caption 
  p("Caption: This chart was included to show how the countries with the 5 biggest carbon
    emissions differ in their carbon emissions per capita, carbon growth percentage and
    cumulative carbon output. The chart reveals patterns on how the different countries 
    (US, Japan, China, India and Russia) differ in ", em("how"), "they produce Co2. For example, 
    it shows how while China and U.S emit the most carbon dioxide, they are not growing 
    at the highest percentage in carbon emissions, and India despite having large co2 per capita
    may not have a large cumulative and growth percentage of co2.")
  )
ui <- navbarPage(
  "Carbon Emission Data",
  intro_panel,
  Chart_panel
)

