
const FALSE=0
const TRUE=1

importx "realpath" realpath

function fileentry(sd s,sd sz)
	call nullend(s,sz)
	sv temp
	setcall temp realpath(s,(NULL))
	if temp!=(NULL)
		sd len
		setcall len strlen(temp)
		sd b
		setcall b fileentry_exists(temp,len)
		if b==(FALSE)
			sd size=dword
			add size len
			sd ent
			setcall ent malloc(size)
			if ent!=(NULL)
				sd init
				set init ent
				#
				set ent# len
				add ent (dword)
				call memcpy(ent,temp,len)
				call free(temp)
				#
				sv fls%files_p
				sd mem=:
				add mem fls
				sd oldsize
				set oldsize mem#
				sd newsize=dword
				add newsize oldsize
				setcall temp realloc(fls#,newsize)
				if temp!=(NULL)
					set fls# temp
					set mem# newsize
					add temp oldsize
					set temp# init
					return (void)
				endif
				call free(init)
				call erExit("realloc error at files")
			endif
			call free(temp)
			call erExit("malloc error at files")
		endif
		call free(temp)
		return (void)
	endif
	call erExit("realpath error")
endfunction

function fileentry_exists(sd s,sd sz)
	sv fls%files_p
	sd p=:;add p fls
	set fls fls#;set p p#;add p fls
	while fls!=p
		sd b
		setcall b fileentry_compare(fls#,s,sz)
		if b==0
			return (TRUE)
		endif
		incst fls
	endwhile
	return (FALSE)
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
