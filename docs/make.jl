using ForceBundle, Documenter 


makedocs(modules=[ForceBundle],
         doctest=false, clean=true,
         #format = Documenter.HTML(canonical="https://tabitaCatalan/kalman/stable"),
         format = Documenter.HTML(prettyurls=false),
         sitename="ForceBundle.jl",
         authors="Tabita Catalán",
         pages = Any[
         "ForceBundle.jl" => "index.md",
         "Compatibility Measures" => "compatibility_measures.md" #=,
         "Examples" => Any["example/example1.md", 
                            "example/example2.md"] =#
         ]) 

deploydocs(
            repo = "github.com/tabitaCatalan/julia.ForceBundle.git",
        )
