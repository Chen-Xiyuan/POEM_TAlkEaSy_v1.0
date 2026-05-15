
module API_TAlkEaSy

import POEMCore

const Forcings = POEMCore.Forcings
const Register = POEMCore.Register
const Solver = POEMCore.Solver
const Inputs = POEMCore.Inputs
const Results = POEMCore.Results

include("Parameters_TAlkEaSy.jl")
include("Forcing_TAlkEaSy.jl")
include("Equations_TAlkEaSy.jl")
include("Initialize_TAlkEaSy.jl")

using .Parameters
using .Forcing
import .Equations: ModelContext, TAlkEaSy_DAE!, register_variable, output_variables, DAE_algebraic_constraint
using .Initialize

export
    # parameters
    Pars, default_parameters, default_initial_state,

    # forcings
    ForcingSeries, ForcingsBundle,
    load_forcings, forcing_value,
    sample_uniform_between_min_max,
    replace_forcings,
    forcing_names, has_forcing,
    required_forcing_names, _forcing_files, forcing_directory,

    # equations / context
    ModelContext,

    # equations
    TAlkEaSy_DAE!,
    register_variable, output_variables, DAE_algebraic_constraint,

    # solver baseline
    ODE_solver, DAE_solver,

    # solver platform
    SolverConfig,
    build_ode_problem, build_dae_problem,
    build_mass_matrix_problem,
    solve_ode_problem, solve_dae_problem, solve_mass_matrix_problem,
    mass_matrix_from_differential_vars,
    sparse_mass_matrix_from_differential_vars,

    # model inputs
    TAlkEaSyRunInputs,
    ModelInputs,
    build_model_inputs,
    build_TAlkEaSy_inputs,
    differential_vars_from_algebraic_vars,
    differential_vars_from_algebraic_indices,
    initial_derivative_guess_from_residual,

    # results
    diagnostics_dataframe,
    RunResult,
    make_run_result,
    solution_successful, solution_statistics


const ForcingSeries = POEMCore.ForcingSeries
const ForcingsBundle = POEMCore.ForcingsBundle
const load_forcings = POEMCore.load_forcings
const forcing_value = POEMCore.forcing_value
const sample_uniform_between_min_max = POEMCore.sample_uniform_between_min_max
const replace_forcings = POEMCore.replace_forcings
const forcing_names = POEMCore.forcing_names
const has_forcing = POEMCore.has_forcing

const ODE_solver = POEMCore.ODE_solver
const DAE_solver = POEMCore.DAE_solver
const SolverConfig = POEMCore.SolverConfig
const build_ode_problem = POEMCore.build_ode_problem
const build_dae_problem = POEMCore.build_dae_problem
const build_mass_matrix_problem = POEMCore.build_mass_matrix_problem
const solve_ode_problem = POEMCore.solve_ode_problem
const solve_dae_problem = POEMCore.solve_dae_problem
const solve_mass_matrix_problem = POEMCore.solve_mass_matrix_problem
const mass_matrix_from_differential_vars = POEMCore.mass_matrix_from_differential_vars
const sparse_mass_matrix_from_differential_vars = POEMCore.sparse_mass_matrix_from_differential_vars

const ModelInputs = POEMCore.ModelInputs
const build_model_inputs = POEMCore.build_model_inputs
const differential_vars_from_algebraic_vars = POEMCore.differential_vars_from_algebraic_vars
const differential_vars_from_algebraic_indices = POEMCore.differential_vars_from_algebraic_indices
const initial_derivative_guess_from_residual = POEMCore.initial_derivative_guess_from_residual

const diagnostics_dataframe = POEMCore.diagnostics_dataframe
const RunResult = POEMCore.RunResult
const make_run_result = POEMCore.make_run_result
const solution_successful = POEMCore.solution_successful
const solution_statistics = POEMCore.solution_statistics

end # module API_TAlkEaSy
