#Requires AutoHotkey v2.0
if (PID := ProcessExist("claude.exe")) {
    WinActivate "ahk_pid " PID
}
else {
    Run "C:\Users\CharlesChandler\AppData\Local\AnthropicClaude\claude.exe"
}
