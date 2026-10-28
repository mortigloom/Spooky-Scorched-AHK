#Requires AutoHotkey v2.0
#SingleInstance Force
#MaxThreadsPerHotkey 1

; Each press is atomic: key down, 50 ms hold, key up.
; F1 pauses the pending 600 ms wait and preserves the next key.
SendMode "Event"
SetKeyDelay -1, -1
running := false
nextKey := "e"
remainingMs := 1
dueAt := 0
A_IconTip := "Spooky Scorched Chat - PAUSED (F1)"
OnExit ReleaseKeys

$F1:: {
    ToggleMacro()
    KeyWait "F1"  ; Holding F1 must not toggle repeatedly.
}

ToggleMacro() {
    global running, remainingMs, dueAt
    Critical "On"
    if running {
        SetTimer PressNext, 0
        remainingMs := Max(1, dueAt - A_TickCount)
        running := false
        A_IconTip := "Spooky Scorched Chat - PAUSED (F1)"
    } else {
        running := true
        dueAt := A_TickCount + remainingMs
        SetTimer PressNext, -remainingMs
        A_IconTip := "Spooky Scorched Chat - RUNNING (F1)"
    }
    Critical "Off"
}

PressNext() {
    global running, nextKey, remainingMs, dueAt
    Critical "On"
    if !running
        return
    key := nextKey
    try {
        SendEvent "{" key " down}"
        Sleep 50
    } finally {
        SendEvent "{" key " up}"
    }
    nextKey := (key = "e") ? "Space" : "e"
    remainingMs := 600
    dueAt := A_TickCount + remainingMs
    SetTimer PressNext, -remainingMs
    Critical "Off"
}

ReleaseKeys(*) {
    SendEvent "{e up}{Space up}"
}
