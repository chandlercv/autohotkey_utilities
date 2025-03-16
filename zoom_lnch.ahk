#Requires AutoHotkey v2.0

enableLogging := false  ; Set to true to enable logging

LogMessage(msg) {
    if (!enableLogging)
        return

    timestamp := FormatTime(, "yyyy-MM-dd HH:mm:ss")
    maxAttempts := 3
    attempt := 1
    while (attempt <= maxAttempts) {
        try {
            FileAppend(timestamp . " - " . msg . "`n", "debug.log")
            return
        } catch Error as e {
            if (attempt = maxAttempts) {
                return
            }
            Sleep(100)
            attempt++
        }
    }
}

LogMessage("Script started")

if (PID := ProcessExist("zoom.exe")) {
    LogMessage("Found Zoom process with PID: " . PID)
    DetectHiddenWindows(true)

    windowsList := WinGetList("ahk_exe Zoom.exe")
    zoomFound := false

    for window in windowsList {
        title := WinGetTitle(window)
        LogMessage("Found window with title: " . title)

        if (title ~= "Zoom Meeting|Zoom$|Zoom Video Communications") {
            WinShow(window)
            WinRestore(window)
            WinActivate(window)
            zoomFound := true
            LogMessage("Activated main Zoom window: " . title)
            break
        }
    }

    if (!zoomFound) {
        LogMessage("No main Zoom window found, trying to activate Zoom")
        if WinExist("ahk_class ZPPTMainFrmWndClass") {
            WinActivate
            zoomFound := true
            LogMessage("Activated Zoom via main window class")
        }
    }

    if (!zoomFound) {
        LogMessage("No visible Zoom windows found, launching new instance")
        Run "C:\Program Files\Zoom\bin\zoom.exe"
    }
} else {
    LogMessage("Zoom process not found, launching new instance")
    Run "C:\Program Files\Zoom\bin\zoom.exe"
    LogMessage("Launched new Zoom instance")
}
