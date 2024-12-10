#Requires AutoHotkey v2.0

autoHotKeyUtilRoot := EnvGet("AUTOHOTKEYUTILS")

; Bind Ctrl+Alt+Shift+B to launch or bring Microsoft Edge to the foreground
^!+b::
{
   run( autoHotKeyUtilRoot . "surface_edge.exe")
}

^!+n::
{
   run( autoHotKeyUtilRoot . "notion.exe")
}

^!+c::
{
   run( autoHotKeyUtilRoot . "code.exe")
}

^!+s::
{
   run( autoHotKeyUtilRoot . "slack.exe")
}

^!+o::
{
   run( autoHotKeyUtilRoot . "slack.exe")
}

^!+z::
{
   run( autoHotKeyUtilRoot . "zoom.exe")
}

