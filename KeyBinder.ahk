#Requires AutoHotkey v2.0

autoHotKeyUtilRoot := EnvGet("AUTOHOTKEYUTILS")

; Launch persistent GUI launcher script on startup
Run(autoHotKeyUtilRoot . "shortcuts_folder_lnch.ahk")

; Global variable to enable/disable hotkeys (useful during Zoom screen sharing)
global HotkeysEnabled := true

; Toggle hotkeys on/off with Ctrl+Alt+F12 (always works, even when disabled)
^+Insert::
{
    global HotkeysEnabled
    HotkeysEnabled := !HotkeysEnabled
    ToolTip("Hotkeys " . (HotkeysEnabled ? "ON" : "OFF"))
    SetTimer(() => ToolTip(), -2000)
}

; Hotkeys below are only active when HotkeysEnabled is true
#HotIf HotkeysEnabled

; Bind Ctrl+Alt+Shift+B to launch or bring Microsoft Edge to the foreground
^!+b::
{
    run(autoHotKeyUtilRoot . "chrome_lnch.ahk")
}

^!+l::
{
    run(autoHotKeyUtilRoot . "linear_lnch.ahk")
}

^!+n::
{
    run(autoHotKeyUtilRoot . "notion_lnch.ahk")
}

^!+f::
{
    run(autoHotKeyUtilRoot . "fellow_lnch.ahk")
}

^!+v::
{
    run(autoHotKeyUtilRoot . "code_lnch.ahk")
}

^!+c::
{
    run(autoHotKeyUtilRoot . "cursor_lnch.ahk")
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

^!+p::
{
    run(autoHotKeyUtilRoot . "spotify_lnch.ahk")
}

^!+m::
{
    run(autoHotKeyUtilRoot . "freeplane_lnch.ahk")
    ; run("C:\Program Files\Freeplane\freeplane.exe")
}

^+g::
{
    Send("https://linear.app/document-crunch/issue/trip")
}

F16::
{
    Send("^z")
}

F17::
{
    Send("^y")
}

^+Space::
{
    FileAppend("Ctrl+Shift+Space was pressed`n", "debug.log")
    MoveCursorToCenter()
}

#HotIf  ; End conditional hotkeys - hotkeys below always work

F20::
{
    Run(autoHotKeyUtilRoot . "surface_edge_lnch.ahk")
}

^#n::
{
    Run(autoHotKeyUtilRoot . "tidbit.svg")
}

^+Escape::  ; Ctrl+Alt+Escape to release all keys (always available)
{
    Send("{Ctrl up}{Alt up}{Shift up}{Enter up}")
}

MoveCursorToCenter() {
    FileAppend("MoveCursorToCenter`n", "debug.log")

    ; Set coordinate mode to screen for absolute positioning
    CoordMode("Mouse", "Screen")

    ; Get the active window's position and size
    WinGetPos(&winX, &winY, &winWidth, &winHeight, "A")
    FileAppend("Window Position and Size: X=" winX " Y=" winY " Width=" winWidth " Height=" winHeight "`n", "debug.log"
    )

    ; Calculate the center position relative to the window's absolute screen position
    centerX := winX + (winWidth // 2)
    centerY := winY + (winHeight // 2)
    FileAppend("Center Position: X=" centerX " Y=" centerY "`n", "debug.log")

    ; Move the cursor to the center
    ; MouseMove(centerX, centerY)
    DllCall("SetCursorPos", "int", centerX, "int", centerY)
}
