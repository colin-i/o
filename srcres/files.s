
const FALSE=0
const TRUE=1

importx "realpath" realpath

function fileentry(sd s,sd sz)
	call nullend(s,sz)
	sd temp
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
			setcall ent m_alloc(size)
			set ent# len
			sv fls%files_p
			call addtocont_value(fls,ent)
			add ent (dword)
			call memcpy(ent,temp,len)
			return (void)
		endif
		call erExit("realpath error")
	endif
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
