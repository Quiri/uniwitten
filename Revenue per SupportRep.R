#Data Science Gruppenaufgabe
#Teilnehmer: Olaf Lampson, Stefan Maurer, Michel Schieder, Felix Stremmer
#Aufgabenstellung: Vergleich der Sales Representatives entsprechend ihrer Umsätze

library(dbplyr)                    
library(dplyr)                    
library(RSQLite)                  
library(ggplot2)                                                                 

con <- src_sqlite("~/Downloads/chinook.db")                                         

invoices <- con %>% tbl("invoices")        
customers <- con %>% tbl("customers")                                               

data <- customers %>%                                                               
  inner_join(invoices, by = "CustomerId")    

data %>%     
  group_by(Rep = SupportRepId) %>%                                                  
  summarize(Sales = sum(Total)) %>%                                                
  select(Rep, Sales) %>%                                                           
  collect %>%                                                                       
  
  ggplot() +                                                                          
  aes(x = Rep, y = Sales, fill = Rep) +                                             
  geom_bar(width = .9, stat = "identity") +                                         
  guides(fill = FALSE) +                                                            
  xlab("Sales Rep ID") +                                                            
  ylab("Sales in EUR") +                                                            
  theme_classic() +                                                                 
  ggtitle("Comparison:\n Sales Rep Performance") +                                  
  theme(plot.title = element_text(face = "bold")) +                                 
  geom_text(aes(label = round(Sales, digits = 2)), vjust = 2, color = "white")      

