# main.jl

# include("modulo.jl") # loads the contents of a file and executes it within the context where it was called.

# using .Modulo # imports everything from the export directly into the namespace
# import .Mod   # requires the prefix Mod.Function, Mod.Structure, etc. — more explicit and safer


function main()

    @info "Starting..."

    # Code
    # @info, @warm, @error - Logging Macros
    # error("mensagem") - Function that halts execution

    @info "Finished."
    
end

if abspath(PROGRAM_FILE) == @__FILE__
    main()
end
