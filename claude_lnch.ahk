#Requires AutoHotkey v2.0

/**
 * Finds the Claude executable by globbing the WindowsApps
 * Store install path, falling back to the legacy AppData location.
 */
FindClaudePath() {
    claudePath := ""
    Loop Files "C:\Program Files\WindowsApps\Claude_*\app\claude.exe" {
        claudePath := A_LoopFileFullPath
    }
    if claudePath
        return claudePath

    localPath := EnvGet("LOCALAPPDATA")
        . "\AnthropicClaude\claude.exe"
    if FileExist(localPath)
        return localPath

    return ""
}

claudePath := FindClaudePath()
if !claudePath {
    MsgBox "Could not find Claude executable."
    ExitApp
}

if (PID := ProcessExist("claude.exe")) {
    try {
        hwnd := WinGetID("ahk_pid " PID)
        if hwnd {
            WinActivate "ahk_id " hwnd
        } else {
            Run claudePath
        }
    } catch TargetError {
        Run claudePath
    }
} else {
    Run claudePath
}
