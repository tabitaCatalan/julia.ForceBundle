calculate_kp(P::Edge, K) = K/( len(P) * (subdivisions(P)+1)) 

# Forces
"""
    spring_force(p::Point, op::Point, kp)
wSpring force acting on `p` induced by `op`.
# Arguments 
- `kp`: spring coefficient. 
"""
spring_force(p::Point, op::Point, kp) = kp * (op - p)


"""
    electro_force(p::Point, op::Point, C)
Electric force acting on `p` induced by `op`.
# Arguments 
- `C`: compatibility between `p` and `q`.
"""
electro_force(p::Point, op::Point, C) = p != op ? C * (op - p)/norm(op - p) : ForceFactor(0.0,0.0)

# More descriptive name 
ForceFactor = Point

"""
# Arguments 
- `edges`: a list of `Edge`s.
- `index`: of edge which is being deformated.
"""
function eforce_on_node_i(i, edges, index, threshold) # TODO change variable to more descriptive ones 
    # eforce on node i of index-th edge, induced by edge j (node i)
    #eforces_on_node_i_from_edge_j = (i, j) -> electro_force(nodes(edges[index])[i], nodes(edges[j])[i], compatibility(edges[index], edges[j]))
    force = ForceFactor(0.0,0.0)
    for j in 1:length(edges) # recorrer todas las aristas 
        if index != j && are_compatible(edges[j], edges[index], threshold) # no induce fuerza sobre si mismo y son compatibles
            force += electro_force(nodes(edges[index])[i], nodes(edges[j])[i], compatibility(edges[index], edges[j]))
        end
    end
    force
end

function calculate_electro_forces(edges, index, threshold)
    ListOfNodes([eforce_on_node_i(i,edges, index, threshold) for i in inner_range(edges[index])])
end

"""
    calculate_spring_forces(P::Edge, K)
Calculate spring forces acting on every inner node of an edge P.
Returns a `ListOfNodes`.
"""
function calculate_spring_forces(P::Edge, K)
    all_nodes = nodes(P)
    kp = calculate_kp(P, K)
    spring_force_on_node_i = (i) -> spring_force(all_nodes[i], all_nodes[i-1], kp) + spring_force(all_nodes[i], all_nodes[i+1], kp)
    ListOfNodes([spring_force_on_node_i(i) for i in inner_range(P)])
end

