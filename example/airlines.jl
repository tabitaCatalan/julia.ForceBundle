using ForceBundle 

# # Read data from csv
# Data can be read from a `.csv` file using `read_edges_csv` function. This uses `CSV.jl` library. 
# 
# 
# ```
# -922.24444,-347.29444,-932.16944,-448.83333
# -922.24444,-347.29444,-741.68611,-406.925
# ```

edges = read_edges_csv("data\\airlines.csv"; subdivisions = 1);
@enter forcebundle(edges, P = 2);

using Plots: plot, plot! 

a_plot = plot(title = "straight edges")
plot!.(edges, color = :red)
display(a_plot)

b_plot = plot(title = "bundled edges")
plot!.(bundled_edges, color = :red)
display(b_plot)