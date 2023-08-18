
# Define server logic required to draw a histogram
shinyServer(function(input, output, session) {
  
  result_auth <- secure_server(check_credentials = check_credentials(credentials))
  
  output$res_auth <- renderPrint({
    reactiveValuesToList(result_auth)
  })

  pickA <- reactive({
    file_data<- input$file1
    req(file_data)
    
    ##tester
    #fname<- paste0("C:/Users/tsgil/Downloads/Raw XLS Export (10).xlsx")
    
    fname <- file_data$datapath
    sheets <- readxl::excel_sheets(fname)
    tibble <- lapply(sheets, function(x) readxl::read_excel(fname, sheet = x))
    data_frame <- lapply(tibble, as.data.frame)
    names(data_frame) <- sheets
    a2 <- substring(sheets,1,18)
    a2 <- paste0(a2,"...")
    return(a2)
  })
  
  pick <- reactive({
    my_data<- reactive_data()
    req(my_data)
    a <- names(my_data)
    return(a)
  })
  
  observe({
    # create selection box
    updateSelectizeInput(session, "select_sheet",
                         choices = c("", pickA()), selected = F, server = TRUE
                         )
  })
  
  observe({
    # create selection box
    updateSelectizeInput(session, "value_choice",
                         choices = c(pick()), selected = c(pick()), server = TRUE
                         )
  })


  reactive_data<- reactive({ # start of react

    file_data<- input$file1
    
    ext <- tools::file_ext(file_data$datapath)
    
    validate(need(ext == "xlsx", "Please upload a xlsx file"))
    
    ex_sheet<- input$select_sheet
    validate(need(ex_sheet, "Please select a excel sheet to load"))
    
    a2<- pickA()
    
    req(file_data)
    req(ex_sheet)
    
    if (ex_sheet == ""){
      return(NULL)
    }
    
    i=1
    while (i < length(a2)+1) {
      if (ex_sheet == a2[i]){
        ex_sheet = i}
      i= i+1
    }
    my_data <- read_excel(file_data$datapath, sheet = as.integer(ex_sheet))
    }) # end of react
  
  
  output$file_upload<- DT::renderDataTable({
    my_data<- reactive_data()
    req(my_data)
    req(input$value_choice)

    if (is.null(input$value_choice)){
      return(NULL)
    }
    
    if (input$value_choice == "Load excel sheet first...") {
      a<- as.data.frame("Reselect specific categories for new Data Export on this Page OR
                        Move to the 'Script' Tab to run script for selected excel sheet...")
      names(a)<- "Data Loaded..."
      return(a)
    } else{
      my_data<- my_data %>% 
        select(c(input$value_choice))
      my_data<- unique(my_data)
    }
    
    data<- my_data

    # dynamic data table
    my_data <- DT::datatable(data, editable = TRUE, rownames = FALSE,
                             extensions = 'Buttons',
                          options = list(pageLength = 100000,
                                         searching = TRUE,
                                         ordering = TRUE,
                                         autoWidth = TRUE,
                                         dom = 'Bfrtip',
                                         buttons = c('csv', 'excel')),
                          style = "bootstrap",
                          class = "compact cell-border hover display",
                          filter = list(position = "top", plain = TRUE))
    
  },server=TRUE)


  output$wMat_output<- DT::renderDataTable({
    my_data<- reactive_data()
    req(my_data)

    if (is.null(my_data)){ #statements to get rid of errors when nothing has been loaded yet
      return(NULL)
    }
    
    if (input$select_user == " ") {
      base::source('other.R', local=TRUE)
    }
    if (input$select_user == "WMAT_Average") {
      base::source('Wmat.R', local=TRUE)
    }
    if (input$select_user == "Coronado Riparian Veg Plot") {
      base::source('Coronado.R', local=TRUE)
    }
    if (input$select_user == "NRCS - Zig Zag") {
      base::source('NRCS_ZigZag.R', local=TRUE)
    }
    if (input$select_user == "Annual Plants Compare") {
      base::source('ashley.R', local=TRUE)
    }
    if (input$select_user == "R6 Relative Frequency") {
      base::source('R6_relative_freq.R', local=TRUE)
    }
    if (input$select_user == "R6 Height-Curve Evaluation") {
      base::source('r6_colville_height_curve.R', local=TRUE)
    }
    
      my_data <- DT::datatable(data2, editable = TRUE, rownames = FALSE,
                               extensions = 'Buttons',
                               options = list(pageLength = 100000,
                                              searching = TRUE,
                                              ordering = TRUE,
                                              autoWidth = TRUE,
                                              dom = 'Bfrtip',
                                              buttons = c('csv', 'excel')),
                               style = "bootstrap",
                               class = "compact cell-border hover display",
                               filter = list(position = "top", plain = TRUE))
      
  },server=TRUE)
  
  output$tool_output<- renderPlotly({
    my_data<- reactive_data()
    req(my_data)
    
    if (is.null(my_data)){ #statements to get rid of errors when nothing has been loaded yet
      return(NULL)
    }
    
    if (input$select_user == " ") {
      base::source('other.R', local=TRUE)
    }
    
    if (input$select_user == "Freq over time") {
      base::source('plotly.R', local=TRUE)
    }
    
    if (input$select_user == "WMAT_Average") {
      base::source('Wmat.R', local=TRUE)
    }
    if (input$select_user == "Coronado Riparian Veg Plot") {
      base::source('Coronado.R', local=TRUE)
    }
    if (input$select_user == "NRCS - Zig Zag") {
      base::source('NRCS_ZigZag.R', local=TRUE)
    }
    if (input$select_user == "Annual Plants Compare") {
      base::source('ashley.R', local=TRUE)
    }
    if (input$select_user == "R6 Relative Frequency") {
      base::source('R6_relative_freq.R', local=TRUE)
    }
    
    
    my_data <- DT::datatable(data2, editable = TRUE, rownames = FALSE,
                             extensions = 'Buttons',
                             options = list(pageLength = 100000,
                                            searching = TRUE,
                                            ordering = TRUE,
                                            autoWidth = TRUE,
                                            dom = 'Bfrtip',
                                            buttons = c('csv', 'excel')),
                             style = "bootstrap",
                             class = "compact cell-border hover display",
                             filter = list(position = "top", plain = TRUE))
  })
  

})
