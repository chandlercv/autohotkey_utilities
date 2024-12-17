#Requires AutoHotkey v2.0

userProfile := EnvGet("USERPROFILE")

; First check just for javaw.exe
if existingWindow := WinExist("ahk_exe javaw.exe")
{
    MsgBox "Found javaw.exe window: " . WinGetTitle(existingWindow)
    
    ; Now check for Freeplane specifically
    if freeplaneWindow := WinExist("ahk_exe javaw.exe", "Freeplane")
    {
        MsgBox "Found Freeplane window: " . WinGetTitle(freeplaneWindow)
        WinActivate(freeplaneWindow)
    }
    else 
    {
        MsgBox "Found javaw.exe but not Freeplane"
    }
}
else
{
    MsgBox "No javaw.exe windows found"
}
