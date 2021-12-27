


function constant_add(sd *s,sd *sz)
endfunction

function incrementfiles()
	sv lvs%levels_p
	sd cursor
	set cursor lvs#d^
	call ralloc(lvs,(dword))
	add lvs (dword)
	add cursor lvs#
	setcall cursor# filessize()
endfunction

function decrementfiles()
	sd lvs%levels_p
	call ralloc(lvs,(-dword))
endfunction

#sz
function filessize()
	sd fls%files_p
	set fls fls#
	div fls :
	return fls
endfunction
