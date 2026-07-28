# module.jl

module Module1

    export OBJ

    struct OBJ
        number::Int

        # Constructor
        function OBJ(number)
            println("Number: $number")
        end
    end # OBJ

end # Module1
