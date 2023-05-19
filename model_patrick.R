# R script for the nutrition model
# author: Patrick Frey 

# load packages ####
library(decisionSupport)
# install.packages("DiagrammeR")
library(DiagrammeR)

model_patrick <- mermaid("graph LR
        G(Goverment)-->SR(Sugar Reduction); linkStyle 0 stroke: green, stroke-width:1.5px
        S(Supermarket)-->SR; linkStyle 1 stroke: red, stroke-width:1.5px
        I(Individual)-->SR; linkStyle 2 stroke: red, stroke-width:1.5px")
