
const projectdir = dirname(dirname(Pkg.pathof(GEMSMagTIPDocumentation)))


dir_lib(args...) = joinpath(projectdir, "doc_library", args...)
dir_tut(args...) = joinpath(projectdir, "doc_tutorial", args...)

dir_0(args...) = joinpath(projectdir, args...)
