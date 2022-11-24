## Julia webview2 wrap

![JWW icon](https://raw.githubusercontent.com/bluebug/webview2wrap/master/icons/icon.ico)

see example.jl for detail.

1. most win32 api come from julia-win32

https://github.com/henrik-m/julia-win32

2. webView2 runtime should be installed from page:
   
https://developer.microsoft.com/en-us/microsoft-edge/webview2/

3. webview2 sdk can be donwloaded from page :

https://www.nuget.org/packages/Microsoft.Web.WebView2 

the nupkg file can be unzip as zip file. "WebView2.h" is in "\build\native\include", and "WebView2Loader.dll" is in "\build\native\x64".
