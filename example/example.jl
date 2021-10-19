# Example use of ForceBundle 
#=
using StaticArrays
using StructArrays
using LinearAlgebra
using CSV
=#

a = 1

cd("ForceBundle")
using ForceBundle 


p0 = Point(0.,0.)
p1 = Point(1.,1.)
P = Edge(p0,p1, subdivisions = 3)
Q = Edge(Point(0.0, 0.0), Point(-1.,0.))
ForceBundle.Ca(P,Q)

using Plots
plot(P)



ForceBundle.xs(P)

edges = ForceBundle.read_edges_csv("..\\toycase.csv")


bundled_edges = forcebundle(edges);

#ForceBundle.bundling_iteration!(edges, 0.1, 0.5)
ForceBundle.bundling_iteration(edges, 0.1, 0.5)
edges 
a_plot = plot(title = "edges")
plot!.(edges)
display(a_plot)

a_plot = plot(title = "bundled edges")
plot!.(edges)
display(a_plot)

ForceBundle.xs(bundled_edges[1])
ForceBundle.ys(bundled_edges[1])

begin
    a_plot = plot(title = "Title")
    plot_in_a_plot.(edges)
    display(a_plot)
end

anim = @gif for i ∈ 1:20
    a_plot = plot(title = "Title")
    plot!.(edges, alpha = 0.8)
    edges = ForceBundle.update_divisions.(edges, i+1)
    #ForceBundle.bundling_iteration!(edges, 0.1, 0.5)
end

gif(anim, "toy_sub2.gif", fps = 15)




