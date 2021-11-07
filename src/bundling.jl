using Statistics: median
using ProgressMeter 

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


function bundling_iteration!(edges, K, ds, threshold)
    range = 1:length(edges)
    forces = [calculate_electro_forces(edges, i, threshold) + calculate_spring_forces(edges[i], K) for i in range]
    for i in range
        bundle!(edges[i], forces[i], ds)
    end
end


function bundled_length(nods)
    sum(norm.(nods[2:end] - nods[1:end-1]))
end

bundled_length(edge::Edge) = bundled_length(nodes(edge))

# approximate leq and geq 
≲(a,b) = (a ≤ b) || (a ≈ b) 
≳(a,b) = (a ≥ b) || (a ≈ b) 

"""
    update_divisions(edge::Edge, P)
Creates a new `Edge` with `P` subdivisions, trying to preserve 
the shape of the original `edge`. 
"""
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
        if remaining_segment_len ≲ old_segment 
            current_node += remaining_segment_len * direction
            push_node!(new_nodes, current_node)
            remaining_segment_len = new_segments_len
        else # me paso de largo 
            remaining_segment_len -= old_segment
            current_node = nods[i]
            i += 1
        end
    end
    return Edge(new_nodes)
end

# Pkg.add("ProgressBars") 

#=
Cicle of bundling 
TODO not process small edges 
TODO use compat measures
=#

function bundling_cycle(edges, ds, P, K, threshold) 
    edges = update_divisions.(edges, P)
    bundling_iteration!(edges, K, ds, threshold)
    edges 
end 

"""
    forcebundle
Use Force Directed Edge Bundling to modify a list of `Edge`s. 
# Arguments 
- `edges`: array of `Edge`s.
## Optional arguments  
- `C = 6`: number of cycles of bundling to perform.
- `K = 0.1`: global bundling constant controlling edge stiffness.
- `S_initial = 0.1 * median(bundled_length.(edges))`: initial distance to move points.
- `S_rate = 0.5`: distance rate decreases (`0 < S_rate < 1`).
- `P_initial = 1`: initial subdivision number.
- `P_rate = 2`: subdivision rate increase (`1 < P_rate`).
- `I_initial = 60`: initial number of iterations per cycle.
- `I_rate = 2/3`: rate at which iteration number decreases (`0 < I_rate < 1`). 
- `compatibility_threshold = 0.5`: two edges `P` and `Q` only interact when `ForceBundle.compatibility(P,Q) > compatibility_threshold`. 
    Must be a number in `(0,1)`.
"""
function forcebundle(edges; C = 6,
                            K = 0.1,
                            S_initial = 0.1 * median(bundled_length.(edges)), 
                            S_rate = 0.5,
                            P_initial = 1, 
                            P_rate = 2, 
                            I_initial = 60, 
                            I_rate = 2/3, 
                            compatibility_threshold = 0.5
                            ) 
    S = S_initial
    P = P_initial
    I = I_initial

    @showprogress 1 for _c in 1:C # cycle of bundling 
        
        for _i in 1:I # iterations per cycle 
            edges = bundling_cycle(edges, S, P, K, compatibility_threshold) 
        end 
        # prepare for next cycle
        S = S * S_rate 
        P = ceil(Int, P * P_rate)
        I = ceil(Int, I * I_rate)
    end 
    edges
end 