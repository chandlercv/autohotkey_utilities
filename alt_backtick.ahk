SetTitleMatchMode(2)

global idList := []
global currentIndex := 0
global currentProcess := ""

; Hotkey to cycle through windows (Alt + `)
!`:: {
    CycleWindows(1)
}

; Hotkey to cycle through windows in reverse (Alt + Shift + `)
+!`:: {
    FileAppend("Shift Alt ` pressed`n", "debug.log")
    CycleWindows(-1)
}

CycleWindows(direction) {
    global idList, currentIndex, currentProcess

    ; Get the process name of the currently active window
    activeProcess := WinGetProcessName("A")

    ; Get a list of all windows belonging to the same process
    idListTemp := WinGetList("ahk_exe " activeProcess)

    ; If the list is empty or the process has changed, update the list
    if (idList.Length = 0 || activeProcess != currentProcess) {
        ; Clear the list
        idList := []
        currentIndex := 0
        currentProcess := activeProcess

        ; Get a list of all windows belonging to the same process
        idListTemp := WinGetList("ahk_exe " activeProcess)

        ; Populate the global list
        for id in idListTemp {
            idList.Push(id)
        }
    }

    ; If the list is still empty, return
    if (idList.Length = 0)
        return

    ; Move to the next window in the list
    FileAppend("idList contents:`n" StrJoin(idList, "`n") "`n", "debug.log")
    FileAppend("previous index:  `n" currentIndex "`n", "debug.log")

    modIndex := Mod(currentIndex + direction - 1, idList.Length)
    if (modIndex < 0) {
        modIndex += idList.Length
    }

    FileAppend("current mod index:  `n" modIndex "`n", "debug.log")
    currentIndex := modIndex + 1
    FileAppend("current index:  `n" currentIndex "`n", "debug.log")

    next_id := idList[currentIndex]
    WinActivate(next_id)
}

StrJoin(array, delimiter) {
    result := ""
    for index, element in array {
        if (index > 1) {
            result .= delimiter
        }
        result .= element
    }
    return result
}
