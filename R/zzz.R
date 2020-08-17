.onAttach = function(libname, pkgname) {
    version = packageDescription(pkgname, fields = "Version")

    msg = paste0("========================================
", pkgname, " version ",
        version, "
Github page: https://github.com/PharaohCola13/pacviz
This message can be suppressed by:
  suppressPackageStartupMessages(library(pacviz))
========================================
")
    packageStartupMessage(msg)
}
