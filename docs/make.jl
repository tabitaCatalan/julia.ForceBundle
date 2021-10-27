using ForceBundle, Documenter 
using Literate 

# Process airlines.jl example 
Literate.markdown("..\\example\\airlines.jl", outputdir="src\\examples\\")

makedocs(modules=[ForceBundle],
         doctest=false, clean=true,
         #format = Documenter.HTML(canonical="https://tabitaCatalan/kalman/stable"),
         format = Documenter.HTML(prettyurls=true),
         sitename="ForceBundle.jl",
         authors="Tabita Catalán",
         pages = Any[
         "ForceBundle.jl" => "index.md",
         "Examples" => Any["airlines.md"],
         #"Compatibility Measures" => "compatibility_measures.md",
        "Inners" => Any["compatibility_measures_inners.md"]
         ]) 

deploydocs(
            repo = "github.com/tabitaCatalan/julia.ForceBundle.git",
        )
