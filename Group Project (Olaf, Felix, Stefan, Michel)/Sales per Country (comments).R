# Data Science Gruppenaufgabe
# Teilnehmer: Olaf Lampson, Stefan Maurer, Michel Schieder, Felix Stremmer
# Aufgabenstellung: Auflistung und grafische Darstellung der aufsummierten Umsätze nach Land 

# benötigte R-Packages laden

library(dbplyr)                    
library(dplyr)                     
library(RSQLite)                   
library(ggplot2)    


# Chinook.db als sqlite-DB laden und als "con" definieren

con <- src_sqlite("~/Downloads/chinook.db")                                    

# Tabelle "invoices" aus Chinook gleichnamig definieren
invoices <- con %>% tbl("invoices")                                             
# Die Tabelle "invoices"...    
invoices %>%  
  # ...nach "BillinCountry" sortieren
  group_by(Country = BillingCountry) %>%                                        
  # Die Spalte "Sales" aufsummieren
  summarise(Sales = sum(Total)) %>%                                            
  # ...nach aufsummieren Sales sortieren
  arrange(Sales) %>%                                                            
  
  # Die Spalten "Country" und "Sales" auswälen... 
  select(Country, Sales) %>%                                                    
  # ...und zur Darstellung einspeichern
  collect %>%   
  # ggplot zur Dartstellung der Daten als Balkendiagramm verwendet
  ggplot() +  
  # "Sales" der y-Achse zuweisen. Der x-Achse werden die Länder zugewiesen. Die die Sales repräsentierten Balken einfärben
  aes( y = Sales , x = reorder(Country, Sales), fill = Sales) +                    
  # Die Balken werden durch die absoluten Y-Werte repräsentiert
  geom_bar(stat = "identity" )  +                                                 
  # x- und y-Achse kippen
  coord_flip()  +                                                                
  # x-Achse bennen
  xlab("Country") +                                                               
  # y-Achse bennen
  ylab("Sales in $") +               
  # Balken einfärben
  scale_fill_gradient2( mid = "red" , high="green") +theme_classic()+             
  # Grafiktitel einfügen
  ggtitle("Sales Analysis by Country")+           
  # Schriftyp festlegen
  theme(plot.title = element_text( face="bold")) +                               
  # Y-Werte als Balkenlabel hinzufügen, positionieren und weiß einfärben
  geom_text(aes(label = round(Sales, digits = 1)), hjust = 1, colour = "white")  

