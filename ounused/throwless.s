
#mem

function malloc_throwless(sv p,sd sz)
	setcall p# malloc(sz)
	if p#!=(NULL)
		return (NULL)
	endif
	return "malloc error"
endfunction
function alloc_throwless(sd p)
	sd er
	setcall er malloc_throwless(p,0)
	if er==(NULL)
		add p :
		set p# 0
		return (NULL)
	endif
	return er
	#set p# 0;add p (dword);sd er;setcall er malloc_throwless(p,0);return er
endfunction
#function ralloc_throwless(sd p,sd sz);add sz p#;if sz>0;sv cursor=dword;add cursor p;setcall cursor# realloc(cursor#,sz);if cursor#!=(NULL);set p# sz
function ralloc_throwless(sv p,sd sz)
	sd cursor=:
	add cursor p
	add sz cursor#
	if sz>0
		setcall p# realloc(p#,sz)
		if p#!=(NULL)
			set cursor# sz
			return (NULL)
		endif
		return "realloc error"
	elseif sz==0  #equal 0 discovered at decrementfiles, since C23 the behaviour is undefined
	#using this quirk, lvs[0] will be used at constants at end, when size is 0
		#set p# 0
		set cursor# 0
		return (NULL)
	endelseif
	return "realloc must stay in 31 bits"
endfunction

#-1/offset
function pos_in_cont(sv cont,ss s,sd sz)
	sd p
	sd mem=:
	set p cont#
	add mem cont
	set mem mem#
	add mem p
	#set mem cont#d^;add cont (dword);set p cont#;add mem p
	while p!=mem
		sd len
		set len p#
		add p (dword)
		if len==sz
			sd c
			setcall c memcmp(s,p,sz)
			if c==0
				sub p cont#
				sub p (dword)
				return p
			endif
		endif
		add p len
	endwhile
	return -1
endfunction

#inits

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
	value files#1;data files_d#1
	const files_p^files
	const files_dp^files_d
	set files (NULL)
	value levels#1;data levels_d#1
	const levels_p^levels
	const levels_dp^levels_d
	set levels (NULL)
	call uconst_resolved(0)
endfunction

function uconst_resolved(sd t,sd size)
	data nr#1
	if t==0
		set nr 0
	elseif t==1
		div size (dword)
		add nr size
	else
		return nr
	endelse
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
					call freefiles()
					sv lvs%levels_p
					if lvs#!=(NULL)
						call free(lvs#)
						call logclose()
					endif
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

#files

function freefiles()
	#sv container%files_p;sv cursor;set cursor container#d^;add container (dword);set container container#;add cursor container;while container!=cursor;decst cursor;sv consts=dword;add consts cursor#;call free(consts#);call free(cursor#);endwhile;call free(cursor)
	sv container%files_p
	sv start
	set start container#
	add container :
	set container container#d^
	add container start
	while start!=container
		decst container
		call fileentry_uninit(container#)
		call free(container#)
	endwhile
	call free(container)
endfunction
function fileentry_uninit(sd cont)
	sd b;set b cont;add b (size_conts)
	call fileentry_uninit_base(cont,b)
endfunction
function fileentry_uninit_base(sd cont,sv cursor)
	while cont!=cursor
		sub cursor (size_cont)
		call free(cursor#)
	endwhile
endfunction

#er
function fileentry_init(sd cont)
	sd a;set a cont
	sd b;set b cont;add b (size_conts)
	while cont!=b
		sd er
		setcall er alloc_throwless(cont)
		if er!=(NULL)
			call fileentry_uninit_base(a,cont)
			return er
		endif
		add cont (size_cont)
	endwhile
	return (NULL)
endfunction

#cmp
function fileentry_compare(sd existent,sd new,sd sz)
	add existent (size_conts)
	if existent#!=sz
		return (~0)
	endif
	add existent (dword)
	sd c
	setcall c memcmp(existent,new,sz)
	return c
endfunction

include "skip.s"

#const

#cont
function working_file()
	sv lvs%levels_p
	sd lvsd%levels_dp
	sv p=-dword
	add p lvsd#
	add p lvs#
	set p p#d^
	sv fls%files_p
	add p fls#
	#sv lvs%levels_p;sv p=-dword;add p lvs#d^;add lvs (dword);add p lvs#;set p p#d^;sv fls%files_vp;add p fls#
	return p#
endfunction

#sz
function filessize()
	sd fls%files_dp
	return fls#
	#sd fls%files_p;set fls fls#;return fls
endfunction

#sz
function constssize()
	sv end%files_p
	sv cursor
	set cursor end#
	add end :
	set end end#d^
	add end cursor
	#sv cursor%files_p;sd end;set end cursor#d^;add cursor (dword);set cursor cursor#;add end cursor
	sd sz=0
	while cursor!=end
		addcall sz constssize_file(cursor#)
		incst cursor
	endwhile
	return sz
endfunction
#sz
#function constssize_file(sd cursor);sd end;set end cursor#;add cursor (dword);set cursor cursor#v^;add end cursor
function constssize_file(sv end)
	sd cursor
	set cursor end#
	add end :
	set end end#d^
	add end cursor
	sd sz=0
	while cursor!=end
		add cursor cursor#
		add cursor (dword)
		inc sz
	endwhile
	return sz
endfunction

#uconst

function root_file()
	sd lvs%levels_p
	set lvs lvs#v^
	set lvs lvs#
	sv fls%files_p
	set fls fls#
	add fls lvs
	return fls#
endfunction

#loop

function nullend(ss s,sd sz)
	add s sz;set s# 0 #this is on carriage return
endfunction

#resolve

function importssize()
	sv cont%imp_mem_p
	sd p
	sd mem
	set p cont#
	add cont :
	set mem cont#d^
	add mem p
	#set mem cont#d^;add cont (dword);set p cont#;add mem p
	sd i=0
	while p!=mem
		add p p#
		add p (dword)
		inc i
	endwhile
	return i
endfunction
