#Requires AutoHotkey v2.0
if (PID := ProcessExist("slack.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Users\charl\AppData\Local\slack\app-4.41.98\slack.exe"
}
