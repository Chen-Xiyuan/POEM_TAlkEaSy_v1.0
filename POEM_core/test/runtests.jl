using Test
import POEMCore

@testset "Register" begin

    registry = POEMCore.make_registered_variables([:a, :b])

    source = (a = 1.0, b = 2.0)

    @test POEMCore.materialize(source, registry) == (a = 1.0, b = 2.0)

end

@testset "ModelInputs" begin

    differential_vars = POEMCore.differential_vars_from_algebraic_vars(3, [2])

    @test differential_vars == [true, false, true]

    inputs = POEMCore.build_model_inputs(
        parameters = nothing,
        forcings = nothing,
        context = nothing,
        initial_state = [1.0, 2.0, 3.0],
        whenstart = 0.0,
        whenend = 1.0,
        algebraic_vars = [2],
    )

    @test inputs.initial_derivative_guess == zeros(3)
    @test inputs.differential_vars == [true, false, true]

end

@testset "Solver helpers" begin

    differential_vars = [true, false, true]

    mass_matrix = POEMCore.mass_matrix_from_differential_vars(differential_vars)

    @test size(mass_matrix) == (3, 3)
    @test mass_matrix[1, 1] == 1.0
    @test mass_matrix[2, 2] == 0.0
    @test mass_matrix[3, 3] == 1.0

end
