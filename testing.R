##testing script
getwd()


d<- read_excel('Raw XLS Export (4).xlsx', sheet = 1)

## need count for speces
# data.sum<- data.raw %>%
#   group_by(plotID, scientificName, year_month) %>% 
#   summarise(count = n()) %>% 
#   filter(!is.na(scientificName)) %>% 
#   arrange(desc(count))
# 
# col_num<- data.sum %>% 
#   group_by(scientificName) %>% 
#   count()
names(d)

nb.cols <- length(unique(d$SpeciesName))
mycolors <- colorRampPalette(brewer.pal(8, "Set1"))(nb.cols)

a.plot<- ggplot(d, aes(Date, count, group = SpeciesName, fill = SpeciesName))+
  geom_point(aes(color=SpeciesName), size=.7)+
  geom_line(aes(color=SpeciesName)) +
  facet_wrap(facets = vars(plotID), scales = 'free')+
  scale_fill_manual(values = mycolors) +
  ggtitle(paste0(data.raw$siteID[1]," Species Per Plot by Month"))+
  #scale_fill_gradientn(colours=rev(rainbow(100, start=0, end=0.19)))+
  xlab("Date (Year_month)")+
  ylab("Species Count")+
  theme(axis.text.x = element_text(size = 8, angle = 45))

a.plot <- a.plot + theme(panel.spacing.x=unit(1, "lines"),panel.spacing.y=unit(1.5, "lines"))
a.plot<- ggplotly(a.plot, width = 1500, height = 800)
a.plot