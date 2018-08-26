# A* Algorithm
Combine greedy and dijkstra's algorithm to gurantee both speed and correctness.  Works by calculating cost of a node by combining movement cost and heuristic estimating the distance to target.

\\( f(n) = g(n) + h(n) \\)

where g(n) is the cost of the shorest path from start to n, and h(n) is a heuristic function estimating the cost of the direct path to the target.

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
      n.cost = cost(current_node, n) + heuristic(n, end)
    end if
    Q.push(neighbor)
  end for
end while
```

![](../img/a-star-result.png "A* result")
