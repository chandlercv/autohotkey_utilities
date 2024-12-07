#Persistent
SetTitleMatchMode, 2

global idList := []
global currentIndex := 0

; Hotkey to cycle through windows (Alt + `)
!`::
    ; Get the process name of the currently active window
    WinGet, activeProcess, ProcessName, A

    ; Get a list of all windows belonging to the same process
    WinGet, idListTemp, List, ahk_exe %activeProcess%

    ; If the list is empty or the process has changed, update the list
    if (idList.MaxIndex() = 0 || activeProcess != currentProcess )
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

; Hotkey to cycle through windows (Alt + `)
+!`::
    ; Get the process name of the currently active window
    WinGet, activeProcess, ProcessName, A

    ; Get a list of all windows belonging to the same process
    WinGet, idListTemp, List, ahk_exe %activeProcess%

    ; If the list is empty or the process has changed, update the list
    if (idList.MaxIndex() = 0 || activeProcess != currentProcess || !CompareWindowLists(idList, idListTemp) )
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
    currentIndex := currentIndex - 1
    if (currentIndex < 1)
        currentIndex := idList.MaxIndex()
    next_id := idList[currentIndex]
    WinActivate, ahk_id %next_id%
return

; Function to compare two window lists
CompareWindowLists(list1, list2)
{
    if (list1.Length() != list2.Length())
        return false

    for index, value in list1
    {
        if (value != list2[index])
            return false
    }
    return true
}