#Data Science Gruppenaufgabe
#Teilnehmer: Olaf Lampson, Stefan Maurer, Michel Schieder, Felix Stremmer
#Aufgabenstellung: Vergleich der Sales Representatives entsprechend ihrer Umsätze

#Benötigte R-Packages laden
library(dbplyr)                    
library(dplyr)                    
library(RSQLite)                  
library(ggplot2)                                                                 

#Chinook.db als sqlite-DB laden und als "con" definieren 
con <- src_sqlite("~/Downloads/chinook.db")                                         

#Tabelle "invoices" aus Chinook gleichnamig definieren 
invoices <- con %>% tbl("invoices")        
#Tabelle "customers" aus Chinook gleichnamig definieren 
customers <- con %>% tbl("customers")                                               

#Beide Tabellen anhand Identifier "CustomerID"zusammenführen und als "data" definieren
data <- customers %>%                                                               
  inner_join(invoices, by = "CustomerId")    

#Die gejointe Tabelle "data"..
data %>%     
  #...nach Spalte "SupportRepID" unter Bezeichnung "Rep" gruppieren
  group_by(Rep = SupportRepId) %>%                                                  
  #Spalte "Total" unter Bezeichnung "Sales" summieren
  summarize(Sales = sum(Total)) %>%                                                
  #Beide Spalten auswählen...
  select(Rep, Sales) %>%                                                           
  #...und zur Darstellung in R "einsammeln"
  collect %>%                                                                       
  
  #Mithilfe von ggplot-Package Daten in Balkendiagramm visualisieren:
  ggplot() +                                                                          
  #"Rep" der X-Achse und "Sales" der Y-Achse zuweisen, Balken einfärben
  aes(x = Rep, y = Sales, fill = Rep) +                                             
  #Breite der Balken festlegen, absolute Y-Werte durch Balkenhöhe repräsentieren
  geom_bar(width = .9, stat = "identity") +                                         
  #Balkenumrandung entfernen
  guides(fill = FALSE) +                                                            
  #X-Achse benennen
  xlab("Sales Rep ID") +                                                            
  #Y-Achse benennen
  ylab("Sales in EUR") +                                                            
  #Hintergrundtheme bestimmen (weiß ohne Hilfslinien)
  theme_classic() +                                                                 
  #Grafiktitel einfügen...
  ggtitle("Comparison:\n Sales Rep Performance") +                                  
  #...und Schriftyp fett darstellen
  theme(plot.title = element_text(face = "bold")) +                                 
  #Y-Werte dals Balkenlabel hinzufügen, positionieren und weiß einfärben
  geom_text(aes(label = round(Sales, digits = 2)), vjust = 2, color = "white")      

