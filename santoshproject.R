
#install.packages("DiagrammeR")
library(DiagrammeR)

DiagrammeR::grViz("digraph {
  
graph[layout = dot, rankdir = RR]
node[style=filled]

3 [label = 'SUGAR TAX', shape = triangle]
4 [label = 'Outcome']
<<<<<<< HEAD
5 [label = 'Good', shape = hexagon, fillcolor= 'green']
6 [label = 'Bad', shape = hexagon, fillcolor = 'firebrick']
7 [label = 'Decision', shape = cylinder, fontsize= 24, style='bold']
=======
5 [label = 'Good', shape = hexagon]
6 [label = 'Bad', shape = hexagon]
7 [label = 'Sugar Beverages']
>>>>>>> e9cec74710341aed1a4f831a434f84de0a2f30f8
8 [label = 'NO SUGAR TAX', shape = invtriangle]
9 [label = 'Outcome']
10 [label = 'Good', shape = hexagon, fillcolor = 'green']
11 [label = 'Bad', shape = hexagon, fillcolor = 'firebrick']

          7-> 3->4 -> 5, 6
          7-> 8-> 9 -> 10, 11
<<<<<<< HEAD
          5->3 [color= 'green']
          6->8 [style= 'dashed', color='firebrick']
          10->8 [color = 'green']
          11->3 [style= 'dashed', color='firebrick']
=======
          5->3
          6->8 
          10->8
          11->3
          12->8,3
>>>>>>> e9cec74710341aed1a4f831a434f84de0a2f30f8
}")
