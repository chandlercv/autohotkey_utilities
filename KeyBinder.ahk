#Requires AutoHotkey v2.0

; Bind Ctrl+Alt+Shift+B to launch or bring Microsoft Edge to the foreground
^!+b::
{
    if (PID := ProcessExist("msedge.exe"))
    {
        WinActivate "ahk_pid " PID
    }
    else
    {
        Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
    }
}
return
