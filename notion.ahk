#Requires AutoHotkey v2.0
if (PID := ProcessExist("notion.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run "C:\Users\charl\AppData\Local\Programs\Notion\Notion.exe"
}
