#Requires AutoHotkey v2.0
; Enumerate all windows, check for process 'wt.exe' and class 'CascadiaWindow'
found := false
allWindows := WinGetList()
for idx, hwnd in allWindows {
    try {
        procName := WinGetProcessName(hwnd)
        className := WinGetClass(hwnd)
        if (procName = "wt.exe" && className = "CascadiaWindow") {
            WinActivate(hwnd)
            found := true
            break
        }
    }
}

if (!found) {
    if (FileExist("C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\wt.exe")) {
        Run "C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminal_8wekyb3d8bbwe\\wt.exe"
    } else if (FileExist("C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\\wt.exe")) {
        Run "C:\\Program Files\\WindowsApps\\Microsoft.WindowsTerminalPreview_8wekyb3d8bbwe\\wt.exe"
    } else {
        Run "wt.exe"
    }
}
