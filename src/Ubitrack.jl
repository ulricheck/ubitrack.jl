#module Ubitrack
using Cxx

# Check Julia version before continuing (also checked later in Cxx)
(VERSION >= v"0.4-") ? nothing :
     throw(ErrorException("Julia $VERSION does not support C++ FFI"))

# Load names of Ubitrack shared libraries (pre-compiled)
include(joinpath(Pkg.dir("Ubitrack"), "src/Ubitrack_libs.jl"))

# static directories for now
const utlibdir = joinpath(Pkg.dir("Ubitrack"), "deps/usr64/lib")
const utheaderdir = joinpath(Pkg.dir("Ubitrack"), "deps/usr64/include")

addHeaderDir(utlibdir; kind = C_System)

# Load Ubitrack shared libraries
# IMPORTANT: if necessary, make sure to link symbols accross libraries with RTLD_GLOBAL
for i in ubitrack_libraries
    dlopen_e(joinpath(utlibdir,i), RTLD_GLOBAL)==C_NULL ? throw(ArgumentError("Skip loading $(i)")): nothing
end

addHeaderDir(utheaderdir; kind = C_System)

# utilities
cxxinclude(joinpath(utheaderdir, "utUtil/Logging.h"))
cxxinclude(joinpath(utheaderdir, "utUtil/Exception.h"))

# math
cxxinclude(joinpath(utheaderdir, "utMath/Vector.h"))
cxxinclude(joinpath(utheaderdir, "utMath/Matrix.h"))
cxxinclude(joinpath(utheaderdir, "utMath/VectorFunctions.h"))
cxxinclude(joinpath(utheaderdir, "utMath/MatrixOperations.h"))
cxxinclude(joinpath(utheaderdir, "utMath/Quaternion.h"))
cxxinclude(joinpath(utheaderdir, "utMath/RotationVelocity.h"))
cxxinclude(joinpath(utheaderdir, "utMath/Scalar.h"))
cxxinclude(joinpath(utheaderdir, "utMath/Pose.h"))

