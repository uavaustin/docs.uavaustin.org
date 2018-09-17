# Breadth First search
Breadth first search starts at a node and evaluate all of its immediate neighbors before evaluating their children.  In other words, it starts to a node and evaluate all children one node away from it, then evaluate all children two nodes away from it, and so on.

# Dijkstra's Algorithm
Dijkstra build on top of breadth first search but accounts for movement cost to prioritize path with lower cost but redirecting parent of a node if there is a shorter alternate path to it.  For example, node 1 is originally parent of node 2 (i.e node 2 came from node 1). If,  while evaluating node 3 neighboring node 2, the algorithm finds the cost of moving from node 3 to node 2 is lower than that of its current cost, node 2's parent would be changed to node 3 and its cost updated accordingly.

# Pseudocode
```text
for all node n
  n.cost = INFINITY
end for
let Q be a queue
Q.push(start)

while Q is not empty
  current_node = Q.pop()
  if current_node == end
    return path
  end if

  for neighbor n of current_node
    if cost(current_node, n) < n.cost
      n.parent = current_node
      n.cost = cost(current_node, n)
    end if
    Q.push(neighbor)
  end for
end while
```

# Problem
guaranteed to find the shortest path, but takes much longer

![](../img/dijkstra-problem.png "dijkstra problem")
