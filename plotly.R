## plotly.R


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
  
  ## plotly data here example
  # nb.cols <- nrow(col_num)
  # mycolors <- colorRampPalette(brewer.pal(8, "Set1"))(nb.cols)
  # 
  # a.plot<- ggplot(data.sum, aes(year_month, count, group = scientificName, fill = scientificName))+
  #   geom_point(aes(color=scientificName), size=.7)+
  #   geom_line(aes(color=scientificName)) +
  #   facet_wrap(facets = vars(plotID), scales = 'free')+
  #   scale_fill_manual(values = mycolors) +
  #   ggtitle(paste0(data.raw$siteID[1]," Species Per Plot by Month"))+
  #   #scale_fill_gradientn(colours=rev(rainbow(100, start=0, end=0.19)))+
  #   xlab("Date (Year_month)")+
  #   ylab("Species Count")+
  #   theme(axis.text.x = element_text(size = 8, angle = 45))
  # 
  # a.plot <- a.plot + theme(panel.spacing.x=unit(1, "lines"),panel.spacing.y=unit(1.5, "lines"))
  # a.plot<- ggplotly(a.plot, width = 1500, height = 800)
  # a.plot
  
  incProgress(1, detail = paste("Done!"))
  Sys.sleep(.5)
}
)