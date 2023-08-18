## script for R6 Relative FREQ

## take element # and add them up to get %
## need to change element score of 0 to 4

if (is.null(my_data)){ #statements to get rid of errors when nothing has been loaded yet
  return(NULL)
}

my_data2<- my_data

withProgress(message = 'Processing Data...', value = 0, {
  # Increment the progress bar, and update the detail text.
  incProgress(.25, detail = paste("Processing...25%"))
  Sys.sleep(0.5)
  
  
  
  incProgress(.50, detail = paste("Processing...75%"))
  Sys.sleep(0.5)
  
  selections<- input$value_choice2
  
  # data2
  # data2[data2$Element == 0] <- 4
  my_data2$Element<- as.numeric(my_data2$Element)
  ## script here
  data2<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName, SpeciesName, SpeciesSymbol, Element) %>%
    summarise(Sum_Example = sum(Element, na.rm=T))
  
  incProgress(.75, detail = paste("Processing...75%"))
  Sys.sleep(0.5)
  
  data2
  incProgress(1, detail = paste("Done!"))
  Sys.sleep(.5)
}
)
