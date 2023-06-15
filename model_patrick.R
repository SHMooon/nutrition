# R script for the nutrition model
# author: Patrick Frey 

# load packages ####
library(decisionSupport)
# install.packages("DiagrammeR")
library(DiagrammeR)


# ipnut model with grViz ####
grViz("digraph {
  
graph[layout = dot, rankdir = LR]
node[style = filled, margin = 0.1, fillcolor = 'azure']


I   [label = 'Input for Decision']
pos [label = 'Positiv Support', fillcolor = 'green']
neg [label = 'Negativ Support', fillcolor = 'red']

sh  [label = 'Stakeholder', shape = rectangle]
res [label = 'Results of Countries', shape = rectangle]

gov [label = 'Goverment', shape = rectangle]
ind [label = 'Individuals', shape = rectangle]
sm [label = 'Supermarkets', shape = rectangle]
man [label = 'Manufactories', shape = rectangle]

rs  [label = 'Research', shape = rectangle]

gov, ind, sm, man -> sh -> pos, neg
rs -> res
res -> pos, neg 
pos, neg -> I

}")




# 
# model_patrick <- mermaid("graph LR
#         rc(Results of the Countries) --> sup(Support)
#         
#         gov(Goverment) --> sh(Stakeholders)
#         ind(Individuals) --> sh
#         sm(Supermarket) --> sh
#         man(Manufactories) --> sh
#         law(Curent state of law) --> gov
#         rn(Recommended nutrition by WHO) --> ind
#         int(Interests) --> sm
#         int --> man
#         sh --> sup
#         
#         in(Input) --> law
#         in(Input) --> rn
#         in(Input) --> int
#         
#         sup --> D(Decision)
#         D --> O(Outcome)
#         O --> G(Good)
#         O --> B(Bad)
#         
#         G --> in
#         B --> in
#         
#         X(X) --> Y
#         ")
#         
# ?mermaid
# 
# model_patrick
# 



# ?DiagrammeR
