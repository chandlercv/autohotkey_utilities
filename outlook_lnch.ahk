#Requires AutoHotkey v2.0
if (PID := ProcessExist("olk.exe"))
{
    WinActivate "ahk_pid " PID
}
else if (PID := ProcessExist("OUTLOOK.EXE"))
{
    WinActivate "ahk_pid " PID
}
else if (FileExist("C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"))
{
    Run "C:\Program Files\Microsoft Office\root\Office16\OUTLOOK.EXE"
}
else
{
    Run "C:\Program Files\WindowsApps\Microsoft.OutlookForWindows_1.2024.1204.300_x64__8wekyb3d8bbwe\olk.exe"
}
