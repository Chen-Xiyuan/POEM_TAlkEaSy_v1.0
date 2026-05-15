POEM-TAlkEaSy version 1.0

developed by Xiyuan Chen (xiyuanchenemail@gmail.com)

supported by Ph.D. supervisor Prof. Tim Lenton (T.M.Lenton@exeter.ac.uk)

Related paper: Chen and Lenton, TAlkEaSy: the Total Alkalinity Earth System Model v1.0 for exploring climate, redox and ocean chemistry over geologic time, Geoscientific Model Development, under review 


This repository contains the exact code and input files used for the GMD model description paper.

Folders:
- POEM_core: reusable POEM platform source code
- POEM_TAlkEaSy: local TAlkEaSy model equations, parameters, run scripts, and input files


To run:
1. Open Julia 1.10.
2. cd("POEM_TAlkEaSy")
3. include("scripts/setup_core_from_local_dev_once.jl")
4. import POEMCore
5. import API_TAlkEaSy
6. include("scripts/run_TAlkEaSy_singlerun.jl")
