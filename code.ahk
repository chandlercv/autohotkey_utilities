#Requires AutoHotkey v2.0
if (PID := ProcessExist("code.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Users\charl\AppData\Local\Programs\Microsoft VS Code\code.exe"
}
