
importx "get_current_dir_name" get_current_dir_name
importx "strlen" strlen

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
	value cwd#1;data *#1
	const cwd_p^cwd
	set cwd (NULL)
	value files#1;data *#1
	const files_p^files
	set files (NULL)
endfunction

function allocs()
	sv ip%imp_mem_p
	call alloc(ip)
	sv fp%fn_mem_p
	call alloc(fp)
	#
	sv cwd%cwd_p
	setcall cwd# get_current_dir_name()
	if cwd#==(NULL)
		call erExit("get_current_dir_name error")
	endif
	sd sz=:
	add sz cwd
	setcall sz# strlen(cwd#)
	inc sz#
	set sz sz#
	call ralloc(cwd,(dword))
	sd p;set p cwd#;add p sz;set p# sz
	#
	sv fls%files_p
	call alloc(fls)
endfunction

function freeall()
	sv ip%imp_mem_p
	if ip#!=(NULL)
		call free(ip#)
		sv fp%fn_mem_p
		if fp#!=(NULL)
			call free(fp#)
			sv cwd%cwd_p
			if cwd#!=(NULL)
				call free(cwd#)
				sv fls%files_p
				if fls#!=(NULL)
					call freefiles(fls)
					call logclose()
				endif
			endif
		endif
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

function freefiles(sv cont)
	sd mem=:
	add mem cont
	set cont cont#
	set mem mem#
	add mem cont
	sv init
	set init cont
	while cont!=mem
		call free(cont#)
		incst cont
	endwhile
	call free(init)
endfunction
