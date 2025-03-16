#Requires AutoHotkey v2.0

userProfile := EnvGet("USERPROFILE")

; First check just for javaw.exe
if existingWindow := WinExist("ahk_exe javaw.exe") {
    windowTitle := WinGetTitle(existingWindow)
    windowPID := WinGetPID(existingWindow)
    windowProcessName := ProcessGetName(windowPID)

    ; Now check for Freeplane specifically
    freeplaneFound := false
    windowsList := WinGetList("ahk_exe javaw.exe")
    for freeplaneWindow in windowsList {
        freeplaneTitle := WinGetTitle(freeplaneWindow)
        if RegExMatch(freeplaneTitle, ".* - Freeplane -.*") {
            WinActivate(freeplaneWindow)
            freeplaneFound := true
            break
        }
    }
    if !freeplaneFound {
        MsgBox("Found javaw.exe but not Freeplane")
    }
} else {
    MsgBox("No javaw.exe windows found")
}
