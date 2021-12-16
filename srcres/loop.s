
const NULL=0
const void=0

importx "fopen" fopen
importx "fclose" fclose
importx "getline" getline
importx "feof" feof
importx "free" free

function freeall()
	value logf#1
	const logf_p^logf
	call fclose(logf)
	value logf_mem#1
	const logf_mem_p^logf_mem
	if logf_mem!=(NULL)
		call free(logf_mem)
	endif
endfunction

function log_file(ss file)
	call Message(file)
	sd f
	setcall f fopen(file,"r")
	if f!=(NULL)
		sv fp%logf_p
		set fp# f
		sv p%logf_mem_p
		set p# 0
		sd sz=0
		while sz!=-1
			sd bsz
			setcall sz getline(p,#bsz,f)
			if sz!=-1
				#knowing line\r\n from ocompiler
				sub sz 2
				call log_line(p#,sz)
			else
				sd e
				setcall e feof(f)
				if e==0
					call erExit("get line error")
				endif
			endelse
		endwhile
		call freeall()
		return (void)
	endif
	call erMessage("fopen error")
endfunction

function log_line(ss s,ss sz)
#i all, f all; at end every f not i I, failure
#nm d;first c inside
#another log; files same; one c has some point in previous files same
#             decisions there
	add sz s
	set sz# 0
	call Message(s)
endfunction
