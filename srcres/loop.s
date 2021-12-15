
const NULL=0
const void=0

importx "fopen" fopen
importx "fclose" fclose

function log_file(ss file)
#i all, f all; at end every f not i I, failure
#nm d;first c inside
#another log; files same; one c has some point in previous files same
#             decisions there
	call Message(file)
	sd f
	setcall f fopen(file,"r")
	if f!=(NULL)
		call fclose(f)
		return (void)
	endif
	call erMessage("fopen error")
endfunction
