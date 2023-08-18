
# WMAT Script
if (is.null(my_data)){ #statements to get rid of errors when nothing has been loaded yet
  return(NULL)
}
my_data2<- my_data

withProgress(message = 'Processing Data...', value = 0, {
  # Increment the progress bar, and update the detail text.
  incProgress(.25, detail = paste("Processing...25%"))
  Sys.sleep(0.5)
  
  incProgress(.75, detail = paste("Processing...75%"))
  Sys.sleep(0.5)
  
  # data2 <- my_data2 %>% group_by(c(input$value_choice2))
  # data2 <- data2 %>% summarise(avg_nValue = mean(nValue, na.rm=T))
  #selections<- input$value_choice2
    
  data2<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName, SpeciesName, nValue) %>%
    summarise(Average_Example = mean(nValue, na.rm=T))
  
  
  incProgress(1, detail = paste("Done!"))
  Sys.sleep(.5)
}
)
