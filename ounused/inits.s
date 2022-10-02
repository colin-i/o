
importx "get_current_dir_name" get_current_dir_name
importx "strlen" strlen

include "./mem.s"

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
	sd size=:
	add size cwd
	sd sz
	setcall sz strlen(cwd#)
	inc sz
	set size# sz
	call ralloc(cwd,(dword))
	set cwd cwd#
	add cwd sz
	set cwd#d^ sz
	#sv cursor=dword;add cursor cwd;setcall cursor# get_current_dir_name();if cursor#==(NULL);call erExit("get_current_dir_name error");endif;sd size;setcall size strlen(cursor#);inc size;set cwd#d^ size;call ralloc(cwd,(dword));set cursor cursor#;add cursor size;set cursor#d^ size
	sv fls%files_p
	call alloc(fls)
	sv lvs%levels_p
	call alloc(lvs)
endfunction
