# Data Science Gruppenaufgabe
# Teilnehmer: Olaf Lampson, Stefan Maurer, Michel Schieder, Felix Stremmer
# Aufgabenstellung: Auflistung und grafische Darstellung der aufsummierten Umsätze nach Land 


library(dbplyr)                    
library(dplyr)                    
library(RSQLite)                  
library(ggplot2)                  
con <- src_sqlite("~/Downloads/chinook.db")                                    
invoices <- con %>% tbl("invoices")                                              
invoices %>%                                                                    
  group_by(Country = BillingCountry) %>%                                        
  summarise(Sales = sum(Total)) %>%                                             
  arrange(Sales) %>%                                                           
  
  select(Country, Sales) %>%                                                    
  
  collect %>%                                                                  
  ggplot() +                                                                      
  aes( y = Sales , x = reorder(Country, Sales), fill = Sales) +                    
  geom_bar(stat = "identity" )  +                                                 
  coord_flip()  +                                                                 
  xlab("Country") +                                                               
  ylab("Sales in $") +               
  scale_fill_gradient2( mid = "red" , high="green") +theme_classic()+             
  ggtitle("Sales Analysis by Country")+           
  theme(plot.title = element_text( face="bold")) +                               
  geom_text(aes(label = round(Sales, digits = 1)), hjust = 1, colour = "white")
