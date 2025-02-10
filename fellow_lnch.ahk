#Requires AutoHotkey v2.0

userProfile := EnvGet("USERPROFILE")
fellowPath := userProfile . "\AppData\Local\Fellow\app-*"
if (WinExist("ahk_exe Fellow.exe")) {
    WinActivate "ahk_exe Fellow.exe"
}
else {
    ; Find the most recent fellow executable using wildcard
    loop files "C:\Users\CharlesChandler\AppData\Local\Fellow\app-*", "D" {
        latestfellowExe := A_LoopFilePath  ; Will get the last (most recent) match
    }

    if (IsSet(latestfellowExe)) {
        Run latestfellowExe . "\Fellow.exe"
    } else {
        FileAppend("no fellow executable found`n", "debug.log")
    }
}
