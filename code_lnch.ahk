#Requires AutoHotkey v2.0
if (PID := ProcessExist("code.exe")) {
    FileAppend("code.exe found at PID " PID "`n", "debug.log")
    WinActivate "ahk_pid " PID
}
else {
    FileAppend("code.exe not found.  Launching.`n", "debug.log")
    Run "C:\Users\charl\AppData\Local\Programs\Microsoft VS Code\code.exe"
}
