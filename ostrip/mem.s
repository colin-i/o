
importx "malloc" malloc
importx "free" free

#mem
function alloc(sd size)
	sd mem;setcall mem malloc(size)
	if mem!=(NULL)
		return mem
	endif
	call mError()
endfunction
function mError()
	call erMessage("malloc error")
endfunction
