# NRCS Zig Zag script

if (is.null(my_data)){ #statements to get rid of errors when nothing has been loaded yet
  return(NULL)
}

my_data2<- my_data

withProgress(message = 'Processing Data...', value = 0, {
  # Increment the progress bar, and update the detail text.
  incProgress(.25, detail = paste("Processing...25%"))
  Sys.sleep(0.5)
  
  # averages by species
  data2<<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName, SpeciesName) %>%
    summarise("Avg DBH (in) by Species" = round(mean(nValue),2))
  
  data3<<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName, SpeciesName) %>%
    summarise("Avg Height (ft) by Species" = round(mean(nValue2),2))

  data4<<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName, SpeciesName) %>%
    summarise("Avg Distance Between Trees (ft) by Species" = round(mean(nValue3),2))
  
  d<- left_join(data2,data3)
  d2<- left_join(d,data4)

  incProgress(.75, detail = paste("Processing...75%"))
  Sys.sleep(0.5)
  
  # averages for all trees
  data5<<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName) %>%
    summarise("Avg DBH (in) by Site" = round(mean(nValue),2))
  
  data6<<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName) %>%
    summarise("Avg Height (ft) by Site" = round(mean(nValue2),2))
  
  data7<<- my_data2 %>%
    group_by(SiteID, Date, ProtocolName) %>%
    summarise("Avg Distance Between Trees (ft) by Site" = round(mean(nValue3),2))
  
  d3<- left_join(d2,data5)
  d4<- left_join(d3,data6)
  d5<- left_join(d4,data7)
  
  data2<- d5
  
  incProgress(1, detail = paste("Done!"))
  Sys.sleep(.5)
}
)

# To Determine Percent Crown Canopy
# 
# Use the following procedure:
# -total the column for spacing and divide the number of plants sampled to get the average spacing.
# 
# Procedure 
# 2. By calculation. For example, a 2-foot average diameter plant with an average 3-foot spacing.
# 
# a. To determine area of crown:
#   
#       A= 3.14r2, for a 2-foot dia-eter plant= 3.14(1)2 A= 3.14 sq. ft. average area of plant.
# 
# b. To determine number of plants per acre:
#   
#   Sq. ft. per acre average spacing of plants squared
# 
#       43,560 ♦ 32 = 4,840 plants per acre.
# 
# c. To determine percent canopy cover per acre:
#   
#   1. Average area of plant x number of plants= sq. ft. in acre plant occupies.
# 
#       3.14 x 4,840 - 15,198 sq. ft. per acre.
# 
#   2. Sq. ft. in area plant occupies sq. ft. in acre x 100 = %
# 
#     canopy cover of plants in acre.
# 
#       15,198 • 43,560 x 100 = 35% canopy cover/acre.
