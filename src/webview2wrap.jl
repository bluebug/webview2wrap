module webview2wrap
import JSON3

const global JSJuliaObject = raw"$Julia"
const global INIT_SCRIPT = """
    const $JSJuliaObject = new Proxy([], {
    get: function (target, prop, receiver) {
        if (prop === "\$tasks") {
            return target
        }
        return (...args) => {
            const uuid = crypto.randomUUID();
            var promise = new Promise(function (resolve, reject) {
                target[uuid] = {
                    resolve: (...result) => { delete target[uuid]; resolve(...result); },
                    reject: (...result) => { delete target[uuid]; reject(...result); },
                };
            });
            window.chrome.webview.postMessage({
                uuid:uuid,
                fun:prop,
                args:JSON.stringify(args)
            });
            return promise;
        }
    }
});
"""

#### Begin (C)Constants for win32 and webview2 ####
begin
    const global FALSE = Cint(0)
    const global TRUE = Cint(1)

    const global BYTE = Cuchar
    const global WORD = Cushort
    const global DWORD = Culong
    const global DWORDLONG = UInt64
    const global DWORD32 = UInt32
    const global DWORD64 = UInt64

    const global BOOL = Cint
    const global BOOLEAN = BYTE

    const global CHAR = Cchar
    const global CCHAR = Cchar

    const global FLOAT = Cfloat

    const global LONG = Culong
    const global ULONG = Culong
    const global LONG32 = Cint
    const global LONG64 = Int64
    const global LONG_PTR = Int

    const global SHORT = Cshort
    const global USHORT = Cushort

    const global ATOM = WORD
    const global LANGID = WORD

    const global COLORREF = DWORD
    const global LGRPID = DWORD
    const global LCTYPE = DWORD

    const global LCID = DWORD

    const global INT = Int32
    const global INT8 = Int8
    const global INT16 = Int16
    const global INT32 = Int32
    const global INT64 = Int64
    const global INT_PTR = Int
    const global UINT_PTR = UInt

    const global WPARAM = UINT_PTR
    const global LPARAM = LONG_PTR
    const global LRESULT = LONG_PTR
    const global WNDPROC = LRESULT
    #############################################

    const global HANDLE = Ptr{Cvoid}

    const global HACCEL = HANDLE
    const global HBITMAP = HANDLE
    const global HBRUSH = HANDLE
    const global HCOLORSPACE = HANDLE
    const global HCONV = HANDLE
    const global HCONVLIST = HANDLE
    const global HDC = HANDLE
    const global HDDEDATA = HANDLE
    const global HDESK = HANDLE
    const global HDROP = HANDLE
    const global HDWP = HANDLE
    const global HENHMETAFILE = HANDLE
    const global HFILE = Cint
    const global HFONT = HANDLE
    const global HGDIOBJ = HANDLE
    const global HGLOBAL = HANDLE
    const global HHOOK = HANDLE
    const global HICON = HANDLE
    const global HCURSOR = HICON
    const global HINSTANCE = HANDLE
    const global HKEY = HANDLE
    const global HKL = HANDLE
    const global HLOCAL = HANDLE
    const global HMENU = HANDLE
    const global HMETAFILE = HANDLE
    const global HMODULE = HANDLE
    const global HMONITOR = HANDLE
    const global HPALETTE = HANDLE
    const global HPEN = HANDLE
    const global HRESULT = Clong
    const global HRGN = HANDLE
    const global HRSRC = HANDLE
    const global HSZ = HANDLE
    const global HWINSTA = HANDLE
    const global HWND = HANDLE

    #############################################

    const global PHANDLE = Ptr{HANDLE}

    const global UCHAR = Cuchar
    const global WCHAR = Cwchar_t
    const global PWCHAR = Ptr{WCHAR}

    const global PWORD = Ptr{WORD}
    const global LPWORD = Ptr{WORD}
    const global PDWORD = Ptr{DWORD}
    const global LPDWORD = Ptr{DWORD}

    const global VOID = Cvoid
    const global PVOID = Ptr{Cvoid}
    const global LPVOID = Ptr{Cvoid}
    const global LPCVOID = Ptr{Cvoid}

    const global LPINT = Ptr{Cint}
    const global PINT = Ptr{Cint}

    #############################################

    const global PSTR = Ptr{CHAR}
    const global PCSTR = Ptr{CHAR}
    const global LPSTR = Ptr{CHAR}
    const global LPCSTR = Ptr{CHAR}

    const global PWSTR = Ptr{WCHAR}
    const global PCWSTR = Ptr{WCHAR}
    const global LPWSTR = Ptr{WCHAR}
    const global LPCWSTR = Ptr{WCHAR}

    #### win32 flags and structs #### 
    ##### Image types #####
    const global IMAGE_BITMAP = convert(Cint, 0)
    const global IMAGE_ICON = convert(Cint, 1)
    const global IMAGE_CURSOR = convert(Cint, 2)

    ##### Resource load flags #####
    const global LR_CREATEDIBSECTION = convert(Cuint, 0x00002000)
    const global LR_DEFAULTCOLOR = convert(Cuint, 0x00000000)
    const global LR_DEFAULTSIZE = convert(Cuint, 0x00000040)
    const global LR_LOADFROMFILE = convert(Cuint, 0x00000010)
    const global LR_LOADMAP3DCOLORS = convert(Cuint, 0x00001000)
    const global LR_LOADTRANSPARENT = convert(Cuint, 0x00000020)
    const global LR_MONOCHROME = convert(Cuint, 0x00000001)
    const global LR_SHARED = convert(Cuint, 0x00008000)
    const global LR_VGACOLOR = convert(Cuint, 0x00000080)

    ###### Window Messages #####
    const global WM_CLOSE = convert(Cuint, 0x0010)
    const global WM_DESTROY = convert(Cuint, 0x0002)
    const global WM_LBUTTONDOWN = convert(Cuint, 0x0201)
    const global WM_CREATE = convert(Cuint, 0x0001)
    const global WM_COMMAND = convert(Cuint, 0x0111)
    const global WM_DPICHANGED = Cuint(0x02E0)
    const global WM_SIZE = Cuint(0x0005)
    const global WM_QUIT = Cuint(0x0012)
    const global WM_APP = Cuint(0x8000)

    ##### Extended Window Styles #####
    const global WS_EX_CLIENTEDGE = convert(Culong, 0x00000200)
    const global WS_EX_WINDOWEDGE = convert(Culong, 0x00000100)
    const global WS_EX_TOOLWINDOW = convert(Culong, 0x00000080)
    const global WS_EX_TOPMOST = convert(Culong, 0x00000008)
    const global WS_EX_OVERLAPPEDWINDOW = WS_EX_WINDOWEDGE | WS_EX_CLIENTEDGE
    const global WS_EX_PALETTEWINDOW = WS_EX_WINDOWEDGE | WS_EX_TOOLWINDOW | WS_EX_TOPMOST

    ##### Class styles #####
    const global CS_VREDRAW = Cuint(0x0001)
    const global CS_HREDRAW = Cuint(0x0002)
    const global CS_DBLCLKS = Cuint(0x0008)
    const global CS_OWNDC = Cuint(0x0020)
    const global CS_CLASSDC = Cuint(0x0040)
    const global CS_PARENTDC = Cuint(0x0080)
    const global CS_NOCLOSE = Cuint(0x0200)
    const global CS_SAVEBITS = Cuint(0x0800)
    const global CS_BYTEALIGNCLIENT = Cuint(0x1000)
    const global CS_BYTEALIGNWINDOW = Cuint(0x2000)
    const global CS_GLOBALCLASS = Cuint(0x4000)

    #### HBRUSH ####
    const global COLOR_WINDOW = 5

    ##### Window Styles #####
    const global WS_OVERLAPPED = Culong(0x00000000)
    const global WS_POPUP = Culong(0x80000000)
    const global WS_CHILD = Culong(0x40000000)
    const global WS_MINIMIZE = Culong(0x20000000)
    const global WS_VISIBLE = Culong(0x10000000)
    const global WS_DISABLED = Culong(0x08000000)
    const global WS_CLIPSIBLINGS = Culong(0x04000000)
    const global WS_CLIPCHILDREN = Culong(0x02000000)
    const global WS_MAXIMIZE = Culong(0x01000000)
    const global WS_CAPTION = Culong(0x00C00000)
    const global WS_BORDER = Culong(0x00800000)
    const global WS_DLGFRAME = Culong(0x00400000)
    const global WS_VSCROLL = Culong(0x00200000)
    const global WS_HSCROLL = Culong(0x00100000)
    const global WS_SYSMENU = Culong(0x00080000)
    const global WS_THICKFRAME = Culong(0x00040000)
    const global WS_GROUP = Culong(0x00020000)
    const global WS_TABSTOP = Culong(0x00010000)
    const global WS_MINIMIZEBOX = Culong(0x00020000)
    const global WS_MAXIMIZEBOX = Culong(0x00010000)

    const global WS_POPUPWINDOW = WS_POPUP | WS_BORDER | WS_SYSMENU
    const global WS_CHILDWINDOW = WS_CHILD
    const global WS_BOXWINDOW = WS_CAPTION | WS_SYSMENU | WS_THICKFRAME | WS_MINIMIZEBOX | WS_MAXIMIZEBOX
    const global WS_OVERLAPPEDWINDOW = WS_OVERLAPPED | WS_BOXWINDOW

    ##### ShowWindow Parameters #####
    const global SW_SHOWDEFAULT = convert(Cint, 10)

    ##### CreateWindow Parameters #####
    const global CW_USEDEFAULT = convert(Cint, -2147483648)

    ##### WinApi Error Codes #####
    const global ERROR_INVALID_WINDOW_HANDLE = convert(Culong, 0x00000578)
    const global ERROR_CLASS_ALREADY_EXISTS = convert(Culong, 0x00000582)

    ##### Menu creation flags #####
    const global MF_BITMAP = convert(Cuint, 0x00000004)
    const global MF_CHECKED = convert(Cuint, 0x00000008)
    const global MF_DISABLED = convert(Cuint, 0x00000002)
    const global MF_ENABLED = convert(Cuint, 0x00000000)
    const global MF_GRAYED = convert(Cuint, 0x00000001)
    const global MF_MENUBARBREAK = convert(Cuint, 0x00000020)
    const global MF_MENUBREAK = convert(Cuint, 0x00000040)
    const global MF_OWNERDRAW = convert(Cuint, 0x00000100)
    const global MF_POPUP = convert(Cuint, 0x00000010)
    const global MF_SEPARATOR = convert(Cuint, 0x00000800)
    const global MF_STRING = convert(Cuint, 0x00000000)
    const global MF_UNCHECKED = convert(Cuint, 0x00000000)

    #### DPI defines ####
    const global DPI_AWARENESS_CONTEXT_UNAWARE = Clong(-1)
    const global DPI_AWARENESS_CONTEXT_SYSTEM_AWARE = Clong(-2)
    const global DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE = Clong(-3)
    const global DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2 = Clong(-4)
    const global DPI_AWARENESS_CONTEXT_UNAWARE_GDISCALED = Clong(-5)
    #auto DPI
    ccall(("SetProcessDpiAwarenessContext", "user32"), Cint, (Clonglong,), Clonglong(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2))

    #### SetWindowPos Flags ####
    const global SWP_NOSIZE = Cuint(0x0001)
    const global SWP_NOMOVE = Cuint(0x0002)
    const global SWP_NOZORDER = Cuint(0x0004)
    const global SWP_NOREDRAW = Cuint(0x0008)
    const global SWP_NOACTIVATE = Cuint(0x0010)
    const global SWP_FRAMECHANGED = Cuint(0x0020) # /* The frame changed: send WM_NCCALCSIZE */
    const global SWP_SHOWWINDOW = Cuint(0x0040)
    const global SWP_HIDEWINDOW = Cuint(0x0080)
    const global SWP_NOCOPYBITS = Cuint(0x0100)
    const global SWP_NOOWNERZORDER = Cuint(0x0200) # /* Don't do owner Z ordering */
    const global SWP_NOSENDCHANGING = Cuint(0x0400) # /* Don't send WM_WINDOWPOSCHANGING */

    const global SWP_DRAWFRAME = SWP_FRAMECHANGED
    const global SWP_NOREPOSITION = SWP_NOOWNERZORDER

    const global SWP_DEFERERASE = Cuint(0x2000)
    const global SWP_ASYNCWINDOWPOS = Cuint(0x4000)
