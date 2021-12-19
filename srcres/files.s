
const FALSE=0
const TRUE=1

importx "realpath" realpath

function fileentry(sd s,sd sz)
	sd b
	setcall b fileentry_exists(s,sz)
	if b==(FALSE)
		setcall sz nullend(s,sz)
		add sz (dword)
		sd ent
		setcall ent m_alloc(sz)
		sd p;set p ent;add p (dword)
		sd temp
		setcall temp realpath(s,p)
		if temp!=(NULL)
			dec sz #ignoring null end
			set ent# sz
			sv fls%files_p
			call addtocont_value(fls,ent)
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
