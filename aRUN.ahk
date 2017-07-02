x::
    toggle2 := !toggle2
	if (toggle2) {
	SendInput {w Down}
	sleep, 45
	SendInput {w Up}
	Sleep, 45
	SendInput {w Down}
	}
	else {
	SendInput {w Up}
	}
return
