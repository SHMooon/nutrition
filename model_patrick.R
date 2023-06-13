# R script for the nutrition model
# author: Patrick Frey 

# load packages ####
library(decisionSupport)
# install.packages("DiagrammeR")
library(DiagrammeR)

model_patrick <- mermaid("graph LR
        rc(Results of the Countries) --> sup(Support)
        
        gov(Goverment) --> sh(Stakeholders)
        ind(Individuals) --> sh
        sm(Supermarket) --> sh
        man(Manufactories) --> sh
        law(Curent state of law) --> gov
        rn(Recommended nutrition by WHO) --> ind
        int(Interests) --> sm
        int --> man
        sh --> sup
        
        in(Input) --> law
        in(Input) --> rn
        in(Input) --> int
        
        sup --> D(Decision)
        D --> O(Outcome)
        O --> G(Good)
        O --> B(Bad)
        
        G --> in
        B --> in
        ")
        
?mermaid

model_patrick

grViz("digraph {
  
graph[layout = dot, rankdir = LR]

O [label = 'Outcome']
G [label = 'Good']
B [label = 'Bad']   

D [label = 'Decision']
sup [label = 'Support']

rc [label = 'Results of Countries with Taxes']
gov [label = 'Goverment']
ind [label = 'Individuals']
sm [label = 'Supermarkets']
man [label = 'Manufactories']
sh [label = 'Stakeholder']

gov, ind, sm, man -> sh -> sup
rc -> sup
sup -> D
D -> O
O -> G, B
G, B -> sh

}")



?DiagrammeR
