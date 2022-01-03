

function uconst_add(sd s,sd sz)
	sd lvs%levels_p
	set lvs lvs#v^
	set lvs lvs#
	sv fls%files_p
	set fls fls#
	add fls lvs
	call uconst_spin(fls#,s,sz,(TRUE))
endfunction

function uconst_spin(sd f,sd s,sd sz,sd is_new)
	add f (size_cont_top)
	sd found
	setcall found uconst_search(f,s,sz,is_new)
	if found==(FALSE)
		add f (size_cont_top)
		call uconst_search(f,s,sz,is_new)
	endif
endfunction

#b
function uconst_search(sd *f,sd *s,sd *sz,sd *is_new)
	return (FALSE)
endfunction
