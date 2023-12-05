import numpy as np

nodes = ['a', 'b', 'c', 'd']
edge_list = [('a','b'),  ('b','c'), ('c', 'a'), ('d', 'b'), ('a', 'd'), ('d', 'a')]
att_dict = {'a':1, 'b':1, 'c':2, 'd':2}

def score_func(edges, mutuals, triples, same):
    beta_1 = -1.5
    beta_2 = 2
    beta_3 = 1
    beta_4 = 1.5
    exponent = beta_1 * edges + beta_2 * mutuals + beta_3 * triples + beta_4 * same
    return np.exp(exponent)

def density(edge_list, node):
    count = 0
    for edge in edge_list:
        if edge[0] == node:
            count += 1
    return count

def reciprocity(edge_list, node):
    count = 0
    for edge in edge_list:
        if edge[0] == node and (edge[1], edge[0]) in edge_list:
            count += 1
    return count

def transitivity(nodes, edge_list, node):
    count = 0
    for edge in edge_list:
        if edge[0] == node and (edge[1], edge[0]) in edge_list:
            for trans_node in nodes:
                if (node, trans_node) in edge_list and (trans_node, edge[1]) in edge_list:
                    count += 1
    return count

def same_att(edge_list, att_dict, node):
    count = 0
    for edge in edge_list:
        if edge[0] == node and att_dict[edge[1]] == att_dict[node]:
            count += 1
    return count

def score_node(node, edge_list, att_dict, debug=False, debug_message=''):
    edges = density(edge_list, node)
    mutuals = reciprocity(edge_list, node)
    triples = transitivity(nodes, edge_list, node)
    same = same_att(edge_list, att_dict, node)
    if debug:
        print(debug_message)
        print(f'Edges={edges}, Mutuals:{mutuals}, Triples={triples}, Same={same}')
        print()
    return score_func(edges, mutuals, triples, same)

def toggle_edge(edge_list, edge):
    if edge[0] == edge[1]:
        return edge_list
    if edge in edge_list:
        popped_edge_list = [x for x in edge_list if x != edge]
        return popped_edge_list
    else:
        return edge_list + [edge]

def get_prob(nodes, edge_list, att_dict, edge):
    print(f'Calculating probability for: {edge}\n')
    node = edge[0]
    nom = score_node(node, toggle_edge(edge_list, edge), att_dict, debug=True, debug_message=f'Toggle Edge {edge}')
    den = 0
    for node_alt in nodes:
            den += score_node(node, toggle_edge(edge_list, (node, node_alt)), att_dict, debug=True, debug_message=f'Toggle Edge {(node, node_alt)}')
    print("********************************************************************")
    return nom/den

p1 = get_prob(nodes, edge_list, att_dict, ('c', 'b'))
p2 = get_prob(nodes, edge_list, att_dict, ('b', 'a'))
p3 = get_prob(nodes, edge_list, att_dict, ('a', 'b'))
p4 = get_prob(nodes, edge_list, att_dict, ('d', 'd'))
print(round(p1,3), round(p2,3), round(p3,3), round(p4,3))