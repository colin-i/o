
const FALSE=0
const TRUE=1

importx "realpath" realpath

const size_cont_top=dword+:
#const size_cont_top=:+dword

function fileentry_add(sd full,sd len)
	sd er
	sd size=size_cont_top+dword
	sd ent
	add size len
	setcall er malloc_throwless(#ent,size)
	if er==(NULL)
#sv init
		sd init
#
		set init ent
		#
		setcall er alloc_throwless(ent)
		if er==(NULL)
			add ent (size_cont_top)
			set ent# len
			add ent (dword)
			call memcpy(ent,full,len)
			#
			sv fls%files_p
#call incrementfiles()
#setcall er ralloc_throwless(fls,:)
#if er==(NULL)
#	sv cursor=-:
#	add cursor fls#
			sd mem
			set mem fls#d^
			call incrementfiles()
			setcall er ralloc_throwless(fls,:)
			if er==(NULL)
				sv cursor
				add fls (dword)
				set cursor fls#
				add cursor mem
#
				set cursor# init
				return (void)
			endif
#call free(init#)
			sv pointer=dword
			add pointer init
			call free(pointer#)
#
			call free(init)
			call free(full)
			call erExit(er)
		endif
		call free(init)
		call free(full)
		call erExit(er)
	endif
	call free(full)
	call erExit(er)
endfunction

function fileentry(sd s,sd sz)
	call nullend(s,sz)
	sd temp
	setcall temp realpath(s,(NULL))
	if temp!=(NULL)
		call fileentry_exists(temp)
		call free(temp)
		return (void)
	endif
	call erExit("realpath error")
endfunction

function fileentry_exists(sd s)
	sd sz
	setcall sz strlen(s)
	sv fls%files_p
	sv p
#set p fls#
#add fls :
#set fls fls#d^
#add fls p
#while p!=fls
#	sd b
#	setcall b fileentry_compare(p#,s,sz)
#	if b==0
#		call skip_set()
#		return (void)
#	endif
#	incst p
	set p fls#d^
	add fls (dword)
	set fls fls#
	add p fls
	while fls!=p
		sd b
		setcall b fileentry_compare(fls#,s,sz)
		if b==0
			call skip_set()
			return (void)
		endif
		incst fls
#
	endwhile
	call fileentry_add(s,sz)
endfunction

#cmp
function fileentry_compare(sd existent,sd new,sd sz)
	add existent (size_cont_top)
	if existent#!=sz
		return (~0)
	endif
	add existent (dword)
	sd c
	setcall c memcmp(existent,new,sz)
	return c
endfunction
