
install.packages("DiagrammeR")
library(DiagrammeR)

DiagrammeR::grViz("digraph {
  
graph[layout = dot, rankdir = RR]

1 [label = 'Raw materials']
2 [label = ' Added Sugar', shape = Rectangle, fillcolor = Biege]
3 [label = 'Sugar Tax', shape = triangle]
4 [label = 'Outcome']
5 [label = 'Good', shape = hexagon]
6 [label = 'Bad', shape = hexagon]
7 [label = 'Sugar Beverages']
8 [label = 'No Sugar Tax', shape = triangle]
9 [label = 'Outcome']
10 [label = 'Good', shape = hexagon, colorfill = green]
11 [label = 'Bad', shape = hexagon]
12 [label = 'stakeholders', shape = 0]

1 -> 2 -> 7
          7-> 3
          7-> 8
          3-> 4 -> 5, 6
          8-> 9 -> 10, 11
    
}")
