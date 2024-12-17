#Requires AutoHotkey v2.0
if (PID := ProcessExist("msedge.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
}
