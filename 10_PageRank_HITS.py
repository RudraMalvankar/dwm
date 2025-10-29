
def pagerank(graph, damping=0.85, iterations=3):
    ranks = {node: 1.0 for node in graph}

    for i in range(iterations):
        new_ranks = {}
        for node in graph:
            rank_sum = 0.0
            for other_node in graph:
                if node in graph[other_node]:
                    rank_sum += ranks[other_node] / len(graph[other_node])

            new_ranks[node] = (1 - damping) + damping * rank_sum
        
        ranks = new_ranks
        print(f"Iteration {i + 1}:")
        for node in sorted(ranks):
            print(f" {node}: {ranks[node]:.4f}")
        print("*" * 30)

    highest_node = max(ranks, key=ranks.get)
    print(f"Highest PageRank after {iterations} iterations: {highest_node} ({ranks[highest_node]:.4f})")
    
    return ranks

graph = {
    'A': ['B', 'C'],
    'B': ['C'],
    'C': ['A']
}

pagerank(graph)