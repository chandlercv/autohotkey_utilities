SetTitleMatchMode(2)

global idList := []
global currentIndex := 0
global currentProcess := ""

; Hotkey to cycle through windows (Alt + `)
!`:: {
    ;FileAppend("Alt ` pressed`n", "debug.log")
    CycleWindows(1)
}

; Hotkey to cycle through windows in reverse (Alt + Shift + `)
+!`:: {
    ;FileAppend("Shift Alt ` pressed`n", "debug.log")
    CycleWindows(-1)
}

CycleWindows(direction) {
    global idList, currentIndex, currentProcess

    ; Get the process name of the currently active window
    activeProcess := WinGetProcessName("A")

    ; Get a list of all windows belonging to the same process
    idListTemp := WinGetList("ahk_exe " activeProcess)

    ; If the list is empty or the process has changed, update the list
    if (idList.Length = 0 || activeProcess != currentProcess || !ArraysEqual(idList, idListTemp)) {
        ;FileAppend("Clearing the list `n", "debug.log")
        ; Clear the list
        idList := []
        currentIndex := 0
        currentProcess := activeProcess

        ; Get a list of all windows belonging to the same process
        ; idListTemp := WinGetList("ahk_exe " activeProcess)

        ; Populate the global list
        for id in idListTemp {
            idList.Push(id)
        }
    }

    ; If the list is still empty, return
    if (idList.Length = 0)
        return

    ; Move to the next window in the list
    ; FileAppend("idList contents:`n" StrJoin(idList, "`n") "`n", "debug.log")
    ; FileAppend("previous index:  `n" currentIndex "`n", "debug.log")

    modIndex := Mod(currentIndex + direction - 1, idList.Length)
    if (modIndex < 0) {
        modIndex += idList.Length
    }

    ; FileAppend("current mod index:  `n" modIndex "`n", "debug.log")
    currentIndex := modIndex + 1
    ; FileAppend("current index:  `n" currentIndex "`n", "debug.log")

    next_id := idList[currentIndex]
    if WinExist(next_id) {
        WinActivate(next_id)
        WinSetTransparent(200, next_id) ; Set the window transparency to 200 (0-255, where 0 is fully transparent and 255 is fully opaque)
        Sleep(250) ; Wait for 500 milliseconds
        WinSetTransparent(255, next_id) ; Reset the window transparency to fully opaque
    }
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

ArrayContains(array, value) {
    for index, element in array {
        if (element = value) {
            return true
        }
    }
    return false
}

ArrayRemove(array, value) {
    for index, element in array {
        if (element = value) {
            array.RemoveAt(index)
            return
        }
    }
}

ArraysEqual(array1, array2) {
    tmpArray1 := array1.clone()
    tmpArray2 := array2.clone()
    ;FileAppend("array1 contents:`n" StrJoin(tmpArray1, "`n") "`n", "debug.log")
    ;FileAppend("array2 contents:`n" StrJoin(tmpArray2, "`n") "`n", "debug.log")
    if (tmpArray1.Length != tmpArray2.Length) {
        ;FileAppend("Array length not equal `n", "debug.log")
        return false
    }
    for index, value in array1 {
        ;FileAppend("Checking value: " value "`n", "debug.log")
        if (ArrayContains(array2, value)) {
            ;FileAppend("Removing value: " value "`n", "debug.log")
            ArrayRemove(tmpArray1, value)
            ArrayRemove(tmpArray2, value)
        }
        else {
            ;FileAppend("Array2 missing value `n", "debug.log")
            return false
        }
    }
    if (tmpArray1.Length > 0) {
        ;FileAppend("Array1 elements left over `n", "debug.log")
        ;FileAppend("array1 contents:`n" StrJoin(tmpArray1, "`n") "`n", "debug.log")
        ;FileAppend("array2 contents:`n" StrJoin(tmpArray2, "`n") "`n", "debug.log")
        return false
    }
    if (tmpArray2.Length > 0) {
        ;FileAppend("Array2 elements left over `n", "debug.log")
        ;FileAppend("array1 contents:`n" StrJoin(tmpArray1, "`n") "`n", "debug.log")
        ;FileAppend("array2 contents:`n" StrJoin(tmpArray2, "`n") "`n", "debug.log")
        return false
    }
    return true
}
