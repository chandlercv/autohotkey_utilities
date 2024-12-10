#Requires AutoHotkey v2.0
if (PID := ProcessExist("outlook.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Program Files\Microsoft Office\root\Office16\outlook.exe"
}
