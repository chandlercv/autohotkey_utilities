#Requires AutoHotkey v2.0

userProfile := EnvGet("USERPROFILE")
slackPaths := [
    "C:\Program Files\Slack\slack.exe",  ; New location
    userProfile . "\AppData\Local\slack\app-*\slack.exe"  ; Legacy location
]

FileAppend("Starting Slack launcher`n", "debug.log")

; First try to handle existing process
if (ProcessExist("slack.exe")) {
    FileAppend("Slack process exists`n", "debug.log")
    if (WinExist("ahk_exe slack.exe")) {
        FileAppend("Slack window exists, activating`n", "debug.log")
        WinActivate "ahk_exe slack.exe"
        Exit
    }
}

; If we get here, either no process exists or no window found
FileAppend("Searching for Slack executable in known locations`n", "debug.log")
latestSlackExe := ""

; Try each possible location
for path in slackPaths {
    FileAppend("Checking path: " path "`n", "debug.log")
    if (path ~= "\*") {
        ; Wildcard path - need to loop
        loop files path {
            latestSlackExe := A_LoopFilePath
            FileAppend("Found Slack exe: " latestSlackExe "`n", "debug.log")
        }
    } else if FileExist(path) {
        ; Direct path
        latestSlackExe := path
        FileAppend("Found Slack exe: " latestSlackExe "`n", "debug.log")
        break
    }
}

if (latestSlackExe) {
    FileAppend("Launching Slack`n", "debug.log")
    Run latestSlackExe
} else {
    FileAppend("No Slack executable found in any location`n", "debug.log")
}
