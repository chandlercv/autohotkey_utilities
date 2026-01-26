#Requires AutoHotkey v2.0
DetectHiddenWindows true
if ProcessExist("msedge.exe")
{
    windows := WinGetList("ahk_exe msedge.exe")
    if windows.Length
    {
        for hwnd in windows
        {
            if !(WinGetStyle(hwnd) & 0x10000000)
                continue
            if (WinGetTitle(hwnd) = "")
                continue

            WinShow hwnd
            WinRestore hwnd
            WinActivate hwnd
            return
        }
    }
}

Run "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
