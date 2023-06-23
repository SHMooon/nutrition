# R script for the nutrition model
# author: Patrick Frey 

# load packages ####
library(decisionSupport)
# install.packages("DiagrammeR")
library(DiagrammeR)

grViz("digraph {
compound=true
graph[layout = dot, rankdir = LR]
node[style = filled, margin = 0.1, fillcolor = 'azure', shape = rectangle]


tax       [label = 'Sugar tax for SSB']
tax -> cultivation_sugarbeet[lhead = cluster_assumptions]


subgraph cluster_assumptions { 
      graph[rankdir = LR, label = 'Assumptions',
            fontsize = 28, shape = rectangle, style = dashed,
            fontcolor = grey]

      subgraph cluster_economic { 
      graph[rankdir = TD, label = 'Economic',
            fontsize = 28, shape = rectangle, style = dashed,
            fontcolor = grey, color = orange]

      cultivation_sugarbeet [label = 'Decreased sugar beet cultivation']
      turnover_sugarbeet    [label = 'Decreased turnover of sugar beets']
      
      cultivation_sugarbeet -> turnover_sugarbeet
      }
      
      subgraph cluster_ecologic { 
      graph[rankdir = TD, label = 'Ecologic',
            fontsize = 28, shape = rectangle, style = dashed,
            fontcolor = grey, color = green]

      area          [label = 'Increased areas for sustainable cultivations']
      soil          [label = 'changed soil properties']
      }
      
      subgraph cluster_social { 
      graph[rankdir = TD, label = 'Social',
            fontsize = 28, shape = rectangle, style = dashed,
            fontcolor = grey, color = blue]

      demo          [label = 'Demonstration against the tax']
      gab           [label = 'Increases gab between poor and rich']
      }
      
      subgraph cluster_health { 
      graph[rankdir = TD, label = 'Health',
            fontsize = 28, shape = rectangle, style = dashed,
            fontcolor = grey, color = red]

      red_sugar           [label = 'Reduced Sugar consumption']
      obecity             [label = 'less obecity']
      
      red_sugar -> obecity
      }
      

Other_factors 

obecity, turnover_sugarbeet, area, soil, demo, gab, Other_factors -> Calculation

}

Calculation -> NPV


}")



# ipnut model with grViz ####
# presented: 16th of June 2023 

model_patrick <- grViz("digraph {
  
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
