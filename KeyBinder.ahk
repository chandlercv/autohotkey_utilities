#Requires AutoHotkey v2.0

autoHotKeyUtilRoot := EnvGet("AUTOHOTKEYUTILS")

; Bind Ctrl+Alt+Shift+B to launch or bring Microsoft Edge to the foreground
^!+b::
{
    run(autoHotKeyUtilRoot . "chrome_lnch.ahk")
}

^!+n::
{
    run(autoHotKeyUtilRoot . "notion_lnch.ahk")
}

^!+f::
{
    run(autoHotKeyUtilRoot . "fellow_lnch.ahk")
}

^!+c::
{
    run(autoHotKeyUtilRoot . "code_lnch.ahk")
}

^!+s::
{
    run(autoHotKeyUtilRoot . "slack_lnch.ahk")
}

^!+z::
{
    run(autoHotKeyUtilRoot . "zoom_lnch.ahk")
}

^!+o::
{
    run(autoHotKeyUtilRoot . "outlook_lnch.ahk")
}

^!+m::
{
    run(autoHotKeyUtilRoot . "freeplane_lnch.ahk")
}

^+g::
{
    Send("https://documentcrunch.atlassian.net/browse/")
}

F20::
{
    Run(autoHotKeyUtilRoot . "surface_edge_lnch.ahk")
}

F16::
{
    Send("^z")
}

F17::
{
    Send("^y")
}

^#n::
{
    Run(autoHotKeyUtilRoot . "tidbit.svg")
}
