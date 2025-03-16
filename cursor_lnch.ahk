#Requires AutoHotkey v2.0
if (PID := ProcessExist("cursor.exe")) {
    FileAppend("cursror.exe found at PID " PID "`n", "debug.log")
    WinActivate "ahk_pid " PID
}
else {
    FileAppend("cursor.exe not found.  Launching.`n", "debug.log")
    Run "C:\Users\charl\AppData\Local\Programs\cursor\cursor.exe"
}
