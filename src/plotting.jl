#=
Add Recipes for plooting graphs 
=#

using RecipesBase

function plot_edge!(a_plot, P::Edge; alpha = 0.155, color = 1)
    plot!(a_plot, xs(ForceBundle.nodes(P)), ys(ForceBundle.nodes(P)), label = :none, color = color, alpha = alpha, markersize = 1)
end

@recipe function plot(P::Edge)
    #=@series begin
        # force an argument with `:=`
        seriestype := :path
        # ignore series in legend and color cycling
        primary := false
        linecolor := nothing
        fillcolor := :lightgray
        fillalpha := 0.5
        fillrange := r.y .- r.ε
        # ensure no markers are shown for the error band
        #markershape := :none
    end =#
    seriesalpha --> 0.155  # if alpha is unset, make it 0.155 
    # return series data 
    xs(P), ys(P)    
end