"""
bundle!(P::Edge, forces, ds)
Bundle edge P applying a vector of forces on every inner subdivision, and moving
in a ammount ds
"""
function bundle!(P::Edge, inner_forces, ds)
    #inner_nodes(P).x .+= forces.x * ds
    #inner_nodes(P).y .+= forces.y * ds
    
    # TODO do this in a better way
    for i in inner_range(P)
        node(P,i).x += inner_forces[i-1].x * ds 
        node(P,i).y += inner_forces[i-1].y * ds
    end 
end


function bundling_iteration(edges, K, ds)
    range = 1:length(edges)
    forces = ListOfNodes([calculate_electro_forces(edges, i) + calculate_spring_forces(edges[i], K) for i in range])
    for i in range
        bundle!(edges[i], forces[i], ds)
    end
end


function bundled_length(nods)
    sum(norm.(nods[2:end] - nods[1:end-1]))
end

bundled_length(edge::Edge) = bundled_length(nodes(edge))

function update_divisions(edge::Edge, P)
    L = bundled_length(edge)
    nods = nodes(edge)
    new_segments_len = L/(P+1) #segment_length
    current_node = source(edge)
    new_nodes = ListOfNodes([current_node])
    remaining_segment_len = new_segments_len #current...
    i = 2
    while i <= length(nods)
        old_segment = norm(nods[i] - current_node)
        direction = (nods[i] - current_node)/old_segment
        if remaining_segment_len > old_segment # me paso de largo
            remaining_segment_len -= old_segment
            current_node = nods[i]
            i += 1
        else
            current_node += remaining_segment_len * direction
            push_node!(new_nodes, current_node)
            remaining_segment_len = new_segments_len
        end
    end
    return Edge(new_nodes)
end
