using Pkg
Pkg.add("JSON3") # need for webview2wrap
Pkg.add("LiveServer") # need for example

include("src/webview2wrap.jl")
import .webview2wrap

# create web window
github = ww.create("Julia Webview2Wrap"; url="http://github.com")

# create local website window
using LiveServer
using Base.Threads
@async serve(host="0.0.0.0", port=8000, dir="./ui")

#call from javascript
function greet(name)
    "Welcome to Julia, $(name)!"
end

# instance 1
w1 = webview2wrap.create("Julia Webview Window 1"; url="http://localhost:8000")
# instance 2
w2 = webview2wrap.create("Julia Webview Window 2"; url="http://localhost:8000")

nothing
