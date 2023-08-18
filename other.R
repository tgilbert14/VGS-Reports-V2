# Coronado script

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
  
  data2<- my_data2
  
  incProgress(1, detail = paste("Done!"))
  Sys.sleep(.5)
}
)