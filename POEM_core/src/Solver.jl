
# =============================================================================
# Solver.jl
# =============================================================================


module Solver

using SciMLBase: ODEProblem, DAEProblem, ODEFunction, solve
using SparseArrays
using Sundials

export SolverConfig
export ODE_solver, DAE_solver
export build_ode_problem, build_dae_problem, build_mass_matrix_problem
export solve_ode_problem, solve_dae_problem, solve_mass_matrix_problem
export mass_matrix_from_differential_vars, sparse_mass_matrix_from_differential_vars


struct SolverConfig

    problem_type::Symbol

    algorithm::Symbol

    linear_solver::Symbol

    reltol::Union{Nothing,Float64}

    abstol::Union{Nothing,Float64}

    saveat::Any

    dtmax::Any

    maxiters::Union{Nothing,Int}

end


function SolverConfig(;
    problem_type::Symbol = :dae,
    algorithm::Symbol = :ida_lapackdense,
    linear_solver::Symbol = :LapackDense,
    reltol = nothing,
    abstol = nothing,
    saveat = nothing,
    dtmax = nothing,
    maxiters = nothing,
)

    reltol_value = reltol === nothing ? nothing : Float64(reltol)
    abstol_value = abstol === nothing ? nothing : Float64(abstol)
    maxiters_value = maxiters === nothing ? nothing : Int(maxiters)

    return SolverConfig(
        problem_type,
        algorithm,
        linear_solver,
        reltol_value,
        abstol_value,
        saveat,
        dtmax,
        maxiters_value,
    )

end


function _default_solver(config::SolverConfig)

    if config.algorithm == :ida_dense

        return Sundials.IDA(linear_solver = :Dense)

    elseif config.algorithm == :ida_lapackdense

        return Sundials.IDA(linear_solver = :LapackDense)

    elseif config.algorithm == :ida_gmres

        return Sundials.IDA(linear_solver = :GMRES)

    elseif config.algorithm == :cvode_bdf

        return Sundials.CVODE_BDF(linear_solver = config.linear_solver)

    elseif config.algorithm == :massmatrix_rodas5

        error("The :massmatrix_rodas5 solver is not loaded in the minimal POEMCore dependency set. First confirm that import POEMCore and import API_TAlkEaSy work. Later, add an OrdinaryDiffEq mass-matrix solver explicitly and pass it with solver = ... .")

    elseif config.algorithm == :massmatrix_fbdf

        error("The :massmatrix_fbdf solver is not loaded in the minimal POEMCore dependency set. First confirm that import POEMCore and import API_TAlkEaSy work. Later, add an OrdinaryDiffEq mass-matrix solver explicitly and pass it with solver = ... .")

    elseif config.algorithm == :custom

        error("No default solver is defined for algorithm = :custom. Pass a solver explicitly with solver = ... .")

    else

        error("Unknown solver algorithm: $(config.algorithm)")

    end

end


function _solve_kwargs(config::SolverConfig)

    kwargs = Dict{Symbol,Any}()

    if config.reltol !== nothing
        kwargs[:reltol] = config.reltol
    end

    if config.abstol !== nothing
        kwargs[:abstol] = config.abstol
    end

    if config.maxiters !== nothing
        kwargs[:maxiters] = config.maxiters
    end

    if config.saveat !== nothing
        kwargs[:saveat] = config.saveat
    end

    if config.dtmax !== nothing
        kwargs[:dtmax] = config.dtmax
    end

    return kwargs

end


function _merge_kwargs(base::Dict{Symbol,Any}, extra)

    for (k, v) in pairs(extra)

        base[k] = v

    end

    return base

end


function build_ode_problem(f!, u0, tspan, p)

    return ODEProblem(f!, u0, tspan, p)

end


function build_dae_problem(residual!, du0, u0, tspan, p; differential_vars)

    return DAEProblem(residual!, du0, u0, tspan, p; differential_vars = differential_vars)

