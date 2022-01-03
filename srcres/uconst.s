

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
	#search in includes declared in other logs
	sd found
	setcall found uconst_search(f,s,sz,(FALSE))
	if found==(FALSE)
		#search in includes declared this log
		add f (size_cont_top)
		call uconst_search(f,s,sz,is_new)
	endif
	#search in constants declared in this file, with respect to is_new
endfunction

#b
function uconst_search(sv fs,sd *s,sd *sz,sd *is_new)
#	sd cursor
#	set cursor fs#
	add fs :
#	set fs fs#d^
#	add fs cursor
#	while cursor!=fs
#		add cursor (dword)
#	endwhile
	return (FALSE)
endfunction
