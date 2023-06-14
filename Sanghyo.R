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
SSB <- merge(World, SSB_Tax_Database_Feb23, by.x="iso_a3", by.y="wb_code")

tm_shape(SSB$continent=="Europe")+
  tm_polygons("bev") +
  tm_layout(main.title = "Basis_tiers",
            main.title.position = "center",
            main.title.color = "lightblue")+
  tm_text(text = "iso_a3", size = 0.2)

data("Europe")

tm_shape(World[World$continent=="Europe",]) 



tm_shape(World) + tm_polygons("lightyellow") + 
  tm_facets(by = "continent", free.coords = TRUE, free.scales = F)  

#tm_bubble(color... color vector ) -> ?tm_bubbles
  #tm_bubbles(size="area", col="2021",
             #palette = pubu : different color skin, different vector color
             #palette="PuBu")

#find out how i can use select.... 
#find sugar consumption world wide... or something like that.. ,,,
#use soft drink tax. 