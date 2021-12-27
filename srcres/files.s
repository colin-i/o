
const FALSE=0
const TRUE=1

importx "realpath" realpath

function fileentry_add(sd full,sd len)
	sd er
	sd size=dword
	sd ent
	add size len
	setcall er malloc_throwless(#ent,size)
	if er==(NULL)
		sd init
		set init ent
		#
		set ent# len
		add ent (dword)
		call memcpy(ent,full,len)
		#
		sv fls%files_p

#		sd mem
#		set mem fls#d^

		sd mem=:
		add mem fls
		set mem mem#

		call incrementfiles()
		setcall er ralloc_throwless(fls,:)
		if er==(NULL)
			sv cursor

#			add fls (dword)

			set cursor fls#
			add cursor mem
			set cursor# init
			return (void)
		endif
		call free(full)
		call free(init)
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

#	sv fls%files_p
#	sv p
#	set p fls#d^
#	add fls (dword)
#	set fls fls#
#	add p fls

	sv cont%files_p
	sv fls
	set fls cont#
	sd p
	add cont :
	set p cont#d^
	add p fls
	while fls!=p
		sd b
		setcall b fileentry_compare(fls#,s,sz)
		if b==0
			call skip_set()
			return (void)
		endif
		incst fls
	endwhile
	call fileentry_add(s,sz)
endfunction

#cmp
function fileentry_compare(sd existent,sd new,sd sz)
	if existent#!=sz
		return (~0)
	endif
	add existent (dword)
	sd c
	setcall c memcmp(existent,new,sz)
	return c
endfunction
