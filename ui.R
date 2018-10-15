
library(shiny)
library(shinydashboard)
library(DT)

# Encabezado

## Title 

title<-tags$a(href='http://sibudata.com',
              #tags$img(src="SIBU.jpg",height='50',width='50'),
              icon("tower",lib = "glyphicon"),
              #icon("robot",lib="font-awesome"),
              'SIBU DS&R')

## Only run this example in interactive R sessions
if (interactive()) {
        library(shiny)
        
        # A dashboard header with 3 dropdown menus
        header <- dashboardHeader(
                title=title,
                
                # Dropdown menu for messages
                dropdownMenu(type = "messages", badgeStatus = "success",
                             messageItem("Support Team",
                                         "This is the content of a message.",
                                         time = "5 mins"
                             ),
                             messageItem("Support Team",
                                         "This is the content of another message.",
                                         time = "2 hours"
                             ),
                             messageItem("New User",
                                         "Can I get some help?",
                                         time = "Today"
                             )
                ),
                
                # Dropdown menu for notifications
                dropdownMenu(type = "notifications", badgeStatus = "warning",
                             notificationItem(icon = icon("users"), status = "info",
                                              "5 new members joined today"
                             ),
                             notificationItem(icon = icon("warning"), status = "danger",
                                              "Resource usage near limit."
                             ),
                             notificationItem(icon = icon("shopping-cart", lib = "glyphicon"),
                                              status = "success", "25 sales made"
                             ),
                             notificationItem(icon = icon("user", lib = "glyphicon"),
                                              status = "danger", "You changed your username"
                             )
                ),
                
                # Dropdown menu for tasks, with progress bar
                dropdownMenu(type = "tasks", badgeStatus = "danger",
                             taskItem(value = 20, color = "aqua",
                                      "Codigo Entrada de datos"
                             ),
                             taskItem(value = 12, color = "green",
                                      "SCRUM1"
                             ),
                             taskItem(value = 0, color = "yellow",
                                      "SCRUM2"
                             ),
                             taskItem(value = 0, color = "red",
                                      "Write documentation"
                             )
                ),
                
                tags$li(actionLink("openModal", label = "", icon = icon("info")),
                        class = "dropdown")
        )
}

# Sidebar

sidebar <- dashboardSidebar(
    sidebarMenu(
        menuItem("Data", tabName = "Data", icon = icon("calendar"),
                 badgeLabel = "new", badgeColor = "green"),
        menuItem("Information", tabName = "Information", icon=icon("dashboard"))

    )
)

# Body

body <- dashboardBody(
    tabItems(
        tabItem(tabName = "Data",
                fluidRow(
                    tabBox(title="Carga Datos", id="tabBox1",
                           tabPanel(title="Carga",value="carga1",
                        
                                    box(width = "100%",title="Entradas",status = "primary",solidHeader = TRUE,
                                        
                                        # Input: Checkbox if file has header ----
                                        checkboxInput(inputId="header", label="Encabezado", TRUE),
                                        
                                        # Input: Checkbox if file has rownames ----
                                        checkboxInput(inputId="rownames", label="Nombre Filas", TRUE),
                                        
                                        # Input: Select columns separator ----
                                        radioButtons(inputId="sep", label="Separador de columnas",
                                                     choices = c('Coma' = ",",
                                                                 'Punto y coma' = ";",
                                                                 'Tabulacion' = "\t"),
                                                     selected = ","),
                                        
                                        # Input: Select decimal separator ----
                                        radioButtons(inputId="dec", label="Separador decimal",
                                                     choices = c("Punto" = '.',
                                                                 "Coma" = ','),
                                                     selected = '.'),
                                        
                                        # Horizontal line ----
                                        tags$hr(),
                                        
                                        # Input: Select number of rows to display ----
                                        radioButtons("disp", "Display",
                                                     choices = c(Head = "head",
                                                                 All = "all"),
                                                     selected = "head"),
                                        
                                        # Input: Select a file ----
                                        fileInput("file1", "Choose CSV File",
                                                  multiple = FALSE,
                                                  accept = c("text/csv",
                                                             "text/comma-separated-values,text/plain",
                                                             ".csv"))
                                        
                                  
                                        
                                    ,collapsible = TRUE)     
                                    
                                    
                                    ),
                           tabPanel(title="Transformacion",value="transformacion")),
                    tabBox(title="Datos cargados", id="tabBox2",
                           box(width = "100%",
                               dataTableOutput("contents")))
                )
        ),
        
        tabItem(tabName = "Information"
                
        )
    ),
    
    mainPanel()
)


# Define UI for application that draws a histogram
shinyUI(dashboardPage(
  
                header,
                sidebar,
                body
                )
        
)
