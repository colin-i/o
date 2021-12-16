
importx "malloc" malloc
importx "realloc" realloc
importx "memcpy" memcpy

function alloc(sv p)
	setcall p# malloc(1)
	if p#==(NULL)
		call erExit("malloc error")
	endif
endfunction

function ralloc(sv p,sd sz)
	setcall p# realloc(p#,sz)
	if p#==(NULL)
		call erExit("realloc error")
	endif
endfunction

function addtocont(sv cont,ss s,sd sz)
	#knowing ocompiler maxvaluecheck
	sd size=4
	add size sz
	call ralloc(cont,size)
	sd mem
	set mem cont#
	set mem# sz
	add mem 4
	call memcpy(mem,s,sz)
endfunction