end


function build_mass_matrix_problem(f!, u0, tspan, p, mass_matrix)

    ode_function = ODEFunction(f!; mass_matrix = mass_matrix)

    return ODEProblem(ode_function, u0, tspan, p)

end


function mass_matrix_from_differential_vars(differential_vars::AbstractVector{Bool})

    n = length(differential_vars)

    mass_matrix = zeros(Float64, n, n)

    for i in 1:n

        if differential_vars[i]

            mass_matrix[i, i] = 1.0

        end

    end

    return mass_matrix

end


function sparse_mass_matrix_from_differential_vars(differential_vars::AbstractVector{Bool})

    n = length(differential_vars)

    mass_matrix = spzeros(Float64, n, n)

    for i in 1:n

        if differential_vars[i]

            mass_matrix[i, i] = 1.0

        end

    end

    return mass_matrix

end


function solve_ode_problem(
    f!,
    u0,
    tspan,
    p;
    config::SolverConfig = SolverConfig(problem_type = :ode, algorithm = :cvode_bdf),
    solver = nothing,
    solve_kwargs...,
)

    prob = build_ode_problem(f!, u0, tspan, p)

    alg = solver === nothing ? _default_solver(config) : solver

    kwargs = _merge_kwargs(_solve_kwargs(config), solve_kwargs)

    return solve(prob, alg; kwargs...)

end


function solve_dae_problem(
    residual!,
    du0,
    u0,
    tspan,
    p;
    differential_vars,
    config::SolverConfig = SolverConfig(problem_type = :dae, algorithm = :ida_lapackdense),
    solver = nothing,
    solve_kwargs...,
)

    prob = build_dae_problem(residual!, du0, u0, tspan, p; differential_vars = differential_vars)

    alg = solver === nothing ? _default_solver(config) : solver

    kwargs = _merge_kwargs(_solve_kwargs(config), solve_kwargs)

    return solve(prob, alg; kwargs...)

end


function solve_mass_matrix_problem(
    f!,
    u0,
    tspan,
    p,
    mass_matrix;
    config::SolverConfig = SolverConfig(problem_type = :massmatrix, algorithm = :custom),
    solver = nothing,
    solve_kwargs...,
)

    prob = build_mass_matrix_problem(f!, u0, tspan, p, mass_matrix)

    if solver === nothing

        alg = _default_solver(config)

    else

        alg = solver

    end

    kwargs = _merge_kwargs(_solve_kwargs(config), solve_kwargs)

    return solve(prob, alg; kwargs...)

end


function ODE_solver(
    f!,
    u0,
    tspan,
    p;
    solver,
    saveat = nothing,
    dtmax = nothing,
    reltol = nothing,
    abstol = nothing,
    maxiters = nothing,
    solve_kwargs...,
)

    config = SolverConfig(
        problem_type = :ode,
        algorithm = :custom,
        reltol = reltol,
        abstol = abstol,
        saveat = saveat,
        dtmax = dtmax,
        maxiters = maxiters,
    )

    return solve_ode_problem(
        f!,
        u0,
        tspan,
        p;
        config = config,
        solver = solver,
        solve_kwargs...,
    )

end


function DAE_solver(
    residual!,
    du0,
    u0,
    tspan,
    p;
    solver,
    differential_vars,
    saveat = nothing,
    dtmax = nothing,
    reltol = nothing,
    abstol = nothing,
    maxiters = nothing,
    solve_kwargs...,
)

    config = SolverConfig(
        problem_type = :dae,
        algorithm = :custom,
        reltol = reltol,
        abstol = abstol,
        saveat = saveat,
        dtmax = dtmax,
        maxiters = maxiters,
    )

    return solve_dae_problem(
        residual!,
        du0,
        u0,
        tspan,
        p;
        differential_vars = differential_vars,
        config = config,
        solver = solver,
        solve_kwargs...,
    )

end



end # module Solver
