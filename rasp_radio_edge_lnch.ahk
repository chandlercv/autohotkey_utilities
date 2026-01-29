#Requires AutoHotkey v2.0
DetectHiddenWindows true
url := "http://rasp-radio"
if ProcessExist("msedge.exe") {
    windows := WinGetList("ahk_exe msedge.exe")
    for hwnd in windows {
        if !(WinGetStyle(hwnd) & 0x10000000)
            continue
        title := WinGetTitle(hwnd)
        if InStr(title, "rasp-radio") {
            WinShow hwnd
            WinRestore hwnd
            WinActivate hwnd
            return
        }
    }
}
Run('"C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" "' url '"')