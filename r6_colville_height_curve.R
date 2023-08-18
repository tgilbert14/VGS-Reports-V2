
# grabbing data
if (is.null(my_data)){ #statements to get rid of errors when nothing has been loaded yet
  return(NULL)
}
# renaming data
my_data2<- my_data

# progress bar
withProgress(message = 'Processing Data...', value = 0, {
  # Increment the progress bar, and update the detail text.
  incProgress(.25, detail = paste("Processing...25%"))
  Sys.sleep(0.3)
  
  View(my_data2)
  # process data - filter to form type
  data2<- my_data2 %>%
    filter(FormName == "Height-Weight Curve")
  # separate by date
  
  ## summarize data ------------------------------------------------------------
  # number of Ungrazed plants total
  # total height of Ungrazed plants
  # number of sampled plants
  # total % utilization (add up all Utilization)
  # average Ungrazed plants (total H/# Ungrazed)
  # average utilization (% utilization/# of plants)
  
  
  incProgress(.75, detail = paste("Processing...75%"))
  Sys.sleep(0.3)
  
  # finish processing data
  # data2<- my_data2 %>%
  #   group_by(SiteID, Date, ProtocolName, SpeciesName, nValue) %>%
  #   summarise(Average_Example = mean(nValue, na.rm=T))
  
  
  # rendering markdown document
  # rendering labels with uploaded tracking sheet...
  rmarkdown::render("r6_colville_height_curve.Rmd", output_format = "html_document")
  pagedown::chrome_print("r6_colville_height_curve.html",output = "r6_colville_height_curve.pdf")
  system2("open","r6_colville_height_curve.pdf")
  
  incProgress(1, detail = paste("Done!"))
  Sys.sleep(.3)
}
)
