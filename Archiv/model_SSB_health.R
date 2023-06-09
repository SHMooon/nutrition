# R script for the nutrition model
# author: Patrick Frey 

# load packages ####
library(decisionSupport)
# install.packages("DiagrammeR")
library(DiagrammeR)

model_SSB_health <- grViz("digraph {
compound=true
graph[layout = dot, rankdir = LR]
node[style = filled, margin = 0.1, fillcolor = 'azure', shape = rectangle]


            tax                     [label = 'Sugar tax for SSB']
              tax -> less_consum_SSB
            less_consum_SSB         [label = 'less consumption of SSB']
            less_consum_sug         [label = 'less consumption of Sugar']
            less_prod_sug           [label = 'less production of Sugar']
            
            cultivation_sugarbeet   [label = 'decreased sugar beet cultivation']
            turnover_sugarbeet      [label = 'decreased turnover of sugar beets']
            decreased_SSB_products  [label = 'decreased of SSB products']
            decrease_SB_farmer      [label = 'decrease of sugar beet farmers']
            
            area                    [label = 'Increased areas for sustainable cultivations']
            soil                    [label = 'changed soil properties']
            
            obecity                 [label = 'decreased obecity']
            
            govtax                  [label = 'higher tax returns for the goverment']
            loss_SSB_prod           [label = 'loss for SSB producers']

            
            less_consum_SSB -> less_consum_sug
  

      
      subgraph cluster_health { 
        graph[rankdir = TD, label = 'Health',
            fontsize = 28, shape = rectangle, style = dashed,
            fontcolor = grey, color = red]

            less_consum_sug -> obecity, less_prod_sug
            
        }
      
  
NPV
}")
model_SSB_health


# ipnut model with grViz ####
# presented: 16th of June 2023 
# 
# model_patrick <- grViz("digraph {
#   
# graph[layout = dot, rankdir = LR]
# node[style = filled, margin = 0.1, fillcolor = 'azure']
# 
# 
# I   [label = 'Input for Decision']
# pos [label = 'Positiv Support', fillcolor = 'green']
# neg [label = 'Negativ Support', fillcolor = 'red']
# 
# sh  [label = 'Stakeholder', shape = rectangle]
# res [label = 'Results of Countries', shape = rectangle]
# 
# gov [label = 'Goverment', shape = rectangle]
# ind [label = 'Individuals', shape = rectangle]
# sm [label = 'Supermarkets', shape = rectangle]
# man [label = 'Manufactories', shape = rectangle]
# 
# rs  [label = 'Research', shape = rectangle]
# 
# gov, ind, sm, man -> sh -> pos, neg
# rs -> res
# res -> pos, neg 
# pos, neg -> I
# 
# }")
# 
# 


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
