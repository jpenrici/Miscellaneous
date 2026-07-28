# dependencies.jl

using Pkg


function install_missing_packages()
    try
        counter = 0
        required = [""] # DataFrames, e.g.
        
        if isempty(required)
            @info("List of required dependencies empty!")
            return false
        end

        project_deps = Pkg.project().dependencies

        println("--- Checking Dependencies ---")
        for pkg in required
            if isempty(pkg)
                continue
            end
            if haskey(project_deps, pkg)
                @info "$pkg is already installed."
            else
                @info "Installing $pkg..."
                Pkg.add(pkg)
                counter += 1
            end
        end

        if counter == 0
            @info("No dependencies added.")
        else
            @info("$counter dependencies added")
            println("--- Precompiling ---")
            Pkg.precompile()
        end

        println("-" ^ 29)

        return true
    catch e
        @error "Failed to setup dependencies" exception=e
        return false
    end
end


if abspath(PROGRAM_FILE) == @__FILE__
    Pkg.activate("..")
    status = install_missing_packages()
    if status
        exit(0)
    else
        exit(1)
    end
end
