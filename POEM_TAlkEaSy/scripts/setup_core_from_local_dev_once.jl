
import Pkg

project_dir = normpath(joinpath(@__DIR__, ".."))
core_dir = normpath(joinpath(project_dir, "..", "POEM_core"))
manifest_file = joinpath(project_dir, "Manifest.toml")

Pkg.activate(project_dir)

if !isfile(joinpath(core_dir, "Project.toml"))
    error("Cannot find local POEM_core Project.toml at: $(core_dir)")
end

if isfile(manifest_file)
    rm(manifest_file; force = true)
    @info "Removed old Manifest.toml" manifest_file
end

Pkg.develop(path = core_dir)
Pkg.resolve()
Pkg.instantiate()

@info "POEMCore installed in local develop mode" project_dir core_dir
