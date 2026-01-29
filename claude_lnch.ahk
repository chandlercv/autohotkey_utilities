#Requires AutoHotkey v2.0
if (PID := ProcessExist("claude.exe")) {
    try {
        hwnd := WinGetID("ahk_pid " PID)
        if hwnd {
            WinActivate "ahk_id " hwnd
        } else {
            ; Try running the executable again to show the app window
            Run "C:\Users\CharlesChandler\AppData\Local\AnthropicClaude\claude.exe"
        }
    } catch {
        ; Try running the executable again to show the app window
        Run "C:\Users\CharlesChandler\AppData\Local\AnthropicClaude\claude.exe"
    }
} else {
    Run "C:\Users\CharlesChandler\AppData\Local\AnthropicClaude\claude.exe"
}
