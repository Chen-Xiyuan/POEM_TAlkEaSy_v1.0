
# =============================================================================
# src/Forcings.jl
# =============================================================================

module Forcings

using XLSX
using DataFrames
using Random
using Logging

export ForcingSeries, ForcingsBundle
export load_forcings, load_forcing_series, forcing_value
export sample_uniform_between_min_max
export replace_forcings
export forcing_names, has_forcing

# -----------------------------------------------------------------------------
# linear interpolation
# -----------------------------------------------------------------------------

function _interp1_linear(x::AbstractVector{<:Real}, y::AbstractVector{<:Real}, xi::Real)

    x1 = float(first(x))
    xN = float(last(x))
    xif = float(xi)

    if isnan(xif) || xif < x1 || xif > xN

        return NaN

    end

    i = searchsortedlast(x, xi)

    if i >= length(x)

        return float(last(y))

    end

    xa = float(x[i])
    xb = float(x[i + 1])
    ya = float(y[i])
    yb = float(y[i + 1])

    if xb == xa

        return ya

    end

    t = (xif - xa) / (xb - xa)

    return ya + t * (yb - ya)

end

# -----------------------------------------------------------------------------
# forcing data structure
# -----------------------------------------------------------------------------

"""

ForcingSeries

"""
struct ForcingSeries

    t::Vector{Float64}

    v::Vector{Float64}

    v_min::Vector{Float64}

    v_max::Vector{Float64}

    name::Symbol

end

"""

ForcingsBundle

"""
mutable struct ForcingsBundle

    series::Dict{Symbol,ForcingSeries}

end

function ForcingsBundle(; kwargs...)

    series = Dict{Symbol,ForcingSeries}()

    for (name, forcing) in kwargs

        if !(forcing isa ForcingSeries)

            error("ForcingsBundle keyword values must be ForcingSeries. Bad key: $(name)")

        end

        series[Symbol(name)] = forcing

    end

    return ForcingsBundle(series)

end

function Base.getproperty(bundle::ForcingsBundle, name::Symbol)

    if name === :series

        return getfield(bundle, :series)

    end

    all_series = getfield(bundle, :series)

    if haskey(all_series, name)

        return all_series[name]

    end

    error("ForcingsBundle has no forcing named :$(name). Available forcings: $(collect(keys(all_series)))")

end

function Base.setproperty!(bundle::ForcingsBundle, name::Symbol, value)

    if name === :series

        setfield!(bundle, :series, value)

        return value

    end

    if !(value isa ForcingSeries)

        error("Only ForcingSeries can be assigned into ForcingsBundle. Bad key: :$(name)")

    end

    getfield(bundle, :series)[name] = value

    return value

end

function Base.propertynames(bundle::ForcingsBundle, private::Bool = false)

    names = collect(keys(getfield(bundle, :series)))

    if private

        push!(names, :series)

    end

    return Tuple(names)

end

function forcing_names(bundle::ForcingsBundle)

    return sort!(collect(keys(bundle.series)); by = string)

end

function has_forcing(bundle::ForcingsBundle, name::Symbol)

    return haskey(bundle.series, name)

end

# -----------------------------------------------------------------------------
# xlsx reading（.xlsx could only be read as 'time_yr', 'mean', 'min', 'max'）
# -----------------------------------------------------------------------------

function _find_column_index(df::DataFrame, target::AbstractString)

    target_lower = lowercase(String(target))

    for (i, nm) in enumerate(names(df))

        if lowercase(String(nm)) == target_lower

            return i

        end

    end

    return nothing

end

function _read_forcing_xlsx(path::AbstractString; sheet::Union{Int,String} = 1)

    excel_file = XLSX.readxlsx(path)

    worksheet = if sheet isa Int

        excel_file[sheet]

    else

        try

            excel_file[sheet]

        catch

            @warn "Forcing xlsx sheet not found; falling back to first sheet" file=String(path) requested_sheet=String(sheet)

            excel_file[1]

        end

    end

    table_data = XLSX.gettable(worksheet; infer_eltypes = true)

    df = DataFrame(table_data)

    itime = _find_column_index(df, "time_yr")
    imean = _find_column_index(df, "mean")
    imin  = _find_column_index(df, "min")
    imax  = _find_column_index(df, "max")

    if itime === nothing || imean === nothing || imin === nothing || imax === nothing

        error("Forcing file must contain columns: time_yr, mean, min, max. File: $(path)")

    end

    t = Float64.(df[!, itime])
    v_mean = Float64.(df[!, imean])
    v_min  = Float64.(df[!, imin])
    v_max  = Float64.(df[!, imax])

    order = sortperm(t)

    return t[order], v_mean[order], v_min[order], v_max[order]

end

function load_forcing_series(
    forcing_dir::AbstractString,
    filename::AbstractString;
    name::Symbol,
    verbose::Bool = false,
)

    path = if isabspath(filename)

        filename

    else

        joinpath(forcing_dir, filename)

    end

    if !isfile(path)

        error("Forcing file not found: $(path)")

    end

    t, v, vmin, vmax = _read_forcing_xlsx(path)

    if verbose

        @info "POEM: forcing loaded" name=String(name) file=path n=length(t) tmin=minimum(t) tmax=maximum(t)

    end

    return ForcingSeries(t, v, vmin, vmax, name)

end

# -----------------------------------------------------------------------------
# forcing loading
# -----------------------------------------------------------------------------

"""

linear interpolation for non-Monte Carlo single run, use mean as the value

"""
forcing_value(series::ForcingSeries, t::Real) = _interp1_linear(series.t, series.v, t)

"""

using Monte Carlo run, random choose between min and max.

"""
function sample_uniform_between_min_max(series::ForcingSeries, rng::AbstractRNG)

    t = series.t
    vmin = series.v_min
    vmax = series.v_max

    sampled = Vector{Float64}(undef, length(t))

    for i in eachindex(t)

        a = float(vmin[i])
        b = float(vmax[i])

        if isnan(a) || isnan(b)

            error("Forcing $(series.name) has NaN in min/max at index $(i); cannot sample.")

        end

        lo = min(a, b)
        hi = max(a, b)

        sampled[i] = lo + rand(rng) * (hi - lo)

    end

    return ForcingSeries(copy(t), sampled, copy(series.v_min), copy(series.v_max), series.name)

end

"""

replace forcing

"""
function replace_forcings(base::ForcingsBundle, replacements::Dict{Symbol,ForcingSeries})

    new_series = copy(base.series)

    for (name, forcing) in replacements

        new_series[name] = forcing

    end

    return ForcingsBundle(new_series)

end

"""

loading forcings

"""
function load_forcings(
    forcing_dir::AbstractString,
    forcing_files::Dict{Symbol,String};
    required_names = nothing,
    verbose::Bool = false,
)

    if required_names !== nothing

        for name in required_names

            if !haskey(forcing_files, Symbol(name))

                error("Missing required forcing file mapping for :$(Symbol(name))")

            end

        end

    end

    all_series = Dict{Symbol,ForcingSeries}()

    for name in sort!(collect(keys(forcing_files)); by = string)

        all_series[name] = load_forcing_series(
            forcing_dir,
            forcing_files[name];
            name = name,
            verbose = verbose,
        )

    end

    return ForcingsBundle(all_series)

end

end # module Forcings
