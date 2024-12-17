#Requires AutoHotkey v2.0

userProfile := EnvGet("USERPROFILE")
slackPath := userProfile . "\AppData\Local\slack\app-*\slack.exe"
if (WinExist("ahk_exe slack.exe"))
{
    WinActivate "ahk_exe slack.exe"
}
else
{
    ; Find the most recent Slack executable using wildcard
    Loop Files slackPath
    {
        latestSlackExe := A_LoopFilePath  ; Will get the last (most recent) match
    }
    if (IsSet(latestSlackExe))
        Run latestSlackExe
}