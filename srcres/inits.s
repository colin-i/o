
include "./mem.s"

function inits()
	value logf#1
	const logf_p^logf
	set logf (NULL)
	value logf_mem#1
	const logf_mem_p^logf_mem
	set logf_mem (NULL)
	value imp_mem#1;data *#1
	const imp_mem_p^imp_mem
	set imp_mem (NULL)
	value fn_mem#1;data *#1
	const fn_mem_p^fn_mem
	set fn_mem (NULL)
endfunction

function allocs()
	sv ip%imp_mem_p
	call alloc(ip)
	sv fp%fn_mem_p
	call alloc(fp)
endfunction

function freeall()
	call logclose()
	sv ip%imp_mem_p
	if ip#!=(NULL)
		call free(ip#)
	endif
	sv fp%fn_mem_p
	if fp#!=(NULL)
		call free(fp#)
	endif
endfunction

function logclose()
	sv fp%logf_p
	if fp#!=(NULL)
		call fclose(fp#)
		set fp# (NULL)
		sv p%logf_mem_p
		if p#!=(NULL)
			call free(p#)
			set p# (NULL)
		endif
	endif
endfunction
