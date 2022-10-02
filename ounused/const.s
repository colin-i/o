
function constant_add(sd s,sd sz)
	sv p
	setcall p working_file()
	call addtocont(p,s,sz)
endfunction

#previous file
function incrementfiles()
	sd cursor%levels_dp
	set cursor cursor#
	sd pf
	if cursor==0
		set pf (NULL)
	else
		setcall pf working_file()
	endelse
	sv lvs%levels_p
	call ralloc(lvs,(dword))
	add cursor lvs#
	#sd cursor;set cursor lvs#d^;call ralloc(lvs,(dword));add lvs (dword);add cursor lvs#
	setcall cursor# filessize()
	return pf
endfunction

function decrementfiles()
	sd lvs%levels_p
	call ralloc(lvs,(-dword))
endfunction
