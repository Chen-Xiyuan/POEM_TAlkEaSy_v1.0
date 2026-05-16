
module Forcing

export required_forcing_names
export _forcing_files
export forcing_directory

function forcing_directory(project_dir::AbstractString)

    return normpath(joinpath(project_dir, "forcings"))

end

function required_forcing_names()

    return Symbol[
        :CPland_relative,
        :EVO,
        :W,
        :COAL,
        :GRAN_EXPOSED_AREA,
        :DEGASS,
        :UPLIFT,
        :PG,
        :BA_EXPOSED_AREA,
        :P_selective,
        :PELAGIC,
        :CARB_EXPOSED_AREA,
        :CARB_FLOODED_AREA,
    ]

end

function _forcing_files()

    return Dict{Symbol,String}(

        :CPland_relative       =>    "CPland_TAlkEaSy_steady.xlsx",
        :EVO                   =>    "EVO_TAlkEaSy_steady.xlsx",
        :W                     =>    "W_TAlkEaSy_steady.xlsx",
        :COAL                  =>    "COAL_TAlkEaSy_steady.xlsx",
        :GRAN_EXPOSED_AREA     =>    "GRANAREA_TAlkEaSy_steady.xlsx",
        :UPLIFT                =>    "UPLIFT_TAlkEaSy_steady.xlsx",
        :PG                    =>    "PG_TAlkEaSy_steady.xlsx",
        :BA_EXPOSED_AREA       =>    "BAAREA_TAlkEaSy_steady.xlsx",
        :P_selective           =>    "Pselective_TAlkEaSy_steady.xlsx",
        :PELAGIC               =>    "Bforcing_TAlkEaSy_steady.xlsx",
        :CARB_EXPOSED_AREA     =>    "CARBexposedAREA_TAlkEaSy_steady.xlsx",
        :CARB_FLOODED_AREA     =>    "CARBfloodedAREA_TAlkEaSy_steady.xlsx",

        :DEGASS                =>    "DEGASS_TAlkEaSy_steady.xlsx",
        # :CO2_pulse             =>    "CO2Pulse_TAlkEaSy_steady.xlsx",

        #  pulse test 
        :CO2_pulse             => "CO2Pulse_TAlkEaSy_pulse.xlsx",
        # :DEGASS                => "DEGASS_TAlkEaSy_pulse.xlsx",

    )

end

end # module Forcing
