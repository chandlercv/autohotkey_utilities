#Persistent
SetTitleMatchMode, 2

global idList := []
global currentIndex := 0

; Hotkey to cycle through windows (Alt + `)
!`::
    ; Get the process name of the currently active window
    WinGet, activeProcess, ProcessName, A

    ; If the list is empty or the process has changed, update the list
    if (idList.MaxIndex() = 0 || activeProcess != currentProcess)
    {
        ; Clear the list
        idList := []
        currentIndex := 0

        ; Get a list of all windows belonging to the same process
        WinGet, idListTemp, List, ahk_exe %activeProcess%

        ; Populate the global list
        Loop, %idListTemp%
        {
            idList.Push(idListTemp%A_Index%)
        }

        ; Store the current process
        currentProcess := activeProcess
    }

    ; If the list is still empty, return
    if (idList.MaxIndex() = 0)
        return

    ; Move to the next window in the list
    currentIndex := Mod(currentIndex, idList.MaxIndex()) + 1
    next_id := idList[currentIndex]
    WinActivate, ahk_id %next_id%
return