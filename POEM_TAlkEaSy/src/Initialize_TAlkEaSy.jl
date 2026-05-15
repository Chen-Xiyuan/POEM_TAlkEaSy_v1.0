
module Initialize

import POEMCore

import ..Parameters: default_parameters, default_initial_state, Pars
import ..Forcings: load_forcings, ForcingsBundle
import ..Forcing: required_forcing_names
import ..Equations: ModelContext, TAlkEaSy_DAE!, DAE_algebraic_constraint

export TAlkEaSyRunInputs
export build_TAlkEaSy_inputs


const TAlkEaSyRunInputs = POEMCore.ModelInputs


function build_TAlkEaSy_inputs(;
    forcing_dir::AbstractString,
    forcing_files::Dict{Symbol,String},
    whenstart::Real,
    whenend::Real,
    verbose::Bool = true,
)

    parameters = default_parameters()

    forcings = load_forcings(
        String(forcing_dir),
        forcing_files;
        required_names = required_forcing_names(),
        verbose = verbose,
    )

    context = ModelContext(parameters, forcings)

    initial_state = default_initial_state(parameters)

    return POEMCore.build_model_inputs(
        parameters = parameters,
        forcings = forcings,
        context = context,
        initial_state = initial_state,
        whenstart = whenstart,
        whenend = whenend,
        algebraic_vars = DAE_algebraic_constraint(),
        dae_residual = TAlkEaSy_DAE!,
        forcing_dir = forcing_dir,
        forcing_files = forcing_files,
    )

end

end # module Initialize
