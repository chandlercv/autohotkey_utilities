#Requires AutoHotkey v2.0

if (PID := ProcessExist("Linear.exe"))
    {
        WinActivate "ahk_pid " PID
    }
    else
    {
        Run EnvGet("LOCALAPPDATA") . "\Programs\Linear\Linear.exe"
    }
    