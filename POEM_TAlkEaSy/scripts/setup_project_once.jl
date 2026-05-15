
import Pkg

project_root = normpath(joinpath(@__DIR__, ".."))

Pkg.activate(project_root)
Pkg.instantiate()
Pkg.precompile()

@info "Project is ready" project_root
