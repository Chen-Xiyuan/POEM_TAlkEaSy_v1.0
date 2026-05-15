# =============================================================================
# Register.jl
# =============================================================================

module Register

export make_registered_variables, materialize, @registered_namedtuple


function make_registered_variables(names::AbstractVector)

    normalized_names = Symbol[]

    for name in names
        name isa Symbol || error("Registered variable must be Symbol.")
        push!(normalized_names, name)
    end

    return Tuple(normalized_names)

end


function materialize(source::NamedTuple, registry::Tuple)

    pairs = Pair{Symbol,Any}[]

    for name in registry
        hasproperty(source, name) || error("Registered output $(name) was not found.")
        push!(pairs, name => getproperty(source, name))
    end

    return (; pairs...)

end


function materialize(registry::Tuple, source::NamedTuple)

    return materialize(source, registry)

end


macro registered_namedtuple(registry_expr)

    registry = Core.eval(__module__, registry_expr)

    values_expr = Expr(:tuple, map(esc, registry)...)
    names_expr = Expr(:tuple, map(QuoteNode, registry)...)

    return :(NamedTuple{$names_expr}($values_expr))

end

end # module Register