end
#### End (C)Constants ####

#### Begin (C)Structs for win32 and webview2 ####
begin
    mutable struct WNDCLASSEXW
        cbSize::Cuint
        style::Cuint
        lpfnWndProc::Ptr{Cvoid}
        cbClsExtra::Cint
        cbWndExtra::Cint
        hInstance::Ptr{Cvoid}
        hIcon::Ptr{Cvoid}
        hCursor::Ptr{Cvoid}
        hbrBackground::Ptr{Cvoid}
        lpszMenuName::Cwstring
        lpszClassName::Cwstring
        hIconSm::Ptr{Cvoid}
    end

    mutable struct POINT
        x::Clong
        y::Clong
    end

    mutable struct RECT
        left::Clong
        top::Clong
        right::Clong
        bottom::Clong
    end

    mutable struct MSG
        hwnd::Ptr{Cvoid}
        message::Cuint
        wParam::Culonglong
        lParam::Clonglong
        time::Culong
        pt::POINT
        MSG(hwnd, msg, wParam, lParam) = new(hwnd, msg, wParam, lParam, 0, POINT(0, 0))
        MSG() = MSG(C_NULL, 0, 0, 0)
    end
    #### end win32 flags and structs ####

    #### webview2 structs ####

    mutable struct ICoreWebView2EnvironmentOptionsVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        get_AdditionalBrowserArguments::Ptr{Cvoid}
        put_AdditionalBrowserArguments::Ptr{Cvoid}
        get_Language::Ptr{Cvoid}
        put_Language::Ptr{Cvoid}
        get_TargetCompatibleBrowserVersion::Ptr{Cvoid}
        put_TargetCompatibleBrowserVersion::Ptr{Cvoid}
        get_AllowSingleSignOnUsingOSPrimaryAccount::Ptr{Cvoid}
        put_AllowSingleSignOnUsingOSPrimaryAccount::Ptr{Cvoid}
    end

    mutable struct EventRegistrationToken
        value::Clonglong
    end

    mutable struct EnvironmentCompletedHandlerVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        Invoke::Ptr{Cvoid}
    end

    mutable struct ControllerCompletedHandlerVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        Invoke::Ptr{Cvoid}
    end

    mutable struct WebMessageReceivedEventHandlerVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        Invoke::Ptr{Cvoid}
    end

    mutable struct ICoreWebView2EnvironmentVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        CreateCoreWebView2Controller::Ptr{Cvoid}
        CreateWebResourceResponse::Ptr{Cvoid}
        get_BrowserVersionString::Ptr{Cvoid}
        add_NewBrowserVersionAvailable::Ptr{Cvoid}
        remove_NewBrowserVersionAvailable::Ptr{Cvoid}
    end

    mutable struct ICoreWebView2ControllerVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        get_IsVisible::Ptr{Cvoid}
        put_IsVisible::Ptr{Cvoid}
        get_Bounds::Ptr{Cvoid}
        put_Bounds::Ptr{Cvoid}
        get_ZoomFactor::Ptr{Cvoid}
        put_ZoomFactor::Ptr{Cvoid}
        add_ZoomFactorChanged::Ptr{Cvoid}
        remove_ZoomFactorChanged::Ptr{Cvoid}
        SetBoundsAndZoomFactor::Ptr{Cvoid}
        MoveFocus::Ptr{Cvoid}
        add_MoveFocusRequested::Ptr{Cvoid}
        remove_MoveFocusRequested::Ptr{Cvoid}
        add_GotFocus::Ptr{Cvoid}
        remove_GotFocus::Ptr{Cvoid}
        add_LostFocus::Ptr{Cvoid}
        remove_LostFocus::Ptr{Cvoid}
        add_AcceleratorKeyPressed::Ptr{Cvoid}
        remove_AcceleratorKeyPressed::Ptr{Cvoid}
        get_ParentWindow::Ptr{Cvoid}
        put_ParentWindow::Ptr{Cvoid}
        NotifyParentWindowPositionChanged::Ptr{Cvoid}
        Close::Ptr{Cvoid}
        get_CoreWebView2::Ptr{Cvoid}
    end

    mutable struct ICoreWebView2SettingsVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        get_IsScriptEnabled::Ptr{Cvoid}
        put_IsScriptEnabled::Ptr{Cvoid}
        get_IsWebMessageEnabled::Ptr{Cvoid}
        put_IsWebMessageEnabled::Ptr{Cvoid}
        get_AreDefaultScriptDialogsEnabled::Ptr{Cvoid}
        put_AreDefaultScriptDialogsEnabled::Ptr{Cvoid}
        get_IsStatusBarEnabled::Ptr{Cvoid}
        put_IsStatusBarEnabled::Ptr{Cvoid}
        get_AreDevToolsEnabled::Ptr{Cvoid}
        put_AreDevToolsEnabled::Ptr{Cvoid}
        get_AreDefaultContextMenusEnabled::Ptr{Cvoid}
        put_AreDefaultContextMenusEnabled::Ptr{Cvoid}
        get_AreHostObjectsAllowed::Ptr{Cvoid}
        put_AreHostObjectsAllowed::Ptr{Cvoid}
        get_IsZoomControlEnabled::Ptr{Cvoid}
        put_IsZoomControlEnabled::Ptr{Cvoid}
        get_IsBuiltInErrorPageEnabled::Ptr{Cvoid}
        put_IsBuiltInErrorPageEnabled::Ptr{Cvoid}
    end

    mutable struct ICoreWebView2Vtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        get_Settings::Ptr{Cvoid}
        get_Source::Ptr{Cvoid}
        Navigate::Ptr{Cvoid}
        NavigateToString::Ptr{Cvoid}
        add_NavigationStarting::Ptr{Cvoid}
        remove_NavigationStarting::Ptr{Cvoid}
        add_ContentLoading::Ptr{Cvoid}
        remove_ContentLoading::Ptr{Cvoid}
        add_SourceChanged::Ptr{Cvoid}
        remove_SourceChanged::Ptr{Cvoid}
        add_HistoryChanged::Ptr{Cvoid}
        remove_HistoryChanged::Ptr{Cvoid}
        add_NavigationCompleted::Ptr{Cvoid}
        remove_NavigationCompleted::Ptr{Cvoid}
        add_FrameNavigationStarting::Ptr{Cvoid}
        remove_FrameNavigationStarting::Ptr{Cvoid}
        add_FrameNavigationCompleted::Ptr{Cvoid}
        remove_FrameNavigationCompleted::Ptr{Cvoid}
        add_ScriptDialogOpening::Ptr{Cvoid}
        remove_ScriptDialogOpening::Ptr{Cvoid}
        add_PermissionRequested::Ptr{Cvoid}
        remove_PermissionRequested::Ptr{Cvoid}
        add_ProcessFailed::Ptr{Cvoid}
        remove_ProcessFailed::Ptr{Cvoid}
        AddScriptToExecuteOnDocumentCreated::Ptr{Cvoid}
        RemoveScriptToExecuteOnDocumentCreated::Ptr{Cvoid}
        ExecuteScript::Ptr{Cvoid}
        CapturePreview::Ptr{Cvoid}
        Reload::Ptr{Cvoid}
        PostWebMessageAsJson::Ptr{Cvoid}
        PostWebMessageAsString::Ptr{Cvoid}
        add_WebMessageReceived::Ptr{Cvoid}
        remove_WebMessageReceived::Ptr{Cvoid}
        CallDevToolsProtocolMethod::Ptr{Cvoid}
        get_BrowserProcessId::Ptr{Cvoid}
        get_CanGoBack::Ptr{Cvoid}
        get_CanGoForward::Ptr{Cvoid}
        GoBack::Ptr{Cvoid}
        GoForward::Ptr{Cvoid}
        GetDevToolsProtocolEventReceiver::Ptr{Cvoid}
        Stop::Ptr{Cvoid}
        add_NewWindowRequested::Ptr{Cvoid}
        remove_NewWindowRequested::Ptr{Cvoid}
        add_DocumentTitleChanged::Ptr{Cvoid}
        remove_DocumentTitleChanged::Ptr{Cvoid}
        get_DocumentTitle::Ptr{Cvoid}
        AddHostObjectToScript::Ptr{Cvoid}
        RemoveHostObjectFromScript::Ptr{Cvoid}
        OpenDevToolsWindow::Ptr{Cvoid}
        add_ContainsFullScreenElementChanged::Ptr{Cvoid}
        remove_ContainsFullScreenElementChanged::Ptr{Cvoid}
        get_ContainsFullScreenElement::Ptr{Cvoid}
        add_WebResourceRequested::Ptr{Cvoid}
        remove_WebResourceRequested::Ptr{Cvoid}
        AddWebResourceRequestedFilter::Ptr{Cvoid}
        RemoveWebResourceRequestedFilter::Ptr{Cvoid}
        add_WindowCloseRequested::Ptr{Cvoid}
        remove_WindowCloseRequested::Ptr{Cvoid}
    end

    mutable struct ICoreWebView2WebMessageReceivedEventArgsVtbl
        QueryInterface::Ptr{Cvoid}
        AddRef::Ptr{Cvoid}
        Release::Ptr{Cvoid}
        get_Source::Ptr{Cvoid}
        get_WebMessageAsJson::Ptr{Cvoid}
        TryGetWebMessageAsString::Ptr{Cvoid}
    end

    mutable struct Interface
        lpVtbl::Ptr{Cvoid}
    end
    #### end struct return from C ####
