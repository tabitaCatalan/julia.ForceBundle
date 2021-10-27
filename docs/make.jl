using ForceBundle, Documenter 
using Literate 

# Process airlines.jl example. Path Processing idea from 
# https://github.com/fredrikekre/Literate.jl/blob/master/docs/make.jl
EXAMPLE = joinpath(@__DIR__, "..", "example", "airlines.jl")
OUTPUT = joinpath(@__DIR__, "src", "examples")
Literate.markdown(EXAMPLE, OUTPUT)

makedocs(modules=[ForceBundle],
         doctest=false, clean=true,
         #format = Documenter.HTML(canonical="https://tabitaCatalan/kalman/stable"),
         format = Documenter.HTML(prettyurls=true),
         sitename="ForceBundle.jl",
         authors="Tabita Catalán",
         pages = Any[
         "ForceBundle.jl" => "index.md",
         "Examples" => Any["examples/airlines.md"],
         #"Compatibility Measures" => "compatibility_measures.md",
        "Inners" => Any["compatibility_measures_inners.md"]
         ]) 

deploydocs(
            repo = "github.com/tabitaCatalan/julia.ForceBundle.git",
        )
