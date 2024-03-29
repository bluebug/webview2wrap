run(`windres -i ./icons/icon.rc ./icons/icon.o`)

import Pkg;
Pkg.add("PackageCompiler");

using PackageCompiler

ENV["JULIA_CC"] = "gcc ./icons/icon.o -lole32 -lshell32 -lshlwapi -luser32 -lgdi32 -mwindows"

create_app(".", "dist"; force=true)

Base.Filesystem.cp("./lib/WebView2Loader.dll", "./dist/bin/WebView2Loader.dll"; force=true)
Base.Filesystem.cp("./ui", "./dist/ui"; force=true)
Base.Filesystem.cp("./icons", "./dist/icons"; force=true)