var documenterSearchIndex = {"docs":
[{"location":"compatibility_measures_inners/#Compatibility-measures","page":"Compatibility measures","title":"Compatibility measures","text":"","category":"section"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"Definitions and explanations on the defined compatibility measures can be found in (INSERT REF). Here are the details of the implementation.","category":"page"},{"location":"compatibility_measures_inners/#Angle-compatibility","page":"Compatibility measures","title":"Angle compatibility","text":"","category":"section"},{"location":"compatibility_measures_inners/#Visibility-compatibility","page":"Compatibility measures","title":"Visibility compatibility","text":"","category":"section"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"Further discussion on this can be found in this Issue in python.ForceBundle ","category":"page"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"<!–(TODO: INSERTAR DIAGRAMA) –>","category":"page"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"The intersection between the visibility band of the Edge Q and the straight line given by the edge P is calculated with proyectedEdge. It calculates the direction perpendicular to Q using perpendicular_slope. After that, it calculates the intersection_point between the straight line defined by P and the lines that pass over source(Q) and target(Q) in that perpendicular direction.","category":"page"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"ForceBundle.intersection_point","category":"page"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"ForceBundle.perpendicular_slope","category":"page"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"ForceBundle.proyectedEdge","category":"page"},{"location":"compatibility_measures_inners/","page":"Compatibility measures","title":"Compatibility measures","text":"","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"EditURL = \"https://github.com/tabitaCatalan/julia.ForceBundle/blob/master/example/airlines.jl\"","category":"page"},{"location":"examples/airlines/#USA-Airlines","page":"USA Airlines","title":"USA Airlines","text":"","category":"section"},{"location":"examples/airlines/#Import-library","page":"USA Airlines","title":"Import library","text":"","category":"section"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"using ForceBundle","category":"page"},{"location":"examples/airlines/#Read-data-from-csv","page":"USA Airlines","title":"Read data from csv","text":"","category":"section"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"Data can be read from a .csv file using read_edges_csv function. This uses CSV.jl library.","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"-922.24444,-347.29444,-932.16944,-448.83333\n-922.24444,-347.29444,-741.68611,-406.925\n...","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"DATA = joinpath(@__DIR__, \"data\", \"airlines.jl\")\nedges = read_edges_csv(DATA; subdivisions = 1);\nnothing #hide","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"We select the first 100 edges","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"edges = edges[1:100];\nnothing #hide","category":"page"},{"location":"examples/airlines/#Bundle-the-edges","page":"USA Airlines","title":"Bundle the edges","text":"","category":"section"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"We use the forcebundle function","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"bundled_edges = forcebundle(edges, P_initial = 2);\nnothing #hide","category":"page"},{"location":"examples/airlines/#Plot-results","page":"USA Airlines","title":"Plot results","text":"","category":"section"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"using Plots: plot, plot!","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"A recipe is defined for Edges, so we can use plot(::Edge) or plot!(::Edge). We plot straight edges","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"a_plot = plot(title = \"straight edges\")\nplot!.(edges, color = :red)\ndisplay(a_plot)","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"and bundled edges.","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"b_plot = plot(title = \"bundled edges\")\nplot!.(bundled_edges, color = :red)\ndisplay(b_plot)","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"","category":"page"},{"location":"examples/airlines/","page":"USA Airlines","title":"USA Airlines","text":"This page was generated using Literate.jl.","category":"page"},{"location":"compatibility_measures/#Compatibility-Measures","page":"Compatibility Measures","title":"Compatibility Measures","text":"","category":"section"},{"location":"compatibility_measures/","page":"Compatibility Measures","title":"Compatibility Measures","text":"All compatibility measures defined by paper are available. ","category":"page"},{"location":"compatibility_measures/#Angle-Compatibility","page":"Compatibility Measures","title":"Angle Compatibility","text":"","category":"section"},{"location":"compatibility_measures/","page":"Compatibility Measures","title":"Compatibility Measures","text":"ForceBundle.Ca ","category":"page"},{"location":"#Force-Directed-Edge-Bundling","page":"ForceBundle.jl","title":"Force Directed Edge Bundling","text":"","category":"section"},{"location":"","page":"ForceBundle.jl","title":"ForceBundle.jl","text":"TODO description of FDEB","category":"page"},{"location":"","page":"ForceBundle.jl","title":"ForceBundle.jl","text":"The principal function is forcebundle:","category":"page"},{"location":"","page":"ForceBundle.jl","title":"ForceBundle.jl","text":"forcebundle","category":"page"},{"location":"#ForceBundle.forcebundle","page":"ForceBundle.jl","title":"ForceBundle.forcebundle","text":"forcebundle\n\nUse Force Directed Edge Bundling to modify a list of Edges. \n\nArguments\n\nedges: array of Edges.\n\nOptional arguments\n\nC = 6: number of cycles of bundling to perform.\nK = 1: global bundling constant controlling edge stiffness.\nS_initial = median(bundled_length.(edges)): initial distance to move points.\nS_rate = 0.5: distance rate decreases (0 < S_rate < 1).\nP_initial = 1: initial subdivision number.\nP_rate = 2: subdivision rate increase (1 < P_rate).\nI_initial = 70: initial number of iterations per cycle.\nI_rate = 2/3: rate at which iteration number decreases (0 < I_rate < 1). \n\nFuture arguments (work in progress)\n\ncompatibility_threshold: two edges P and Q only interact when ForceBundle.compatibility(P,Q) > compatibility_threshold.    Must be a number in (0,1).\n\n\n\n\n\n","category":"function"},{"location":"#Utilities","page":"ForceBundle.jl","title":"Utilities","text":"","category":"section"},{"location":"#Read-data","page":"ForceBundle.jl","title":"Read data","text":"","category":"section"},{"location":"","page":"ForceBundle.jl","title":"ForceBundle.jl","text":"ForceBundle.read_edges_csv","category":"page"},{"location":"#ForceBundle.read_edges_csv","page":"ForceBundle.jl","title":"ForceBundle.read_edges_csv","text":"read_edges_csv(csv_filename; subdivisions = 1)\n\nRead a csv file and returns an array of Edges.\n\nArguments\n\ncsv_filename::String: path to csv file. Data must be organized in 4 columns:\n\n|source.x, source.y, target.x, target.y| –-|–-|–-|–- \n\nsubdivisions = 1: (optional) number of inner subdivisions of each Edge. By default, \n\nan single subdivision is added.\n\nExample\n\nIf a edges.csv in directory contains the following info \n\n-1.0, 0.0, 0.0, 1.0\n0.0, -1.0, 1.0, 0.0 \n\nthen read_edges_csv returns a list of two Edges:\n\njulia> edges = ForceBundle.read_edges_csv(\"edges.csv\")\n2-element Array{Edge{Float64,StructArrays.StructArray{Point{Float64},1,NamedTuple{(:x, :y),Tuple{Array{Float64,1},Array{Float64,1}}},Int64}},1}:    \n Edge{Float64,StructArrays.StructArray{Point{Float64},1,NamedTuple{(:x, :y),Tuple{Array{Float64,1},Array{Float64,1}}},Int64}}(Point{Float64}[[-1.0, 0.0], [-0.5, 0.5], [0.0, 1.0]])\n Edge{Float64,StructArrays.StructArray{Point{Float64},1,NamedTuple{(:x, :y),Tuple{Array{Float64,1},Array{Float64,1}}},Int64}}(Point{Float64}[[0.0, -1.0], [0.5, -0.5], [1.0, 0.0]])\n\n\n\n\n\n","category":"function"},{"location":"#Plotting","page":"ForceBundle.jl","title":"Plotting","text":"","category":"section"},{"location":"","page":"ForceBundle.jl","title":"ForceBundle.jl","text":"There is a recipe for plotting Edges. Using plot function from Plots.jl is possible by a Recipe. See RecipesBase for more details, or for using other plotting packages.","category":"page"}]
}
