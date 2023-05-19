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
