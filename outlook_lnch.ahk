#Requires AutoHotkey v2.0
if (PID := ProcessExist("olk.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Program Files\WindowsApps\Microsoft.OutlookForWindows_1.2024.1204.300_x64__8wekyb3d8bbwe\olk.exe"
}
