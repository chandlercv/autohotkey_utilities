#Requires AutoHotkey v2.0
if (PID := ProcessExist("chrome.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Program Files\Google\Chrome\Application\chrome.exe"
}