end
#### End (C)Structs####

#### Begin Win32 functions ####
#### https://github.com/henrik-m/julia-win32 ####
begin
    function cwstring(val)
        val == C_NULL || isa(val, Cwstring) ? val :
        Base.unsafe_convert(Cwstring, Base.cconvert(Cwstring, string(val)))
    end

    function getlasterror()
        ccall((:GetLastError, "kernel32"), Culong, ())
    end

    function defwindowproc(hwnd, msg, wParam, lParam)
        ccall((:DefWindowProcW, "user32"), Clonglong, (Ptr{Cvoid}, Cuint, Culonglong, Clonglong), hwnd, msg, wParam, lParam)
    end

    function destroywindow(hwnd)
        ret = ccall((:DestroyWindow, "user32"), Cint, (Ptr{Cvoid},), hwnd)
        error = ret == C_NULL ? getlasterror() : 0
        (ret, error)
    end

    function post_quitmessage(exitcode)
        ccall((:PostQuitMessage, "user32"), Cvoid, (Cint,), exitcode)
    end

    function showwindow(hwnd, nCmdShow=SW_SHOWDEFAULT)
        ccall((:ShowWindow, "user32"), Cint, (Ptr{Cvoid}, Cint), hwnd, nCmdShow)
    end

    function updatewindow(hwnd)
        ccall((:UpdateWindow, "user32"), Cint, (Ptr{Cvoid},), hwnd)
    end

    function setfocus(hwnd)
        ccall((:SetFocus, "user32"), Ptr{Cvoid}, (Ptr{Cvoid},), hwnd)
    end

    function setactivewindow(hwnd)
        ccall((:SetActiveWindow, "user32"), Ptr{Cvoid}, (Ptr{Cvoid},), hwnd)
    end

    function setforegroundwindow(hwnd)
        ccall((:SetForegroundWindow, "user32"), Ptr{Cvoid}, (Ptr{Cvoid},), hwnd)
    end

    function settitle(hwnd, title)
        ccall((:SetWindowTextW, "user32"), Ptr{Cvoid}, (Ptr{Cvoid}, Cwstring), hwnd, cwstring(title))
    end

    # BOOL __stdcall SetWindowPos(HWND hWnd, HWND hWndInsertAfter, int X, int Y, int cx, int cy, UINT uFlags)
    function setwindowpos(hwnd, lParam)
        newWindowSize::RECT = unsafe_load(reinterpret(Ptr{RECT}, lParam))
        ccall((:SetWindowPos, "user32"), BOOL, (HWND, HWND, Cint, Cint, Cint, Cint, Cuint),
            hwnd,
            Ptr{Cvoid}(),
            newWindowSize.left,
            newWindowSize.top,
            newWindowSize.right - newWindowSize.left,
            newWindowSize.bottom - newWindowSize.top,
            SWP_NOZORDER | SWP_NOACTIVATE
        )
    end

    function getmessage(ptr_msg, hwnd=C_NULL)
        ccall((:GetMessageW, "user32"), Cint, (Ptr{MSG}, Ptr{Cvoid}, Cuint, Cuint), ptr_msg, C_NULL, 0, 0)
    end

    function peekmessage(ptr_msg, hwnd=C_NULL, REMOVE=0)
        ccall((:PeekMessageW, "user32"), Cint, (Ptr{MSG}, Ptr{Cvoid}, Cuint, Cuint, Cuint), ptr_msg, C_NULL, 0, 0, REMOVE)
    end

    function translatemessage(ptr_msg)
        ccall((:TranslateMessage, "user32"), Cint, (Ptr{MSG},), ptr_msg)
    end

    function dispatchmessage(ptr_msg)
        ccall((:DispatchMessageW, "user32"), Clonglong, (Ptr{MSG},), ptr_msg)
    end

    function postMessage(hWnd, Msg, wParam, lParam)
        ccall((:PostMessageW, "user32"), Clonglong, (HWND, Cuint, WPARAM, LPARAM), hWnd, Msg, wParam, lParam)
    end

    function iswindow(hwnd)
        ret = ccall((:IsWindow, "user32"), Cint, (Ptr{Cvoid},), hwnd)
        ret != 0
    end

    function loadimage(name, imgType, cx, cy, loadFlags)
        handle = ccall((:LoadImageW, "user32"), Ptr{Cvoid},
            (Ptr{Cvoid}, Cwstring, Cuint, Cint, Cint, Cuint),
            C_NULL, name, imgType, cx, cy, loadFlags)

        error = handle == C_NULL ? getlasterror() : 0

        (handle, error)
    end
