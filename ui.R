

# Define UI for application that draws a histogram
shinyUI(
  
  fluidPage(
    theme = shinytheme("flatly"),
    collapsable = TRUE,
    
    shiny::navbarPage(
      tags$head(tags$style(HTML(
        paste0('VGS_DataExporter_', Sys.Date())
      ))),
      
      theme = bs_theme(
        bg = "Green",
        fg = "DarkTurquoise",
        primary = "Black",
        secondary = "DarkOrange",
        base_font = font_google("Prompt"),
        code_font = font_google("JetBrains Mono")
      )
    ),
    
    # Application title
    h2(
      "VGS Export-Importer",
      style = "font-family: 'Jura';
       color: green; font-size: 52px;"
    ),
    p(
      "Upload an Excel file from a VGS Export on this tab, then select an Excel Sheet -",
      style = "font-family: 'Jura'; color: green; font-size: 14px;"
    ),
    p(
      "(The 'Selected Excel Sheet' is what will be ran through the selected script in the next tab)",
      style = "font-family: 'Jura'; color: green; font-size: 14px;"
    ),
    
    # Sidebar
    tabsetPanel(
      
      tabPanel(
        'Data Upload',
        br(),
        
        #
        box(width = 2,
          fileInput(
            'file1',
            'Upload Excel from VGS Export',
            accept = '.xlsx',
            placeholder = "Upload .xlsx file...",
            multiple = F
          ),
          selectInput(
            'select_sheet',
            'Select Excel Sheet (Method): ',
            choices = NULL ,
            selected = F,
            multiple = F
          ),

          submitButton("Load Columns"),
          
          br(),
          selectInput(
            'value_choice',
            'Select Columns: ',
            choices = "Load excel sheet first...",
            multiple = T,
            selectize = T
          ),
          
          
          
          
          ## use to be submit button - need to update server
          
          
          actionButton("go", "Load Data Table",
                       style="color: white; background-color: green; border-color: black")),
          
          p("Contact tsgilbert@arizona.edu with any feedback",
            style = "font-family: 'Jura'; color: dark blue; font-size: 14px;"),
      #mainPanel(width = 8,
      box(width = 10,
          DT::dataTableOutput('file_upload'))

      ),

      tabPanel(
        'Run Script',
        br(),
        #sidebarPanel(width = 4,
        selectInput(
          'select_user',
          'Select User Script: ',
          choices = c(
            ' ',
            'R6 Height-Curve Evaluation',
            'R6 Relative Frequency'
          ) ,
          selected = F,
          multiple = F
        ),
        
        htmlTemplate("template.html",
                     button = submitButton("Run Script")),
        
        br(),

        mainPanel(width = 8,

        DT::dataTableOutput('wMat_output'),
        
        tags$canvas(id = "myCanvas",
                    width = "100", height = "100"))

      ),

      tabPanel(
        '*Data Visualization*(Under Construction)',
        br(),
        #sidebarPanel(width = 4,
        selectInput(
          'select_user',
          'Select Data Visualization Tool: ',
          choices = c(
            ' ',
            'Freq over time'
          ),
          selected = F,
          multiple = F
        ),
        
        htmlTemplate("template.html",
                     button = submitButton("Run Tool")),
        
        br(),
        mainPanel(width = 8,
                  
                  plotlyOutput('tool_output'),
                  
                  tags$canvas(id = "myCanvas",
                              width = "100", height = "100"))

      )
    )
  )

)
