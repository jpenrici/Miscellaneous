# main.jl

# Use local environment
using Pkg
Pkg.activate(".")
Pkg.instantiate()

# Local module
include("src/module.jl")
using .Module1      # imports everything from the export directly into the namespace
# import .Module1   # requires the prefix Mod.Function, Mod.Structure, etc. — more explicit and safer


function main()

    @info "Starting..."

    obj = OBJ(10)

    @info "Finished."
    
end


if abspath(PROGRAM_FILE) == @__FILE__
    main()
end

# Run - Optional
# julia --project=. main.jl
