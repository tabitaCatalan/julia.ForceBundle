# # USA Airlines 

# ## Import library 
using ForceBundle 

# ## Read data from csv
# Data can be read from a `.csv` file using [`read_edges_csv`](@ref) function. This uses `CSV.jl` library. 
# 
# 
# ```
# -922.24444,-347.29444,-932.16944,-448.83333
# -922.24444,-347.29444,-741.68611,-406.925
# ...
# ```

edges = read_edges_csv("data\\airlines.csv"; subdivisions = 1);

# We select the first 100 edges 
edges = edges[1:100];

# ## Deform using [`forcebundle`](@ref) function 
bundled_edges = forcebundle(edges, P_initial = 2);

# ## Graficar 
using Plots: plot, plot! 

# A recipe is defined for `Edge`s, so we can use `plot(::Edge)` or `plot!(::Edge)`.
# We plot straight edges

a_plot = plot(title = "straight edges")
plot!.(edges, color = :red)
display(a_plot)

# and bundled edges.
b_plot = plot(title = "bundled edges")
plot!.(bundled_edges, color = :red)
display(b_plot)