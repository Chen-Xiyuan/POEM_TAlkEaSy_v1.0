

import Pkg

project_dir = normpath(joinpath(@__DIR__, ".."))
manifest_file = joinpath(project_dir, "Manifest.toml")

Pkg.activate(project_dir)

if isfile(manifest_file)
    rm(manifest_file; force = true)
    @info "Removed old Manifest.toml" manifest_file
end

Pkg.add(url = "https://github.com/Chen-Xiyuan/POEM_core.git")
Pkg.resolve()
Pkg.instantiate()

@info "POEMCore installed from GitHub" project_dir
