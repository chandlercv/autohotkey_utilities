#Requires AutoHotkey v2.0
if (PID := ProcessExist("zoom.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Program Files\Zoom\bin\zoom.exe"
}
