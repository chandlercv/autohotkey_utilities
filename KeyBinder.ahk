#Requires AutoHotkey v2.0

autoHotKeyUtilRoot := EnvGet("AUTOHOTKEYUTILS")

; Bind Ctrl+Alt+Shift+B to launch or bring Microsoft Edge to the foreground
^!+b::
{
    run(autoHotKeyUtilRoot . "chrome_lnch.exe")
}

^!+n::
{
    run(autoHotKeyUtilRoot . "notion_lnch.exe")
}

^!+c::
{
    run(autoHotKeyUtilRoot . "code_lnch.exe")
}

^!+s::
{
    run(autoHotKeyUtilRoot . "slack_lnch.exe")
}

^!+z::
{
    run(autoHotKeyUtilRoot . "zoom_lnch.exe")
}

^!+o::
{
    run(autoHotKeyUtilRoot . "outlook_lnch.exe")
}

^!+m::
{
    run(autoHotKeyUtilRoot . "freeplane_lnch.exe")
}

^+g::
{
    Send("https://documentcrunch.atlassian.net/browse/")
}


F18::
{
    Send("#{Left}")
}

F19::
{
    Send("#{Right}")
}

F24::
{
    Send("#n")
}

F16::
{
    Send("^z")
}

F17::
{
    Send("^y")
}

F23::
{
    Send("^{F5}")
}