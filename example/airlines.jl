# # USA Airlines 

# ## Import library 
using ForceBundle 

# ## Read data from csv
# `data/airlines.csv` content is as follows:
# 
# ```
# -922.24444,-347.29444,-932.16944,-448.83333
# -922.24444,-347.29444,-741.68611,-406.925
# ...
# ```
# Data can be read from a `.csv` file using [`read_edges_csv`](@ref) function. This uses `CSV.jl` library. 
DATA = joinpath(@__DIR__, "data", "airlines.csv")
#DATA = "https://raw.githubusercontent.com/tabitaCatalan/julia.ForceBundle/master/data/airlines.csv"
edges = read_edges_csv(DATA; subdivisions = 1);

# We select the first 100 edges 
edges = edges[1:200];

# ## Bundle the edges 
# We use the [`forcebundle`](@ref) function 

bundled_edges = forcebundle(edges);                            );

# ## Plot results  
using Plots: plot, plot! 

# A recipe is defined for `Edge`s, so we can use `plot(::Edge)` or `plot!(::Edge)`.
# We plot straight edges

a_plot = plot(title = "straight edges");
plot!.(edges, color = :red);
display(a_plot)

# and bundled edges.
b_plot = plot(title = "bundled edges");
plot!.(bundled_edges, color = :red);
display(b_plot)