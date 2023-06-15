#Plot the impact pathway
library(decisionSupport)
library(DiagrammeR)
#1

Sanghyo <- mermaid("graph LR
        G(Gorvernment)-->T(Tax); linkStyle 0 stroke:green, stroke-width:1.5px
        T--> F(Final result: Sugar reduction); linkStyle 1 stroke: green, stroke-width:1.5px
        S(Supermarket)-->A(Arrange of Products); linkStyle 2 stroke: green, stroke-width:1.5px
        A -->F; linkStyle 3 stroke: green, stroke-width:1.5px
        I(Individuals)-->E(Education); linkStyle 4 stroke: green, stroke-width:1.5px
        E-->F; linkStyle 5 stroke: green, stroke-width:1.5px")
Sanghyo


#MAPs

#install.packages("raster")
library(raster)

#install.packages("sp")
library(sp)


#install.packages("tmap")
library(tmap)

# for loading our data
library(raster)
library(readr)
library(readxl)
library(sf)
# for datasets
##install.packages("purrr")
library(maps)
##install.packages("spData")
library(spData)
# for creating animations
##install.packages("magick")
library(magick)
# for plotting
library(grid)
library(tmap)
library(viridis)
library(ggplot2)

data("World")


#install.packages ("wbstats")
library(wbstats)
library(tidyverse)

a <- wb_search(pattern="SSB")
a

library(readr)
sugar_world_consumption <- read.csv("SC.csv")

colnames(sugar_world_consumption)<-gsub("X","",colnames(sugar_world_consumption))

head(sugar_world_consumption)

SWC2021<- filter(sugar_world_consumption, date == 2021)

mergeData <- merge(World, sugar_world_consumption, by.x="sovereignt", by.y="Country",
                   all.x=TRUE)

tm_shape(mergeData)+
  tm_polygons("2021", palette = "BrBG") +
  tm_layout(main.title = "World sugar consumption 2021",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)
 

 ####### make data numeric by 2021!!!!!####

library(readxl)
SSB_Tax_Database_Feb23 <- read_excel("Sanghyo/SSB-Tax-Database-Feb23.xlsx")




#Continent 
#Europe
Europe <- World[World$continent=="Europe",]
SSB_Europe <- merge(Europe, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(Europe)+
  tm_polygons()+
tm_shape(SSB_Europe)+
  tm_polygons("carbonates")+
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)

#cut the map of europe


#Africa
Africa <- World[World$continent=="Africa",]
SSB_Africa <- merge(Africa, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(Africa)+
  tm_polygons()+
tm_shape(SSB_Africa)+
  tm_polygons("carbonates")+
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)

#Asia

Asia <- World[World$continent=="Asia",]
SSB_Asia <- merge(Asia, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(Asia)+
  tm_polygons()+
  tm_shape(SSB_Asia)+
  tm_polygons("carbonates")+
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)


#North America

NorthAmerica <- World[World$continent=="North America",]
SSB_NorthAmerica <- merge(NorthAmerica, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(NorthAmerica)+
  tm_polygons()+
  tm_shape(SSB_NorthAmerica)+
  tm_polygons("carbonates")+
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)


#####add USA cities!! 


#South America

SouthAmerica <- World[World$continent=="South America",]
SSB_SouthAmerica <- merge(SouthAmerica, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(SouthAmerica)+
  tm_polygons()+
  tm_shape(SSB_SouthAmerica)+
  tm_polygons("carbonates")+
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)


#oceania

Oceania <- World[World$continent=="Oceania",]
SSB_Oceania <- merge(Oceania, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(Oceania)+
  tm_polygons()+
  tm_shape(SSB_Oceania)+
  tm_polygons("carbonates")+
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)


#find out how i can use select.... 
#find sugar consumption world wide... or something like that.. ,,,
#use soft drink tax. 