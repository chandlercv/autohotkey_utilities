#Requires AutoHotkey v2.0
if (PID := ProcessExist("cursor.exe")) {
    FileAppend("cursor.exe found at PID " PID "`n", "debug.log")
    WinActivate "ahk_pid " PID
} else {
    cmd :=
        '"C:\\Windows\\System32\\WindowsPowerShell\\v1.0\\powershell.exe" -NoProfile -Command "Get-Command Cursor | Select-Object -ExpandProperty Source"'
    cursorPath := Trim(StdOutToVar(cmd))

    if cursorPath && FileExist(cursorPath) {
        Run(cursorPath)
    } else {
        FileAppend("Cursor not found via Get-Command.`n", "debug.log")
        ; StdOutToVar function for capturing command output
        StdOutToVar(cmd) {
            shell := ComObject("WScript.Shell")
            exec := shell.Exec(cmd)
            return exec.StdOut.ReadAll()
        }
    }
}
Exit