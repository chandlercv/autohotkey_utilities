#Requires AutoHotkey v2.0

userProfile := EnvGet("USERPROFILE")

if (WinExist("ahk_exe Notion.exe"))
{
    WinActivate "ahk_exe Notion.exe"
}
else
{
    Run userProfile . "\AppData\Local\Programs\Notion\Notion.exe"
}
