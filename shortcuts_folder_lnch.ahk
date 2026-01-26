#Requires AutoHotkey v2.0
#SingleInstance Force
Persistent

; Persistent GUI launcher that toggles on hotkey
; If a 1340x800 touchscreen monitor is connected, show/maximize on that display

global launcherGui := 0
global isVisible := false

; Register the toggle hotkey
^!+a::ToggleLauncher()

ToggleLauncher() {
    global launcherGui, isVisible
    
    if (isVisible && launcherGui) {
        ; Hide/destroy the GUI
        launcherGui.Destroy()
        launcherGui := 0
        isVisible := false
        return
    }
    
    ; Create and show the GUI

    ; Create and show the GUI
    
    autoHotKeyUtilRoot := EnvGet("AUTOHOTKEYUTILS")
    if (!autoHotKeyUtilRoot) {
        autoHotKeyUtilRoot := A_ScriptDir . "\\"
    }
    if (!StrEndsWith(autoHotKeyUtilRoot, "\\")) {
        autoHotKeyUtilRoot .= "\\"
    }

    configFile := autoHotKeyUtilRoot . "shortcuts_config.ini"
    
    ; Read settings from config
    cols := IniRead(configFile, "Settings", "Columns", "4")
    btnSize := IniRead(configFile, "Settings", "ButtonSize", "100")
    
    apps := GetAppList(autoHotKeyUtilRoot, configFile)

    launcherGui := Gui("+AlwaysOnTop +ToolWindow", "App Shortcuts")
    launcherGui.MarginX := 12
    launcherGui.MarginY := 12
    launcherGui.BackColor := "0x1E1E1E"
    launcherGui.SetFont("s12 cWhite", "Segoe UI")
    launcherGui.OnEvent("Close", (*) => ToggleLauncher())

    ; Build button grid with square buttons or icons
    for idx, app in apps {
        opts := "w" btnSize " h" btnSize
        if (idx = 1) {
            opts .= " section"
        } else if (Mod(idx - 1, cols) = 0) {
            opts .= " xs y+m"
        } else {
            opts .= " x+m yp"
        }

        if (app.iconPath != "") {
            pic := launcherGui.AddPicture(opts . " BackgroundTrans", app.iconPath)
            pic.OnEvent("Click", MakeLauncher(app.path))
        } else {
            btn := launcherGui.AddButton(opts, app.label)
            btn.OnEvent("Click", MakeLauncher(app.path))
        }
    }

    touchscreenMonitor := FindTouchscreenMonitor()
    if (touchscreenMonitor) {
        MonitorGet(touchscreenMonitor, &monLeft, &monTop, &monRight, &monBottom)
        monWidth := monRight - monLeft
        monHeight := monBottom - monTop
        ; Show window first to get its size, positioned offscreen temporarily
        launcherGui.Show("x-5000 y-5000 AutoSize")
        Sleep(50)  ; Brief delay to ensure window is created
        WinGetPos(,, &winWidth, &winHeight, "ahk_id " launcherGui.Hwnd)
        ; Calculate centered position
        centerX := monLeft + (monWidth - winWidth) // 2
        centerY := monTop + (monHeight - winHeight) // 2
        ; Move to centered position
        WinMove(centerX, centerY,,, "ahk_id " launcherGui.Hwnd)
    } else {
        launcherGui.Show("Center AutoSize")
    }
    
    ; Set transparency after window is shown
    WinSetTransparent(220, "ahk_id " launcherGui.Hwnd)
    
    isVisible := true
}

MakeLauncher(path) {
    LaunchAndHide(*) {
        Run(path)
        ToggleLauncher()  ; Hide launcher after launching app
    }
    return LaunchAndHide
}

GetAppList(root, configFile) {
    apps := []
    
    ; Read all keys from [Apps] section
    appsSection := IniRead(configFile, "Apps")
    
    ; Parse the section (format: key=value\nkey=value...)
    Loop Parse, appsSection, "`n", "`r" {
        line := Trim(A_LoopField)
        ; Skip empty lines and comments
        if (line = "" || SubStr(line, 1, 1) = ";")
            continue
            
        ; Split on first = sign
        eqPos := InStr(line, "=")
        if (eqPos) {
            label := Trim(SubStr(line, 1, eqPos - 1))
            filename := Trim(SubStr(line, eqPos + 1))
            iconPath := ResolveIconPath(root, configFile, label, filename)
            apps.Push({label: label, path: root . filename, iconPath: iconPath})
        }
    }
    
    return apps
}

ResolveIconPath(root, configFile, label, scriptFile) {
    iconPath := ""

    try iconPath := IniRead(configFile, "Icons", label, "")
    if (iconPath != "") {
        if !IsAbsolutePath(iconPath)
            iconPath := root . iconPath
        if FileExist(iconPath)
            return iconPath
    }

    SplitPath(scriptFile, , , , &nameNoExt)
    iconsDir := root . "icons\\"
    for ext in [".png", ".ico", ".jpg", ".bmp", ".gif"] {
        candidate := iconsDir . nameNoExt . ext
        if FileExist(candidate)
            return candidate
    }

    return ""
}

IsAbsolutePath(path) {
    return RegExMatch(path, "i)^[A-Z]:\\") || SubStr(path, 1, 2) = "\\\\"
}

FindTouchscreenMonitor() {
    monitorCount := MonitorGetCount()
    Loop monitorCount {
        MonitorGet(A_Index, &monLeft, &monTop, &monRight, &monBottom)
        width := monRight - monLeft
        height := monBottom - monTop
        if (width = 1072 && height = 640) {
            return A_Index
        }
    }
    return 0
}

StrEndsWith(haystack, needle) {
    if (StrLen(needle) = 0)
        return true
    return SubStr(haystack, -StrLen(needle) + 1) = needle
}
