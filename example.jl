"""
using Pkg
Pkg.add("JSON3") # need for webview2wrap
Pkg.add("LiveServer") # need for example
"""

include("src/webview2wrap.jl")
import .webview2wrap

# create web window
# github = webview2wrap.create("Julia Webview2Wrap"; url="https://github.com/bluebug/webview2wrap")

# create local website window
using LiveServer
using Base.Threads
@async serve(host="0.0.0.0", port=8000, dir="./ui")

#call from javascript
function greet(name)
    "Welcome to Julia, $(name)!"
end

# instance 1
w = webview2wrap.create("Julia Webview Window 1"; url="http://localhost:8000", icon="icons/icon.ico")

nothing
