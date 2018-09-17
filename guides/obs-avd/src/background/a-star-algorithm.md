# A* Algorithm
Combine greedy and dijkstra's algorithm to gurantee both speed and correctness.  Works by calculating cost of a node by combining movement cost and heuristic estimating the distance to target.

\\( f(n) = g(n) + h(n) \\)

where g(n) is the cost of the shorest path from start to n, and h(n) is a heuristic function estimating the cost of the direct path to the target.

# Pseudocode
```text
unmark all nodes
for all node n
  n.cost = INFINITY
end for
let S be a set
S.push(start)

while S is not empty
  current_node = node in S with lowest cost
  if current_node == end
    return path
  end if

  mark current_node as visited
  for neighbor n of current_node
    if neighbor is marked
      continue
    end if
    cost = cost(current_node, n) + heuristic(n, end)
    if cost < n.cost
      n.parent = current_node
      n.cost = cost
    end if
    S.push(neighbor)
  end for
end while
```

![](../img/a-star-result.png "A* result")
