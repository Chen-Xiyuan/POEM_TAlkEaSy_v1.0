
# =============================================================================
# POEMCore.jl
# =============================================================================


module POEMCore

include("Register.jl")
include("Forcings.jl")
include("Solver.jl")
include("ModelInputs.jl")
include("Results.jl")

using .Register
using .Forcings
using .Solver
using .Inputs
using .Results

export

    # Register
    make_registered_variables, materialize, @registered_namedtuple,

    # Forcings
    ForcingSeries, ForcingsBundle,
    load_forcings, load_forcing_series, forcing_value,
    sample_uniform_between_min_max,
    replace_forcings, forcing_names, has_forcing,

    # Solver
    SolverConfig,
    ODE_solver, DAE_solver,
    build_ode_problem, build_dae_problem,
    build_mass_matrix_problem,
    solve_ode_problem, solve_dae_problem, solve_mass_matrix_problem,
    mass_matrix_from_differential_vars,
    sparse_mass_matrix_from_differential_vars,

    # Model inputs
    ModelInputs, CoreRunInputs,
    build_model_inputs,
    build_run_inputs,
    build_run_inputs_from_functions,
    differential_vars_from_algebraic_vars,
    differential_vars_from_algebraic_indices,
    initial_derivative_guess_from_residual,

    # Results
    diagnostics_dataframe,
    RunResult,
    make_run_result,
    solution_successful,
    solution_statistics

end # module POEMCore
