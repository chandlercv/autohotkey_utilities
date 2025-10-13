#Requires AutoHotkey v2.0

; Initialize logging
FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Script started`n", "debug.log")

userProfile := EnvGet("USERPROFILE")
fellowPath := userProfile . "\AppData\Local\Fellow\app-*"
FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Checking for Fellow window`n", "debug.log")

if (WinExist("ahk_exe Fellow.exe")) {
    FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Fellow window found, activating`n", "debug.log")
    fellowWindow := "ahk_exe Fellow.exe"
    WinMoveTop fellowWindow
    WinActivate fellowWindow
    WinWaitActive fellowWindow, , 2  ; Wait up to 2 seconds for activation
    if !WinActive(fellowWindow) {
        FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Warning: Failed to activate Fellow window`n",
        "debug.log")
    } else {
        FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Successfully activated Fellow window`n", "debug.log")
    }
}
else {
    FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Fellow window not found, searching for executable`n",
    "debug.log")
    ; Find the most recent fellow executable using wildcard
    loop files "C:\Users\CharlesChandler\AppData\Local\Fellow\app-*", "D" {
        latestfellowExe := A_LoopFilePath  ; Will get the last (most recent) match
        FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Found Fellow path: " . A_LoopFilePath . "`n",
        "debug.log")
    }

    if (IsSet(latestfellowExe)) {
        FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Launching Fellow from: " . latestfellowExe .
        "\Fellow.exe`n", "debug.log")
        Run latestfellowExe . "\Fellow.exe"
    } else {
        FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " ERROR: No Fellow executable found`n", "debug.log")
    }
}
FileAppend(FormatTime(A_Now, "yyyy-MM-dd HH:mm:ss") . " Script completed`n", "debug.log")