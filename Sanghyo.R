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
data("World")
tm_shape(World)+
  tm_polygons()

#install.packages ("wbstats")
library(wbstats)
library(tidyverse)

a <- wb_search(pattern="SSB")
a

library(readr)
sugar_world_consumption <- read.csv("Sugar_World-MarketTrade.csv", sep=",")
colnames(sugar_world_consumption)<-gsub("X","",colnames(sugar_world_consumption))

head(sugar_world_consumption)

SWC2021<- select(sugar_world_consumption, Country,2021)


#find out how i can use select.... 
#find sugar consumption world wide... or something like that.. ,,,