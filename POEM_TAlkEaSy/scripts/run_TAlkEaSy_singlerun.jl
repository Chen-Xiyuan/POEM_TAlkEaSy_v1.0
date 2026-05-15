# =============================================================================
# main file
# =============================================================================

import API_TAlkEaSy
using Sundials
using CSV


# -----------------------------------------------------------------------------
# time span
# -----------------------------------------------------------------------------
whenstart = -800.0e6                 ####---- CO2 pulse test
# whenstart = -1000.0e6                ####---- DEGASS pulse test

whenend   = -490.0e6                 ####---- CO2 pulse test
# whenend   = 0.0                      ####---- DEGASS pulse test

# -----------------------------------------------------------------------------
# forcings 
# -----------------------------------------------------------------------------
forcing_dir = normpath(joinpath(@__DIR__, "..", "forcings"))
forcing_files = API_TAlkEaSy._forcing_files()

# -----------------------------------------------------------------------------
# model configuration and initialization
# -----------------------------------------------------------------------------
inputs = API_TAlkEaSy.build_TAlkEaSy_inputs(
    forcing_dir   = forcing_dir,
    forcing_files = forcing_files,
    whenstart = whenstart,
    whenend   = whenend,
    verbose   = true,
)

# -----------------------------------------------------------------------------
# solver resolution
# -----------------------------------------------------------------------------
saveat = 1.0e4
dtmax  = 1.0e4
reltol = 1.0e-4
abstol = 1.0e-4

# -----------------------------------------------------------------------------
# model input into solver
# -----------------------------------------------------------------------------
solution = API_TAlkEaSy.DAE_solver(
    API_TAlkEaSy.TAlkEaSy_DAE!,
    inputs.initial_derivative_guess,
    inputs.initial_state,
    inputs.time_span,
    inputs.context;
    differential_vars = inputs.differential_vars,
    solver = Sundials.IDA(linear_solver = :LapackDense),
    saveat = saveat,
    dtmax  = dtmax,
    reltol = reltol,
    abstol = abstol,
)

@info "Solve finished" retcode=solution.retcode nsteps=length(solution.t)

TAlkEaSy_run = API_TAlkEaSy.make_run_result(solution, inputs, API_TAlkEaSy.output_variables)

# -----------------------------------------------------------------------------
# plot
# -----------------------------------------------------------------------------
include(joinpath(@__DIR__, "plot_singlerun.jl"))

singlerun_save_pdf = false    
singlerun_pdf_dir = normpath(joinpath(@__DIR__, "..", "results"))
singlerun_pdf_prefix = "TAlkEaSy_singlerun"

plot_TAlkEaSy_singlerun(

    TAlkEaSy_run.state;
    pages = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13],

    xlim  = (-501.0e6, -495.0e6),               ####---- CO2 pulse test
    # xlim  = (-600.0e6, 0.0),                    ####---- DEGASS shift test 

    xticks = -501.0e6:1.0e6:-495.0e6,           ####---- CO2 pulse test
    # xticks = -600.0e6:100.0e6:0.0,              ####---- DEGASS shift test

    use_time_myr = false,
    show = true,
    save_pdf = singlerun_save_pdf,
    pdf_dir = singlerun_pdf_dir,
    pdf_prefix = singlerun_pdf_prefix,
    
)
