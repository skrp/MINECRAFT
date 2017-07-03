;  autohit
z::
    toggle := !toggle
	if (toggle) {
	SendInput {LButton Down}
	}
	else {
	SendInput {LButton Up}
	}
return

; autorun
x::
    toggle2 := !toggle2
	if (toggle2) {
	SendInput {d Down}
	sleep, 45
	SendInput {d Up}
	Sleep, 45
	SendInput {d Down}
	}
	else {
	SendInput {d Up}
	}
return

; KILL
~::ExitApp
