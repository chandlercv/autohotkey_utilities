#Requires AutoHotkey v2.0
if (PID := ProcessExist("Spotify.exe"))
{
    WinActivate "ahk_pid " PID
}
else
{
    Run EnvGet("APPDATA") . "\Spotify\Spotify.exe"
}
