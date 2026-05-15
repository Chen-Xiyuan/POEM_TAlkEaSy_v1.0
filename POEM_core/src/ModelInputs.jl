
# =============================================================================
# ModelInputs.jl
# =============================================================================


module Inputs

export ModelInputs, CoreRunInputs
export build_model_inputs, build_run_inputs, build_run_inputs_from_functions
export differential_vars_from_algebraic_vars, differential_vars_from_algebraic_indices
export initial_derivative_guess_from_residual


struct ModelInputs

    parameters::Any

    forcings::Any

    context::Any

    initial_state::Vector{Float64}

    initial_derivative_guess::Vector{Float64}

    differential_vars::Vector{Bool}

    time_span::Tuple{Float64,Float64}

    forcing_dir::String

    forcing_files::Dict{Symbol,String}

end


const CoreRunInputs = ModelInputs


function differential_vars_from_algebraic_vars(n_state::Integer, algebraic_vars::AbstractVector{<:Integer})

    differential_vars = trues(Int(n_state))

    for index in algebraic_vars

        differential_vars[Int(index)] = false

    end

    return collect(differential_vars)

end


const differential_vars_from_algebraic_indices = differential_vars_from_algebraic_vars


function initial_derivative_guess_from_residual(
    residual_function,
    initial_state::AbstractVector{<:Real},
    context,
    t::Real,
    differential_vars::AbstractVector{Bool},
)

    state0 = Float64.(initial_state)

    if length(differential_vars) != length(state0)

        error("differential_vars length does not match initial_state length.")

    end

    derivative_guess = zeros(Float64, length(state0))
    residual = zeros(Float64, length(state0))

    residual_function(residual, derivative_guess, state0, context, Float64(t))

    for i in eachindex(state0)

        if differential_vars[i]

            derivative_guess[i] = -residual[i]

        else

            derivative_guess[i] = 0.0

        end

    end

    return derivative_guess

end


function _initial_derivative_vector(
    initial_state::Vector{Float64},
    differential_vars::Vector{Bool},
    t::Real,
    context,
    initial_derivative_guess,
    dae_residual,
)

    if initial_derivative_guess !== nothing

        derivative_guess = Float64.(initial_derivative_guess)

        if length(derivative_guess) != length(initial_state)

            error("initial_derivative_guess length does not match initial_state length.")

        end

        return derivative_guess

    end

    if dae_residual !== nothing

        return initial_derivative_guess_from_residual(
            dae_residual,
            initial_state,
            context,
            t,
            differential_vars,
        )

    end

    return zeros(Float64, length(initial_state))

end


function build_model_inputs(;
    parameters,
    forcings,
    context,
    initial_state::AbstractVector{<:Real},
    whenstart::Real,
    whenend::Real,
    algebraic_vars::AbstractVector{<:Integer},
    initial_derivative_guess = nothing,
    dae_residual = nothing,
    forcing_dir::AbstractString = "",
    forcing_files::Dict{Symbol,String} = Dict{Symbol,String}(),
)

    state0 = Float64.(initial_state)

    time_span = (Float64(whenstart), Float64(whenend))

    differential_vars = differential_vars_from_algebraic_vars(length(state0), algebraic_vars)

    derivative_guess = _initial_derivative_vector(
        state0,
        differential_vars,
        time_span[1],
        context,
        initial_derivative_guess,
        dae_residual,
    )

    return ModelInputs(
        parameters,
        forcings,
        context,
        state0,
        derivative_guess,
        differential_vars,
        time_span,
        String(forcing_dir),
        forcing_files,
    )

end


function build_run_inputs(; kwargs...)

    return build_model_inputs(; kwargs...)

end


function build_run_inputs_from_functions(;
    make_parameters,
    make_initial_state,
    make_context,
    load_forcings_func,
    forcing_dir::AbstractString,
    forcing_files::Dict{Symbol,String},
    whenstart::Real,
    whenend::Real,
    algebraic_vars::AbstractVector{<:Integer},
    initial_derivative_guess = nothing,
    dae_residual = nothing,
    verbose::Bool = true,
)

    parameters = make_parameters()

    forcings = load_forcings_func(String(forcing_dir), forcing_files; verbose = verbose)

    context = make_context(parameters, forcings)

    initial_state = make_initial_state(parameters)

    return build_model_inputs(
        parameters = parameters,
        forcings = forcings,
        context = context,
        initial_state = initial_state,
        whenstart = whenstart,
        whenend = whenend,
        algebraic_vars = algebraic_vars,
        initial_derivative_guess = initial_derivative_guess,
        dae_residual = dae_residual,
        forcing_dir = forcing_dir,
        forcing_files = forcing_files,
    )

end

end # module Inputs
