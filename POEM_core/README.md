# POEMCore

Platform Of Earth-system Models (POEM) core source code.

This repository contains reusable source code only:

- forcing readers
- variable registration helpers
- solver wrappers
- model input assembly helpers
- result-processing helpers

It does not contain local model equations, local parameters, forcing spreadsheets, outputs, or results.

## Julia usage

Install once from the local model project:

```julia
import Pkg
Pkg.activate(".")
Pkg.add(url = "https://github.com/Chen-Xiyuan/POEM_core.git")
```

Then use it in code:

```julia
import POEMCore
```

For local source-code development, use `Pkg.develop(path = "../POEM_core")` instead of `Pkg.add(url = ...)`.
