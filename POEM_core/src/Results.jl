
# =============================================================================
# Results.jl
# =============================================================================


module Results

using DataFrames

export diagnostics_dataframe, RunResult, make_run_result
export solution_successful, solution_statistics


function diagnostics_dataframe(solution, context, output_function)

    rows = Vector{NamedTuple}(undef, length(solution.t))

    for i in eachindex(solution.t)

        rows[i] = output_function(solution.t[i], solution.u[i], context)

    end

    return DataFrame(rows)

end


struct RunResult

    state::DataFrame

    parameters::Any

    sol

end


function make_run_result(solution, inputs, output_function)

    state = diagnostics_dataframe(solution, inputs.context, output_function)

    return RunResult(state, inputs.parameters, solution)

end


function solution_successful(solution)

    if !hasproperty(solution, :retcode)

        return false

    end

    retcode_value = solution.retcode

    if retcode_value == :Success

        return true

    end

    retcode_string = string(retcode_value)

    if retcode_string == "Success"

        return true

    end

    if retcode_string == "ReturnCode.Success"

        return true

    end

    return occursin("Success", retcode_string)

end


function solution_statistics(solution)

    retcode_value = hasproperty(solution, :retcode) ? solution.retcode : nothing

    destats_value = hasproperty(solution, :destats) ? solution.destats : nothing

    return (
        retcode = retcode_value,
        successful = solution_successful(solution),
        saved_steps = length(solution.t),
        t_start = first(solution.t),
        t_end = last(solution.t),
        destats = destats_value,
    )

end

end # module Results