end
#### End Win32 functions ####

#### Begin Webview2 interfaces ####
begin
    function QueryInterface(This::Ptr{Cvoid}, riid::Ptr{Cvoid}, ppvObject::Ptr{Ptr{Cvoid}})::HRESULT
        return 0 # S_OK
    end

    function AddRef(This::Ptr{Cvoid})::Culong
        # @show ("AddRef", This)
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            interfacewraper.refCounter += 1
            return interfacewraper.refCounter
        end
        return 1
    end

    function Release(This::Ptr{Cvoid})::Culong
        # @show ("Release", This)
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            interfacewraper.refCounter -= 1
            return interfacewraper.refCounter
        end
        return 1
    end


    function get_AdditionalBrowserArguments(This::Ptr{Cvoid}, value::Ref{Cwstring})::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            value[] = interfacewraper.AdditionalBrowserArguments
            @show value[]
        end
        return 0
    end

    function put_AdditionalBrowserArguments(This::Ptr{Cvoid}, value::Cwstring)::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            interfacewraper.AdditionalBrowserArguments = value
            @show value
        end
        return 0
    end

    function get_Language(This::Ptr{Cvoid}, value::Ref{Cwstring})::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            value[] = interfacewraper.Language
        end
        return 0
    end

    function put_Language(This::Ptr{Cvoid}, value::Cwstring)::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            interfacewraper.Language = value
        end
        return 0
    end

    function get_TargetCompatibleBrowserVersion(This::Ptr{Cvoid}, value::Ref{Cwstring})::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            value[] = interfacewraper.TargetCompatibleBrowserVersion
        end
        return 0
    end

    function put_TargetCompatibleBrowserVersion(This::Ptr{Cvoid}, value::Cwstring)::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            interfacewraper.TargetCompatibleBrowserVersion = value
        end
        return 0
    end

    function get_AllowSingleSignOnUsingOSPrimaryAccount(This::Ptr{Cvoid}, allow::Ref{BOOL})::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            allow[] = interfacewraper.AllowSingleSignOnUsingOSPrimaryAccount
        end
        return 0
    end

    function put_AllowSingleSignOnUsingOSPrimaryAccount(This::Ptr{Cvoid}, allow::BOOL)::HRESULT
        global InterfaceWraperCache
        if haskey(InterfaceWraperCache, This)
            interfacewraper = InterfaceWraperCache[This]
            interfacewraper.AllowSingleSignOnUsingOSPrimaryAccount = allow
        end
        return 0
    end

    function EnvironmentCompletedInvoke(This::Ptr{Cvoid}, errorCode::HRESULT, createdEnvironment::Ptr{Cvoid})::HRESULT
        global InterfaceWraperCache, Webview2WrapCache
        if haskey(InterfaceWraperCache, This)
            environmentHandler = InterfaceWraperCache[This]
            webviewwraper::Webview2Wraper = Webview2WrapCache[environmentHandler.hwnd]
            webviewwraper.environment = InterfaceWraper{ICoreWebView2EnvironmentVtbl}(createdEnvironment, environmentHandler.hwnd)
            webviewwraper.webviewstatus = WEBVIEW_PADDING_CONTROLLER
        end
        return 0 # S_OK
    end

    function ControllerCompletedInvoke(This::Ptr{Cvoid}, errorCode::HRESULT, createdController::Ptr{Cvoid})::HRESULT
        global InterfaceWraperCache, Webview2WrapCache
        if errorCode == 0 && haskey(InterfaceWraperCache, This)
            controllerHandler = InterfaceWraperCache[This]
            webviewwraper::Webview2Wraper = Webview2WrapCache[controllerHandler.hwnd]
            webviewwraper.controller = InterfaceWraper{ICoreWebView2ControllerVtbl}(createdController, controllerHandler.hwnd)
            webviewwraper.webviewstatus = WEBVIEW_PADDING_WEBVIEW

            refPtr = Ref{Ptr{Cvoid}}()
            ccall(webviewwraper.controller.vtbl.get_CoreWebView2,
                HRESULT, (Ptr{Cvoid}, Ref{Ptr{Cvoid}}), createdController, refPtr)
            webviewwraper.webview = InterfaceWraper{ICoreWebView2Vtbl}(refPtr[], controllerHandler.hwnd)
            webviewwraper.webviewstatus = WEBVIEW_PADDING_SETTINGS

            ccall(webviewwraper.webview.vtbl.get_Settings, HRESULT, (Ptr{Cvoid}, Ref{Ptr{Cvoid}}), webviewwraper.webview.interfaceptr, refPtr)
            webviewwraper.webviewSettings = InterfaceWraper{ICoreWebView2SettingsVtbl}(refPtr[], controllerHandler.hwnd)

            ccall(webviewwraper.webviewSettings.vtbl.put_IsScriptEnabled, HRESULT, (Ptr{Cvoid}, Cint), webviewwraper.webviewSettings.interfaceptr, TRUE)
            ccall(webviewwraper.webviewSettings.vtbl.put_AreDefaultScriptDialogsEnabled, HRESULT, (Ptr{Cvoid}, Cint), webviewwraper.webviewSettings.interfaceptr, TRUE)
            ccall(webviewwraper.webviewSettings.vtbl.put_IsWebMessageEnabled, HRESULT, (Ptr{Cvoid}, Cint), webviewwraper.webviewSettings.interfaceptr, TRUE)
            ccall(webviewwraper.webviewSettings.vtbl.put_AreDevToolsEnabled, HRESULT, (Ptr{Cvoid}, Cint), webviewwraper.webviewSettings.interfaceptr, TRUE)
            ccall(webviewwraper.webviewSettings.vtbl.put_IsStatusBarEnabled, HRESULT, (Ptr{Cvoid}, Cint), webviewwraper.webviewSettings.interfaceptr, TRUE)

            bounds = RECT(0, 0, 0, 0)
            ccall(("GetClientRect", "user32"), BOOL, (HWND, Ptr{RECT}), webviewwraper.hwnd, pointer_from_objref(bounds))
            ccall(webviewwraper.controller.vtbl.put_Bounds, HRESULT, (Ptr{Cvoid}, RECT), createdController, bounds)

            refToken = Ref{Ptr{Cvoid}}()
            ccall(webviewwraper.webview.vtbl.add_WebMessageReceived,
                HRESULT, (Ptr{Cvoid}, Ptr{Cvoid}, Ref{Ptr{Cvoid}}),
                webviewwraper.webview.interfaceptr,
                webviewwraper.webMessageHandler.interfaceptr, refToken)

            webviewwraper.webviewstatus = WEBVIEW_DONE

        end
        return errorCode # S_OK
    end

    mutable struct JSMSG
        uuid::String
        fun::String
        args::String
    end

    function invoke(webviewwraper, uuid, expr)
        @show uuid, expr
        try
            res = Meta.eval(Meta.parse(expr))
            res = webviewwraper.evaljs("""$JSJuliaObject.\$tasks["$(uuid)"].resolve($(JSON3.write(res)))""")
        catch e
            res = webviewwraper.evaljs("""$JSJuliaObject.\$tasks["$(uuid)"].reject($(JSON3.write(e)))""")
        end
    end

    function WebMessageReceivedInvoke(This::Ptr{Cvoid}, sender::Ptr{Cvoid}, args::Ptr{Cvoid})::HRESULT
        global InterfaceWraperCache, Webview2WrapCache
        if haskey(InterfaceWraperCache, This)
            webMessageHandler = InterfaceWraperCache[This]
            webviewwraper::Webview2Wraper = Webview2WrapCache[webMessageHandler.hwnd]
            eventArgs = InterfaceWraper{ICoreWebView2WebMessageReceivedEventArgsVtbl}(args, webMessageHandler.hwnd)
            msg = Ref{Cwstring}()
            # ccall(eventArgs.vtbl.TryGetWebMessageAsString, HRESULT, (Ptr{Cvoid}, Ref{Cwstring}), eventArgs.interfaceptr, msg)
            ccall(eventArgs.vtbl.get_WebMessageAsJson, HRESULT, (Ptr{Cvoid}, Ref{Cwstring}), eventArgs.interfaceptr, msg)
            jsonstr = unsafe_string(msg[])
            try
                json = JSON3.read(jsonstr, JSMSG)
                if (json.fun === "synceval")
                    invoke(webviewwraper, json.uuid, Meta.eval(Meta.parse(json.args))[1])
                else
                    errormonitor(@async (() -> begin
                        if (json.fun === "eval")
                            invoke(webviewwraper, json.uuid, Meta.eval(Meta.parse(json.args))[1])
                        else
                            invoke(webviewwraper, json.uuid, """$(json.fun)($(json.args)...)""")
                        end
                    end)())
                end
            catch e
                @show jsonstr, e
            end

        end
        return 0 # S_OK
    end
