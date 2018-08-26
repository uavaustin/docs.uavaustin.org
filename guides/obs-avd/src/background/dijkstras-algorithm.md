# Breadth First search
Breadth first search starts at a node and evaluate all of its immediate neighbors before evaluating their children.

# Dijkstra's Algorithm
Dijkstra build on top of breadth first search but accounts for movement cost to prioritize path with lower cost.

# Pseudocode
```text
for all node n
  n.cost = INFINITY
end for
let Q be a queue
Q.push(start)
while Q is not empty
  current_node = Q.pop()
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