end
#### End Webview2 interfaces ####

#### Begin wrap ####
begin
    @enum MSGLOOP_STATUS MSGLOOP_START MSGLOOP_RUNNING MSGLOOP_STOP
    @enum WINDOW_STATUS WINDOW_START WINDOW_RUNNING WINDOW_STOP
    @enum WEBVIEW_STATUS WEBVIEW_PADDING_ENV WEBVIEW_PADDING_CONTROLLER WEBVIEW_PADDING_WEBVIEW WEBVIEW_PADDING_SETTINGS WEBVIEW_DONE

    global InterfaceWraperCache = Dict()
    global InterfaceWraperCache = Dict()
    global Webview2WrapCache = Dict()
    global Webview2WindowCache = Dict()
    global Webview2WindowPendings = Dict()

    function windowproc(hwnd, msg, wParam, lParam)
        if msg == WM_CLOSE
            destroywindow(hwnd)
        elseif msg == WM_DESTROY
            # NOT using post_quitmessage(0), it will stop all
            w = Webview2WindowCache[hwnd]
            w.windowstatus = WINDOW_STOP
            w.close()
        elseif msg == WM_DPICHANGED
            setwindowpos(hwnd, lParam)
            return 1
        elseif msg == WM_SIZE
            if haskey(Webview2WindowCache, hwnd)
                w = Webview2WindowCache[hwnd]
                if w !== nothing && w.controller.interfaceptr !== C_NULL
                    bounds = RECT(0, 0, 0, 0)
                    ccall(("GetClientRect", "user32"), BOOL, (HWND, Ptr{RECT}), hwnd, pointer_from_objref(bounds))
                    ccall(w.controller.vtbl.put_Bounds, HRESULT, (Ptr{Cvoid}, RECT), w.controller.interfaceptr, bounds)
                end
            end
            return 1
        else
            return defwindowproc(hwnd, msg, wParam, lParam)
        end
        return 0
    end

    function createwindow(;
        classname=:WC_DEFAULT,
        title="Untitled",
        x=CW_USEDEFAULT,
        y=CW_USEDEFAULT,
        width=1200,
        height=600,
        exStyle=0,
        style=WS_OVERLAPPEDWINDOW,
        proc=C_NULL,
        icon=C_NULL,
        iconSm=C_NULL)

        # If the window is created with the default class, that class is auto-registered
        if classname == :WC_DEFAULT
            hInstance = ccall(("GetModuleHandleW", "kernel32"), HMODULE, (LPCWSTR,), LPCWSTR())
            hCursor = ccall(("LoadCursorW", "user32"), HCURSOR, (HINSTANCE, LPCWSTR), C_NULL, Ptr{Cvoid}(32512))

            wcex = WNDCLASSEXW(
                sizeof(WNDCLASSEXW),
                CS_HREDRAW | CS_VREDRAW,
                proc == C_NULL ? windowproc_c.ptr : proc,
                0,
                0,
                hInstance,
                icon,
                hCursor,
                Ptr{Cvoid}(COLOR_WINDOW + 1),
                cwstring(C_NULL),
                cwstring(classname),
                iconSm
            )

            atom = ccall((:RegisterClassExW, "user32"), Cushort, (Ptr{WNDCLASSEXW},), pointer_from_objref(wcex))
            err = atom == 0 ? getlasterror() : 0
            if err != 0 && err != ERROR_CLASS_ALREADY_EXISTS
                # @show :RegisterClassExW, err
                return (0, err)
            end
        end
        if width !== CW_USEDEFAULT || height !== CW_USEDEFAULT
            dpi = ccall(("GetDpiFromDpiAwarenessContext", "user32"), Cuint, (Clonglong,), Clonglong(DPI_AWARENESS_CONTEXT_SYSTEM_AWARE))
            dpiscale = Int(dpi) // 96

            if width !== CW_USEDEFAULT
                width = Int(dpiscale * width)
            end

            if height !== CW_USEDEFAULT
                height = Int(dpiscale * height)
            end
        end

        hwnd = ccall(
            (:CreateWindowExW, "user32"),
            Ptr{Cvoid},
            (Culong, Cwstring, Cwstring, Culong, Cint, Cint, Cint, Cint, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}),
            convert(Culong, exStyle),
            string(classname),
            string(title),
            convert(Culong, style),
            convert(Cint, x),
            convert(Cint, y),
            convert(Cint, width),
            convert(Cint, height),
            C_NULL,
            C_NULL,
            C_NULL,
            C_NULL)

        error = hwnd == C_NULL ? getlasterror() : 0

        (hwnd, error)
    end

    mutable struct InterfaceWraper{VTBL}
        hwnd::HWND
        interface::Interface
        interfaceptr::Ptr{Cvoid}
        lpVtbl::Ptr{VTBL}
        vtbl::VTBL
        refCounter::Integer

        # options 
        AdditionalBrowserArguments::Cwstring
        Language::Cwstring
        TargetCompatibleBrowserVersion::Cwstring
        AllowSingleSignOnUsingOSPrimaryAccount::BOOL
        # end options

        function InterfaceWraper{VTBL}(hwnd::HWND) where
        {VTBL<:Union{
                ICoreWebView2EnvironmentOptionsVtbl,
                EnvironmentCompletedHandlerVtbl,
                ControllerCompletedHandlerVtbl,
                WebMessageReceivedEventHandlerVtbl}}
            self = new()
            self.hwnd = hwnd

            cQueryInterface = @cfunction($QueryInterface, HRESULT, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Ptr{Cvoid}}))
            cAddRef = @cfunction($AddRef, Culong, (Ptr{Cvoid},))
            cRelease = @cfunction($Release, Culong, (Ptr{Cvoid},))
            cInvoke = nothing
            if VTBL <: ICoreWebView2EnvironmentOptionsVtbl
                self.AdditionalBrowserArguments = cwstring(C_NULL)
                self.Language = cwstring(C_NULL)
                self.TargetCompatibleBrowserVersion = cwstring(C_NULL)
                self.AllowSingleSignOnUsingOSPrimaryAccount = BOOL(0)

                cget_AdditionalBrowserArguments = @cfunction($get_AdditionalBrowserArguments, HRESULT, (Ptr{Cvoid}, Ref{Cwstring}))
                cput_AdditionalBrowserArguments = @cfunction($put_AdditionalBrowserArguments, HRESULT, (Ptr{Cvoid}, Cwstring))
                cget_Language = @cfunction($get_Language, HRESULT, (Ptr{Cvoid}, Ref{Cwstring}))
                cput_Language = @cfunction($put_Language, HRESULT, (Ptr{Cvoid}, Cwstring))
                cget_TargetCompatibleBrowserVersion = @cfunction($get_TargetCompatibleBrowserVersion, HRESULT, (Ptr{Cvoid}, Ref{Cwstring}))
                cput_TargetCompatibleBrowserVersion = @cfunction($put_TargetCompatibleBrowserVersion, HRESULT, (Ptr{Cvoid}, Cwstring))
                cget_AllowSingleSignOnUsingOSPrimaryAccount = @cfunction($get_AllowSingleSignOnUsingOSPrimaryAccount, HRESULT, (Ptr{Cvoid}, Ref{BOOL}))
                cput_AllowSingleSignOnUsingOSPrimaryAccount = @cfunction($put_AllowSingleSignOnUsingOSPrimaryAccount, HRESULT, (Ptr{Cvoid}, BOOL))

                self.vtbl = ICoreWebView2EnvironmentOptionsVtbl(cQueryInterface.ptr, cAddRef.ptr, cRelease.ptr,
                    cget_AdditionalBrowserArguments.ptr, cput_AdditionalBrowserArguments.ptr,
                    cget_Language.ptr, cput_Language.ptr,
                    cget_TargetCompatibleBrowserVersion.ptr, cput_TargetCompatibleBrowserVersion.ptr,
                    cget_AllowSingleSignOnUsingOSPrimaryAccount.ptr, cput_AllowSingleSignOnUsingOSPrimaryAccount.ptr,
                )
            else
                if VTBL <: EnvironmentCompletedHandlerVtbl
                    cInvoke = @cfunction($EnvironmentCompletedInvoke, HRESULT, (Ptr{Cvoid}, HRESULT, Ptr{Cvoid}))
                end
                if VTBL <: ControllerCompletedHandlerVtbl
                    cInvoke = @cfunction($ControllerCompletedInvoke, HRESULT, (Ptr{Cvoid}, HRESULT, Ptr{Cvoid}))
                end
                if VTBL <: WebMessageReceivedEventHandlerVtbl
                    cInvoke = @cfunction($WebMessageReceivedInvoke, HRESULT, (Ptr{Cvoid}, Ptr{Cvoid}, Ptr{Cvoid}))
                end
                self.vtbl = VTBL(cQueryInterface.ptr, cAddRef.ptr, cRelease.ptr, cInvoke.ptr)
            end
            self.lpVtbl = pointer_from_objref(self.vtbl)
            self.interface = Interface(self.lpVtbl)
            self.interfaceptr = pointer_from_objref(self.interface)
            self.refCounter = 0

            push!(InterfaceWraperCache, (self.interfaceptr => self))

            self
        end

        "create VTBL struct with C_NULL and wait for interface Ptr from C"
        (InterfaceWraper{VTBL}() where {VTBL}) = begin
            x = new()
            x.interfaceptr = C_NULL
            x
        end

        "convert C interface Ptr to julia struct"
        (InterfaceWraper{VTBL}(ptr::Ptr{Cvoid}, hwnd::HWND) where {VTBL}) = begin
            self = new()
            self.hwnd = hwnd
            self.interfaceptr = ptr
            self.interface = unsafe_load(reinterpret(Ptr{Interface}, ptr))
            self.lpVtbl = reinterpret(Ptr{VTBL}, self.interface.lpVtbl)
            self.vtbl = unsafe_load(self.lpVtbl)

            #call AddRef to keep pointer in C
            if :AddRef in fieldnames(VTBL)
                ccall(self.vtbl.AddRef, Culong, (Ptr{Cvoid},), self.interfaceptr)
            end
            self
        end
    end

    mutable struct Webview2Wraper
        #=== begin config ===#
        title::String
        icon::String
        initjs::String
        url::String
        html::String
        #=== end config ===#

        #=== running status ===#
        windowproc::Ptr{Cvoid}
        hwnd::HWND

        options::InterfaceWraper{ICoreWebView2EnvironmentOptionsVtbl}
        environmentHandler::InterfaceWraper{EnvironmentCompletedHandlerVtbl}
        controllerHandler::InterfaceWraper{ControllerCompletedHandlerVtbl}
        webMessageHandler::InterfaceWraper{WebMessageReceivedEventHandlerVtbl}

        environment::InterfaceWraper{ICoreWebView2EnvironmentVtbl}
        controller::InterfaceWraper{ICoreWebView2ControllerVtbl}
        webviewSettings::InterfaceWraper{ICoreWebView2SettingsVtbl}
        webview::InterfaceWraper{ICoreWebView2Vtbl}

        windowstatus::WINDOW_STATUS
        webviewstatus::WEBVIEW_STATUS
        #=== end running status ===#

        #=== functions ===#
        create::Function
        close::Function

        loadwebview::Function
        setinitjs::Function
        seturl::Function
        sethtml::Function
        evaljs::Function
        #=== end funtions ===#

        function Webview2Wraper(title; icon="", initjs="", url="", html="")
            self = new()
            self.title = title
            self.icon = icon
            self.initjs = initjs
            self.url = url
            self.html = html
            self.hwnd = HWND()
            self.windowproc = @cfunction(windowproc, Clonglong, (Ptr{Cvoid}, Cuint, Culonglong, Clonglong,))
            self.windowstatus = WINDOW_START

            self.environment = InterfaceWraper{ICoreWebView2EnvironmentVtbl}()
            self.controller = InterfaceWraper{ICoreWebView2ControllerVtbl}()
            self.webviewSettings = InterfaceWraper{ICoreWebView2SettingsVtbl}()
            self.webview = InterfaceWraper{ICoreWebView2Vtbl}()

            self.create = (w) -> begin
                (w.hwnd, err) = createwindow(title=w.title; proc=self.windowproc)
                if (err > 0)
                    @show w.hwnd, err
                    return nothing
                end
                push!(Webview2WindowCache, (w.hwnd => w))

                showwindow(w.hwnd)
                updatewindow(w.hwnd)

                w.webviewstatus = WEBVIEW_PADDING_ENV
                w.options = InterfaceWraper{ICoreWebView2EnvironmentOptionsVtbl}(w.hwnd)
                w.options.AdditionalBrowserArguments = cwstring("--disable-web-security")
                w.environmentHandler = InterfaceWraper{EnvironmentCompletedHandlerVtbl}(w.hwnd)
                w.controllerHandler = InterfaceWraper{ControllerCompletedHandlerVtbl}(w.hwnd)
                w.webMessageHandler = InterfaceWraper{WebMessageReceivedEventHandlerVtbl}(w.hwnd)

                push!(Webview2WrapCache, (w.hwnd => w))

                res = ccall(("CreateCoreWebView2EnvironmentWithOptions", "WebView2Loader"),
                    HRESULT, (Cwstring, Cwstring, Ptr{Cvoid},
                        Ptr{Cvoid}),
                    C_NULL, cwstring(pwd()),
                    w.options.interfaceptr, w.environmentHandler.interfaceptr)

                wait = 0
                while w.webviewstatus !== WEBVIEW_PADDING_CONTROLLER && wait < 200
                    wait += 1
                    yield()
                    sleep(0.005)
                end

                ccall(w.environment.vtbl.CreateCoreWebView2Controller,
                    HRESULT, (Ptr{Cvoid}, HWND, Ptr{Cvoid}),
                    w.environment.interfaceptr, w.hwnd, w.controllerHandler.interfaceptr)

                while w.webviewstatus !== WEBVIEW_DONE && wait < 600
                    wait += 1
                    yield()
                    sleep(0.005)
                end

                if w.webviewstatus !== WEBVIEW_DONE
                    println("load webview failed")
                else
                    w.setinitjs(INIT_SCRIPT)
                    if initjs !== ""
                        w.setinitjs(initjs)
                    end
                    if w.url !== ""
                        w.seturl(w.url)
                    elseif w.html !== ""
                        w.sethtml(w.html)
                    else
                        w.seturl("about:blank")
                    end
                    setforegroundwindow(w.hwnd)
                end
            end

            self.close = () -> begin
                if self.windowstatus === WINDOW_RUNNING
                    self.windowstatus = WINDOW_STOP
                    postMessage(self.hwnd, WM_CLOSE, 0, 0)
                elseif self.hwnd !== HWND()
                    delete!(Webview2WindowCache, self.hwnd)
                    # println("webview2 window $(self.hwnd) released")
                    self.hwnd = HWND()
                end
                self
            end

            self.setinitjs = (js::String) -> begin
                if self.webviewstatus === WEBVIEW_DONE
                    ccall(self.webview.vtbl.AddScriptToExecuteOnDocumentCreated, HRESULT, (Ptr{Cvoid}, Cwstring, Ptr{Cvoid}), self.webview.interfaceptr, cwstring(js), C_NULL)
                end
            end

            self.seturl = (url::String) -> begin
                if self.webviewstatus === WEBVIEW_DONE
                    ccall(self.webview.vtbl.Navigate, HRESULT, (Ptr{Cvoid}, Cwstring), self.webview.interfaceptr, cwstring(url))
                end
            end

            self.sethtml = (html::String) -> begin
                if self.webviewstatus === WEBVIEW_DONE
                    ccall(self.webview.vtbl.NavigateToString, HRESULT, (Ptr{Cvoid}, Cwstring), self.webview.interfaceptr, cwstring(html))
                end
            end

            self.evaljs = (js::String) -> begin
                if self.webviewstatus === WEBVIEW_DONE
                    ccall(self.webview.vtbl.ExecuteScript, HRESULT, (Ptr{Cvoid}, Cwstring, Ptr{Cvoid}), self.webview.interfaceptr, cwstring(js), C_NULL)
                end
            end

            push!(Webview2WindowPendings, (pointer_from_objref(self) => self))

            self
        end
    end


    function create(title; kwargs...)
        w = Webview2Wraper(title; kwargs...)
        w
    end

    global msgloopstatus = MSGLOOP_START

    function msgloop()
        if msgloopstatus === MSGLOOP_RUNNING
            return
        end

        global msgloopstatus = MSGLOOP_RUNNING
        ccall(("SetProcessDpiAwarenessContext", "user32"), Cint, (Clonglong,), Clonglong(DPI_AWARENESS_CONTEXT_PER_MONITOR_AWARE_V2))

        msg = MSG()
        ptr_msg = pointer_from_objref(msg)
        while true
            if peekmessage(ptr_msg, C_NULL, 1) > 0
                translatemessage(ptr_msg)
                dispatchmessage(ptr_msg)
            end
            if length(Webview2WindowPendings) > 0
                for (p, w) in Webview2WindowPendings
                    if w.windowstatus === WINDOW_START
                        w.windowstatus = WINDOW_RUNNING
                        delete!(Webview2WindowPendings, p)# p is pointer_from_objref(w)
                        errormonitor(@async w.create(w))
                    end
                end
            end
            yield()
            sleep(0.0125)
        end
        global msgloopstatus = WINDOW_STOP
    end
end
#### End wrap ####

"""
# When using/import module, auto start msgloop in other thread.
"""
function __init__()
    push!(Base.DL_LOAD_PATH, "$(pwd())/lib")
    global msglooptask = errormonitor(Base.Threads.@async msgloop())
    println("\n\e[0;31;1mJulia \e[0;32;1mWebview2 \e[0;35;1mWrap\e[0m\n")
    println("\e[0;34;1minclude(\"webview2wrap.jl\")\e[0m")
    println("\e[0;34;1musing .webview2wrap\e[0m")
    println("\e[0;34;1mwin = create(title::String; kwargs...); ... ; win.close()\e[0m")
end
export create

end